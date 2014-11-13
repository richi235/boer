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

    return $self->SUPER::checkRights( $session, $rights, $table, $id );
}


1;
