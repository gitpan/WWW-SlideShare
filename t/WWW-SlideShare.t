# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl WWW-SlideShare.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use Test::More tests => 10;
BEGIN { use_ok('WWW::SlideShare') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

my $ss = WWW::SlideShare->new('api_key' => '2C2y6buG', 'secret' => 'vUMu5xmo');
ok (ref $ss, "Object creation");

my $slide = $ss->get_slideshow({ 'slideshow_id' => 4383743 });
ok($slide->ID == 4383743, "get_slideshow() by id");

$slide = $ss->get_slideshow({ 'slideshow_url' => 'http://www.slideshare.net/ashishm001/homeashishintest-slides' });
ok($slide->ID == 4383743, "get_slideshow() by url");

$slide = $ss->get_slideshows_by_tag({ tag => 'linux', limit => 2 });
ok(scalar @$slide == 2 && $slide->[0]->ID =~ /\d+/, "get_slideshows_by_tag()");

$slide = $ss->get_slideshows_by_user({ 'username_for' => 'ashishm001', 'detailed' => 0 });
ok($slide->[0]->ID == 4383743, "get_slideshows_by_user()");

$slide = $ss->search_slideshows({ 'q' => 'hadoop hive', 'page' => 2, 'items_per_page' => 1 });
ok((scalar @$slide == 1) && $slide->[0]->ID =~ /\d+/, "search_slideshows()");

my $gps = $ss->get_user_groups({ 'username_for' => 'ashishm001' });
ok($gps->[0]->URL =~ /.*/, "get_user_groups()");

my $con = $ss->get_user_contacts({ 'username_for' => 'ashishm001' });
ok(scalar @$con == 0, "get_user_contacts()");

my $tag = $ss->get_user_tags({ 'username' => 'ashishm001', 'password' => 'valium' });
ok(scalar @$tag == 3 && $tag->[0]->Tag ne '', "get_user_tags()");
