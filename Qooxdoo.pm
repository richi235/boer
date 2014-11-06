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
