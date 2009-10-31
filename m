From: James Mastros <james@mastros.biz>
Subject: Re: [rfc] xbox360 Big-button controller support for xpad.c
Date: Sat, 31 Oct 2009 12:01:33 +0000
Message-ID: <abc933c50910310501k4c16cd18qdc851c88b8216fea@mail.gmail.com>
References: <abc933c50910270426l5091227cw9f261099b9c62109@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f226.google.com ([209.85.217.226]:33994 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757588AbZJaMIm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Oct 2009 08:08:42 -0400
Received: by gxk26 with SMTP id 26so1161606gxk.1
        for <linux-input@vger.kernel.org>; Sat, 31 Oct 2009 05:08:47 -0700 (PDT)
In-Reply-To: <abc933c50910270426l5091227cw9f261099b9c62109@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

[This doesn't appear to have made it to the list the first time I sent
it, so I'm resending.  My appologies if you recieve it more then
once.]

Hello, all,

The attached (RFC!) patch adds support for the xbox 360 big-button
controllers to xpad.c. =C2=A0These seem to be a set of four large CIR
remote controls, with a USB receiver that speaks a modified version of
the normal xbox360 usb remote protocol.

http://en.wikipedia.org/wiki/Xbox_360_accessories#Big_Button_Pad has a
decent image. =C2=A0You can get a set for about 12GBP, including a game
disk for Scene It (which I haven't even removed the shrink-wrap for,
since I don't actually own a 360). =C2=A0The reverse-engeneering work i=
s
original here, but it's not terribly complicated -- each input packet
is the constant bytes 0x00 05, followed by a single byte controller
number (0..3), and the button status in two bytes.

There are, however, a few complications that I'd like advice on:

1. Like most CIR sorts of thing, it never gives an all-buttons-off
report, and will give multiple reports for the same combinations of
buttons.

The buttons are all non-overlaping bitmaps, and I see no reason,
other then the physical impossibility of pressing the left and right
buttons at the same time without removing parts of the controller, for
multiple button-presses not to work.

That means that a naive implementation will never generate key-up
events. =C2=A0Currently, each of the native repeats generates a key dow=
n
followed by a key-up, which isn't really ideal either. =C2=A0Ideally, i=
t'd
create a key-down when the first report happens, and then create a
key-up when a report with a different set comes in, or the next
expected repeat fails to happen.

I did find some code that I could copy-and-paste to implement that in
drivers/input/misc/winbond-cir.c - wbcir_keyup, but it feels to me
like it should be somewhere generic / libraryish. =C2=A0Is it there,
somewhere I couldn't find it, or should I just copy-and-paste?

2. Another niggle is that the current code simply ignores the "which
controller is this report for" field, so userspace can't tell which of
the four controllers is pressing the button.

This rather mucks up both the origional point, and my use-case, where
each controller (which is a different colour so you can tell them
apart) belongs to a different user. =C2=A0The right way to do that is t=
o
present them to the input layer as four different devices each of
which has the same set of buttons, but that'd require, I think, some
fairly large changes to the xpad.c infrastructure.

Does the wisdom of the list think I should just abandon xpad.c, and
split this off into it's own driver? =C2=A0I'm not sure how well that'd
mesh with the way detection is done, but then again, I'm not really
sure how detection is done generally.

=C2=A0Thank you for your advice,
=C2=A0-=3D- James Mastros
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
