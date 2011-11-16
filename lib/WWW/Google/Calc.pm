package WWW::Google::Calc;
use strict;
use warnings;
use WWW::Mechanize;
use Web::Scraper;
use URI;

our $VERSION = '1.0.0';

sub new {
	my $self = shift->SUPER::new(@_);

	$self->mech(
		do {
			my $mech = WWW::Mechanize->new(agent => "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:9.0) Gecko/20100101 Firefox/9.0");

			$mech;
		}
	);

	$self;
}

sub calc {
	my ( $self, $query ) = @_;

	my $url = URI->new('http://www.google.co.jp/search');
	$url->query_form(q => $query,
					 hl => 'ja');

	$self->mech->get($url);
	if($self->mech->success) {
		return $self->parse_html($self->mech->content);
	} else {
		$self->error('Page fetching failed: ' . $self->mech->res->status_line);
		return;
	}
}

sub parse_html {
	my ( $self, $html ) = @_;

	my $scraper = scraper {
		process '#topstuff table.std h2 b', result => 'TEXT'
	};
	my $result = $scraper->scrape($html);

	my $res;
	if($result->{result}) {
		$res = $result->{result};
	}

	$res;
}

1;
__END__

=head1 NAME

WWW::Google::Calc -

=head1 SYNOPSIS

  use WWW::Google::Calc;

  $calc = WWW::Google::Calc->new();

  print $calc->calc('$100 in yen');
  print $calc->calc('100 / 3');

=head1 DESCRIPTION

WWW::Google::Calc is

=head1 AUTHOR

eru.tndl E<lt>eru.tndl@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
