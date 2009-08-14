From: Lamarque Vieira Souza <lamarque@gmail.com>
Subject: Re: Problem with Acer Bluetooth Optical Rechargeable Mouse
Date: Thu, 13 Aug 2009 22:30:30 -0300
Message-ID: <200908132230.30833.lamarque@gmail.com>
References: <200908062247.29254.lamarque@gmail.com> <alpine.LNX.2.00.0908131343290.25797@wotan.suse.de> <200908132052.01012.lamarque@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_24LhKF5Z46liSBs"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f175.google.com ([209.85.210.175]:33661 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098AbZHNBas (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Aug 2009 21:30:48 -0400
Received: by yxe5 with SMTP id 5so1520904yxe.33
        for <linux-input@vger.kernel.org>; Thu, 13 Aug 2009 18:30:49 -0700 (PDT)
In-Reply-To: <200908132052.01012.lamarque@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Andrew Morton <akpm@linux-foundation.org>

--Boundary-00=_24LhKF5Z46liSBs
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit

	Actually there is an error in the patch I sent in my last e-mail, this one 
works (just one line change patch :-)). It was more simpler fix than I have 
thought.

Em Quinta-feira 13 Agosto 2009, Lamarque Vieira Souza escreveu:
> 	I think  I have found a good solution for my problem, see the attached
> patch. I just need to find a better name for the define
> USB_DEVICE_ID_KYE_58.


-- 
Lamarque V. Souza
http://www.geographicguide.com/brazil.htm
Linux User #57137 - http://counter.li.org/

--Boundary-00=_24LhKF5Z46liSBs
Content-Type: text/x-patch;
  charset="UTF-8";
  name="bluetooth-fix-for-acer-bluetooth-optical-rechargeable-mouse.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bluetooth-fix-for-acer-bluetooth-optical-rechargeable-mouse.patch"

diff -Nru --show-c-function a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
--- a/drivers/hid/hid-core.c	2009-08-13 20:45:11.000000000 -0300
+++ b/drivers/hid/hid-core.c	2009-08-13 22:25:54.504677594 -0300
@@ -1636,6 +1636,7 @@ static const struct hid_device_id hid_ig
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_1_PHIDGETSERVO_20) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_8_8_4_IF_KIT) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_YEALINK, USB_DEVICE_ID_YEALINK_P1K_P4K_B2K) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_KYE, 0x0058) },
 	{ }
 };
 

--Boundary-00=_24LhKF5Z46liSBs--
