package HTML::FormHandlerX::Form::JQueryValidator;
use strict;
use warnings;

=head1 NAME

HTML::FormHandlerX::Form::JQueryValidator - Perl trait for HTML::FormHandler and JQuery Validator

=head1 VERSION

0.01

=cut

our $VERSION = '0.01';


use JSON;
use URI::Escape;


=head1 SYNOPSIS

 use HTML::FormHandler::Moose;

 with HTML::FormHandlerX::Form::JQueryValidator;

 ...

 $form->to_jquery_validation_profile();

 ....

 <input type="hidden" id="validation_rules_escaped_json" value="[% form.as_escaped_json %]">

=head1 DESCRIPTION

This perl role allows you to re-use some form validation rules with the
 JQuery Validation plugin (http://docs.jquery.com/Plugins/Validation)

=cut

=head1 METHODS

=head2 to_jquery_validation_profile

=cut

sub to_jquery_validation_profile {
    my $self = shift;

    my $js_profile = { rules => {}, messages => {} };
    foreach my $field ( @{$self->fields}) {
        if ($field->required) {
        $js_profile->{rules}{$field->id} = { required => 1  };
            $js_profile->{messages}{$field->id} = $field->name . ' is required';
        }
    }
    return $js_profile;
}

=head2 as_escaped_json

=cut

sub as_escaped_json {
    my $self = shift;
    my $js_profile = $self->to_jquery_validation;
    return uri_escape_utf8(JSON->new->encode($js_profile)),
}


=head1 SEE ALSO

=head1 AUTHOR

Aaron Trevena, E<lt>teejay@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2012 by Aaron Trevena

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.0 or,
at your option, any later version of Perl 5 you may have available.


=cut
