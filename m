From: Simon Farnsworth <simon.farnsworth@onelan.co.uk>
Subject: Re: [PATCH] hid: Remove QUANTA from special drivers list
Date: Thu, 23 Aug 2012 11:10:58 +0100
Message-ID: <1458729.LvjituALLn@f17simon>
References: <1345630637-7142-1-git-send-email-simon.farnsworth@onelan.co.uk> <alpine.LNX.2.00.1208221648130.32304@pobox.suse.cz> <20120822170052.GA6158@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1576477.iX8D03ZfZA"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from claranet-outbound-smtp06.uk.clara.net ([195.8.89.39]:58863 "EHLO
	claranet-outbound-smtp06.uk.clara.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932358Ab2HWKLM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Aug 2012 06:11:12 -0400
In-Reply-To: <20120822170052.GA6158@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.se>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Benjamin Tissoires <benjamin.tissoires@enac.fr>


--nextPart1576477.iX8D03ZfZA
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 22 August 2012 19:00:52 Henrik Rydberg wrote:
> > > Applying just this patch is enough to fix the problem I described in my mail
> > > "QUANTA touchscreen controller integrated in HP2310ti no longer recognised
> > > (regression in 3.5 and later as compared to 3.3)".
> > > 
> > > This looks like an oversight in commit 4fa3a58; that commit removes most
> > > multitouch screens from this list, but missed this one. Henrik should be
> > > able to confirm, though, so I'd appreciate his sign-off.
> 
> Yes, good find. We have two identifiers for the same device,
> USB_DEVICE_ID_PIXART_IMAGING_INC_OPTICAL_TOUCH_SCREEN and
> USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3001, which might explain why it
> was overlooked. I think we should get rid of one of them. Also, I
> wonder if the HID_QUIRK_NOGET quirk is still necessary.
> 
I'll send a follow-on patch to remove the PIXART_IMAGING identifier. I tried
removing the HID_QURIK_NOGET quirk, but it appears to be needed: without it,
I get:

[    1.472269] usb 6-1: New USB device found, idVendor=0408, idProduct=3001
[    1.472275] usb 6-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    1.472279] usb 6-1: Product: Optical Touch Screen
[    1.472284] usb 6-1: Manufacturer: QUANTA
<snip>
[   15.884252] hid-multitouch 0003:0408:3001.0001: usb_submit_urb(ctrl) failed: -1
[   15.884337] hid-multitouch 0003:0408:3001.0001: timeout initializing reports
[   15.884584] input: QUANTA Optical Touch Screen as /devices/pci0000:00/0000:00:1d.1/usb6/6-1/6-1:1.0/input/input10
[   15.884783] hid-multitouch 0003:0408:3001.0001: input,hidraw0: USB HID v1.10 Device [QUANTA Optical Touch Screen] on usb-0000:00:1d.1-1/input0

If I leave the quirk in place, I don't get the 14 second delay, suggesting 
that the quirk is needed on this hardware.

-- 
Simon Farnsworth
Software Engineer
ONELAN Ltd
http://www.onelan.com

--nextPart1576477.iX8D03ZfZA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAABAgAGBQJQNgG3AAoJEIKsye9/dtRW8mIH/2jBF5U4+dcwcCJZrUtbHP8n
TjMsK0Z+iNLafEo3sL3sqyw0cL+SxGObBqKzIetsCeMjzG2EvbuvnWuGa+m58aUb
llv5AbVuefWYG0CanRgc/UIMotpEsl8BJhnDTdFTNzy6xnFEGsj815P1djC7kz+c
LQwDCKJwdsP/0ZKPRD6LLeTLCQ+N7CpI9AxTEzah6fXKjEtsof1q6mdDQ0xUITUU
bXBOnyyQm/Ywm8HUb1PD7cJOrL+iwo2xxFGwBzG2pRxg2RFr4hsAI0Cx2nSrrra5
63a+POK9+WHplgQk5XvB7bfEyLQgW1/BWnUJkoPMSsaxLFZPx8f9yOEuYc3wAks=
=wWsy
-----END PGP SIGNATURE-----

--nextPart1576477.iX8D03ZfZA--

