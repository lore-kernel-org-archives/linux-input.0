From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: S2R resume crash in 2.6.33-rc7 - NULL pointer dereference in
 dev_get_drvdata() for usbhid
Date: Mon, 8 Feb 2010 19:06:49 +0100
Message-ID: <20100208190649.0ceea556@neptune.home>
References: <20100208175145.606ca761@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ppp-156-198.adsl.restena.lu ([158.64.156.198]:59362 "EHLO
	bonbons.gotdns.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368Ab0BHSHT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Feb 2010 13:07:19 -0500
In-Reply-To: <20100208175145.606ca761@neptune.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Oliver Neukum <oliver@neukum.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Marcel Holtmann <marcel@holtmann.org>, H Hartley Sweeten <hsweeten@visioneng>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 08 February 2010 Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>=
 wrote:
> 2.6.33-rc7 (don't know if any previous version resumes properly)
> crashes during resume from S2Ram when my USB keyboard is connected bu=
t
> resumes properly (viafb corruption put apart) when the USB keyboard i=
s
> not connected.

The patch below works around the crash though the WARN_ON() in
usbhid_restart_out_queue() triggers in place.

Bruno

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-cor=
e.c
index e2997a8..d2f8eef 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -196,7 +196,7 @@ static void usbhid_mark_busy(struct usbhid_device *=
usbhid)
=20
 static int usbhid_restart_out_queue(struct usbhid_device *usbhid)
 {
-	struct hid_device *hid =3D usb_get_intfdata(usbhid->intf);
+	struct hid_device *hid =3D usbhid->intf ? usb_get_intfdata(usbhid->in=
tf) : NULL;
 	int kicked;
=20
 	if (!hid)
@@ -214,7 +214,7 @@ static int usbhid_restart_out_queue(struct usbhid_d=
evice *usbhid)
=20
 static int usbhid_restart_ctrl_queue(struct usbhid_device *usbhid)
 {
-	struct hid_device *hid =3D usb_get_intfdata(usbhid->intf);
+	struct hid_device *hid =3D usbhid->intf ? usb_get_intfdata(usbhid->in=
tf) : NULL;
 	int kicked;
=20
 	WARN_ON(hid =3D=3D NULL);
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
