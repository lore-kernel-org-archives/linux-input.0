From: "Zach C." <fxchip@gmail.com>
Subject: Strange input device identification
Date: Sun, 26 May 2013 00:11:54 -0700
Message-ID: <CAG5DJwcu=Z6Jh4ad0rS-GLv_zPV=HbdyotJLRzdcHCQC2nwJzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:58326 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759085Ab3EZHLz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 26 May 2013 03:11:55 -0400
Received: by mail-vc0-f174.google.com with SMTP id hr11so4003617vcb.19
        for <linux-input@vger.kernel.org>; Sun, 26 May 2013 00:11:54 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hey everyone,

I wasn't entirely sure if there was a better place to ask such a
question, but I figured this might be as good a place as any for a
question like this -- if not, please kindly let me know who I should
ask or even if I should Google better.

I am using a laptop (specifically the Razer Blade R2), and the
keyboard and mouse share one USB device, differentiating each input by
interface. By default (i.e. when essentially not touched at all), the
trackpad emulates a standard USB HID pointer (with incidental
implementations of certain gestures in-hardware -- pinch-to-zoom will
send button 4 or 5, for instance) and the keyboard a standard USB HID
keyboard. There are four interfaces in total, however: trackpad on 0,
keyboard on 2, "extras" on 1, and vendor-specific bulk-write endpoints
on 3.

I say "emulates" because it does a very curious thing when the
trackpad interface (0) is set to the USB alternate setting of 1: any
pretense of being HID inputs for keyboard OR mouse is completely
dropped -- yes, even despite the keyboard being on a separate
interface. Keyboard input begins routing via the "extras" interface on
1 rather than coming in from 2, and while it still looks like HID to
my rather untrained eye, there are actually several more spaces for
keypresses (for the keyboard -- 14 spaces total plus modifier byte for
ctrl/alt/etc) and it appears report IDs (or at least, some sort of ID
corresponding to the input being done) start being prepended to the
incoming data. "Extras" also begins differentiating which macro keys
-- the display-backed keys above the touchpad -- have been pressed (it
does not do this in HID mode) and begins to send input for the Fn and
Razer logo keys.

The trackpad's enhanced input seems to consist of five structures per
packet, one for each finger, and the last four are prepended with a
byte whose lower half indicates which finger is being reported and
whose higher half indicates how many fingers total are being used. The
structure itself seems to be laid out (in hex): 1P BB XX XX YY YY UU
-- where P *might be* pressure or width, B is mouse button pressed
(and does carry through to all fingers), X and Y are X and Y
coordinates of the finger in big-endian quadrant-1 (higher Y == closer
to top, higher X == closer to right), and I haven't been able to
figure out U yet. After the five structures (which are terminated with
a byte reading x4 -- where "x" in this case is the number of fingers),
there appear to be 24 more bytes that don't ever seem to be anything
other than 0.

Otherwise, both keyboard and extras "enhanced input" just seem to
report for two different keyboards. If I mash my palm on the touchpad,
though, I get an apparent report ID of 0x05 with some other data that
I'm not sure how to interpret, I assume it's telling me exactly what
I'm doing but nothing more specific than that.

Has anyone seen an input device like this before? I've also written a
test program which can be found at
http://fxchip.net/RazerBlade/razer-test.tar.bz2 , but it's sort of
rough in a lot of ways.

If you're interested in the report descriptors, as well, here's a link
to my lsusb -vv -d 1532:0116 output with usbhid detached:
http://pastie.org/7961204 -- if you'd prefer it inline I might be able
to do that too.

Thanks in advance,

Zach
