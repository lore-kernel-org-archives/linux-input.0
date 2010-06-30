From: Xiaofan Chen <xiaofanc@gmail.com>
Subject: Re: Report ID problem with HID-RAW interface usage
Date: Thu, 1 Jul 2010 07:33:50 +0800
Message-ID: <AANLkTiksI0lHgIKyLy_sDELbskpSsS2rNm0Kf48oFGo8@mail.gmail.com>
References: <AANLkTinrmRsB39gj7Ie4xCr3fhP3jU1dfYuVrkiKv347@mail.gmail.com>
	<4C2A1FA0.6020704@signal11.us>
	<alpine.LNX.2.00.1006301126130.13809@pobox.suse.cz>
	<AANLkTilf1JU_GPlqE-FeaRon6IMqgA68WZ964PJfLpSP@mail.gmail.com>
	<alpine.LNX.2.00.1006301252380.13809@pobox.suse.cz>
	<AANLkTil-hNWeWbLQqE0ezlmZhO1w402NClaT_tayPJra@mail.gmail.com>
	<4C2B3E6B.7060703@signal11.us>
	<AANLkTilzYu3mA3vDzuVyxngTcltgKEoNKYrdenz1Z-VG@mail.gmail.com>
	<alpine.LNX.2.00.1006301505490.13809@pobox.suse.cz>
	<AANLkTil0S747k-MomthJW4dv2WwB-abjZmGmxf3fH59y@mail.gmail.com>
	<4C2B5579.8060104@signal11.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:60914 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755147Ab0F3Xdw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jun 2010 19:33:52 -0400
In-Reply-To: <4C2B5579.8060104@signal11.us>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Ott <alan@signal11.us>
Cc: Jiri Kosina <jkosina@suse.cz>, Amit Nagal <helloin.amit@gmail.com>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Antonio Ospite <ospite@studenti.unina.it>

On Wed, Jun 30, 2010 at 10:32 PM, Alan Ott <alan@signal11.us> wrote:

> I've had the same ideas of creating a cross-platform HID api, and sta=
rted a
> similar project. Maybe we could benefit from one another. What I've g=
ot so
> far is at:
> =A0 =A0www.signal11.us/oss/hidapi
>
> Of course, what's up there right now only supports Windows, and was
> originally intended to get around the fact that the HID headers and i=
mport
> lib aren't part of the Platform SDK, but part of the Driver Kit (It's=
 all
> explained on the web page). I have a working backend for hidraw, whic=
h I
> need to get cleaned up and committed. Of course, the Hidraw backend d=
epends
> on some of the queued changes which won't get in the mainline kernel =
until
> 2.6.36.
>
> I have a Mac here and intend to make it work on OS X as well.

Great. I will forward this to the libusb mailing list.

> I did not realize that libusb-1.0 would talk to the native Windows HI=
D
> backend. I don't see anything like that in the git version of libusb-=
1.0 or
> libusb-win32. Is this on another branch or something, or did I miss i=
t?
>

It is currently being integrated into the main libusb-1.0 git tree but
the integration will take some time.

The author is Pete Batard and the tree is here.
http://git.libusb.org/?p=3Dlibusb-pbatard.git
http://www.libusb.org/wiki/windows_backend


--=20
Xiaofan http://sourceforge.net/projects/libusb-win32/
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
