package boer::Qooxdoo;

use strict;
use warnings;
use ADBGUI::BasicVariables;
use ADBGUI::Tools qw(Log);
use POE;

our @ISA;

sub new
{
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = shift;
   my $parent = $self ? ref($self) : "";
   @ISA = ($parent) if $parent;
   $self = $self ? $self : {};
   bless ($self, $class);
   return $self;
}

sub onAuthenticated {
    my $self       = shift;
    my $options    = shift;
    my $moreparams = shift || 0;

    unless ( ( !$moreparams )
        && $options->{curSession}
        && $options->{connection} )
    {
        Log(
            "In onAuthenticated: Missing parameters: curSession:"
              . $options->{curSession}
              . "connection:"
              . $options->{connection} . ": !",
            $ERROR
        );
        return undef;
    }

    my $return = $self->SUPER::onAuthenticated($options);

    # show the projects button, to open table for projects
    # only show this button if user is not admin
    if (
        defined(
            my $err =
              $self->{dbm}->checkRights( $options->{curSession}, $ADMIN )
        )
      )
    {
        $poe_kernel->yield( sendToQX => "addbutton "
              . CGI::escape("") . " "
              . CGI::escape("games_button") . " "
              . CGI::escape("Games") . " "
              . CGI::escape("") . " "
              . CGI::escape("job=show,table=Game") );

        $poe_kernel->yield( sendToQX => "addbutton "
              . CGI::escape("") . " "
              . CGI::escape("players_button") . " "
              . CGI::escape("Spieler_verwalten") . " "
              . CGI::escape("") . " "
              . CGI::escape("job=show,table=Player") );
    }

    # display the projects table per default after login
    $self->onShow(
        {
            table      => "Game",
            curSession => $options->{curSession},
            connection => $options->{connection}
        }
    );

    # return the return value of the corresponding underliying framework method
    return $return;
}

sub onSaveEditEntry
{
    my $self       = shift;
    my $options    = shift;
    my $moreparams = shift;

    unless ( ( !$moreparams )
        && $options->{curSession}
        && $options->{table}
        && $options->{"q"}
        && $options->{oid}
        && $options->{connection} )
    {
        Log(
            "onSaveEditEntry: Missing parameters: table:"
              . $options->{table}
              . ":curSession:"
              . $options->{curSession} . ": !",
            $ERROR
        );
        return undef;
    }

    # enable autoclosing of the window when save button is preesed
    $options->{close}++;

    my $return_value = $self->SUPER::onSaveEditEntry( $options, $moreparams );
    return $return_value;
}

1;
