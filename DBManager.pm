package boer::DBManager;

use strict;
use warnings;
use ADBGUI::BasicVariables;
use ADBGUI::Tools qw(Log);

use Data::Dumper;


our @ISA;

sub new {
    my $proto  = shift;
    my $class  = ref($proto) || $proto;
    my $self   = shift;
    my $parent = $self ? ref($self) : "";
    @ISA = ($parent) if $parent;
    $self = $self ? $self : {};
    bless( $self, $class );
    return $self;
}

sub checkRights
{
    my $self    = shift;
    my $session = shift;
    my $rights  = shift;            # what we are asked for, if it's allowed
    my $table   = shift || undef;
    my $id      = shift || undef;

    # print( "\n\e[31;1m" . Dumper($session, $rights, $table, $id) . "\e[0m\n"  );

    if ( $rights & $NOTHING ) {
        return undef;
    }

    if ( defined($table) )          #all the following tests are table specific
    { # only test, if we are asked table speciic things and therefore a table is defined in the checkRights Request

        # this enables clients to create new users without beeing logged in
        if (   ( $rights & ( $ACTIVESESSION | $MODIFY ) )
            && ( $table eq 'users' )
            && !$id )
        {
            return undef;
        }

        # if we are asked for the modify right on table 'Game' in an active session
        # this happens if a user wants to add new Game or change a existing one
        if (   ( $table eq 'Game' )
            && ( $rights & $MODIFY )
            && !defined( $self->SUPER::checkRights( $session, $ACTIVESESSION ) )
           )
        {  return undef;  }

        
        # if we are asked for the modify right on table 'Player_Won_in_game' in an active session
        # this happens if a user wants to add a new stat or change an existing one
        if (   ( $table eq 'Player_Won_in_game' )
            && ( $rights & $MODIFY )
            && !defined( $self->SUPER::checkRights( $session, $ACTIVESESSION ) )
           )
        {  return undef;  }


        # if we are asked for the modify right on table 'Player' in an active session
        # this happens if a user wants to add new Player or change a existing one
        if (   ( $table eq 'Player' )
            && ( $rights & $MODIFY )
            && !defined( $self->SUPER::checkRights( $session, $ACTIVESESSION ) )
           )
        {  return undef;  }
    }

    return $self->SUPER::checkRights( $session, $rights, $table, $id );
}


1;
