From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: Re: [rfc] xbox360 Big-button controller support for xpad.c
Date: Sat, 31 Oct 2009 19:38:42 +0100
Message-ID: <20091031193842.61e0392e.kristoffer.ericson@gmail.com>
References: <abc933c50910270426l5091227cw9f261099b9c62109@mail.gmail.com>
	<abc933c50910310501k4c16cd18qdc851c88b8216fea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:21628 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932890AbZJaSim (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Oct 2009 14:38:42 -0400
Received: by fg-out-1718.google.com with SMTP id d23so31667fga.1
        for <linux-input@vger.kernel.org>; Sat, 31 Oct 2009 11:38:46 -0700 (PDT)
In-Reply-To: <abc933c50910310501k4c16cd18qdc851c88b8216fea@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: James Mastros <james@mastros.biz>
Cc: linux-input@vger.kernel.org

Greetings,

It made it onto the list the first time. In general maintainers
of all sorts prefer having patches PASTED into the email
and then getting questions. The mailinglist cleans out attached
files so pasting is really the only way to get a allround
review.
So, please resend with patch pasted into email text.

Best wishes
Kristoffer Ericson

On Sat, 31 Oct 2009 12:01:33 +0000
James Mastros <james@mastros.biz> wrote:

> [This doesn't appear to have made it to the list the first time I sen=
t
> it, so I'm resending.  My appologies if you recieve it more then
> once.]
>=20
> Hello, all,
>=20
> The attached (RFC!) patch adds support for the xbox 360 big-button
> controllers to xpad.c. =C2=A0These seem to be a set of four large CIR
> remote controls, with a USB receiver that speaks a modified version o=
f
> the normal xbox360 usb remote protocol.
>=20
> http://en.wikipedia.org/wiki/Xbox_360_accessories#Big_Button_Pad has =
a
> decent image. =C2=A0You can get a set for about 12GBP, including a ga=
me
> disk for Scene It (which I haven't even removed the shrink-wrap for,
> since I don't actually own a 360). =C2=A0The reverse-engeneering work=
 is
> original here, but it's not terribly complicated -- each input packet
> is the constant bytes 0x00 05, followed by a single byte controller
> number (0..3), and the button status in two bytes.
>=20
> There are, however, a few complications that I'd like advice on:
>=20
> 1. Like most CIR sorts of thing, it never gives an all-buttons-off
> report, and will give multiple reports for the same combinations of
> buttons.
>=20
> The buttons are all non-overlaping bitmaps, and I see no reason,
> other then the physical impossibility of pressing the left and right
> buttons at the same time without removing parts of the controller, fo=
r
> multiple button-presses not to work.
>=20
> That means that a naive implementation will never generate key-up
> events. =C2=A0Currently, each of the native repeats generates a key d=
own
> followed by a key-up, which isn't really ideal either. =C2=A0Ideally,=
 it'd
> create a key-down when the first report happens, and then create a
> key-up when a report with a different set comes in, or the next
> expected repeat fails to happen.
>=20
> I did find some code that I could copy-and-paste to implement that in
> drivers/input/misc/winbond-cir.c - wbcir_keyup, but it feels to me
> like it should be somewhere generic / libraryish. =C2=A0Is it there,
> somewhere I couldn't find it, or should I just copy-and-paste?
>=20
> 2. Another niggle is that the current code simply ignores the "which
> controller is this report for" field, so userspace can't tell which o=
f
> the four controllers is pressing the button.
>=20
> This rather mucks up both the origional point, and my use-case, where
> each controller (which is a different colour so you can tell them
> apart) belongs to a different user. =C2=A0The right way to do that is=
 to
> present them to the input layer as four different devices each of
> which has the same set of buttons, but that'd require, I think, some
> fairly large changes to the xpad.c infrastructure.
>=20
> Does the wisdom of the list think I should just abandon xpad.c, and
> split this off into it's own driver? =C2=A0I'm not sure how well that=
'd
> mesh with the way detection is done, but then again, I'm not really
> sure how detection is done generally.
>=20
> =C2=A0Thank you for your advice,
> =C2=A0-=3D- James Mastros
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--=20
Kristoffer Ericson <kristoffer.ericson@gmail.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
