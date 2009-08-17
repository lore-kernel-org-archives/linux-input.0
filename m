From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Input: iforce -- add support for ACT LABS forceRS
Date: Mon, 17 Aug 2009 22:48:36 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0908172246340.25797@wotan.suse.de>
References: <alpine.LNX.2.00.0908171717510.25797@wotan.suse.de> <6cefefac0908171250v6276d5te7e866b5bc5c60b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="168427776-205480899-1250542116=:25797"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:37769 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752086AbZHQUsg (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Aug 2009 16:48:36 -0400
In-Reply-To: <6cefefac0908171250v6276d5te7e866b5bc5c60b2@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: cmd_ <cemede@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, johann.deneux@gmail.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--168427776-205480899-1250542116=:25797
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Mon, 17 Aug 2009, cmd_ wrote:

> Patch does not work as-is for me.
[ ... ]
> This was a mistype from my 1st e-mail, sorry.

Thanks, corrected one below.



From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] Input: iforce -- add support for ACT LABS forceRS

Add support for ACT LABS forceRS.

Reported-by: cmd_ <cemede@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>


diff --git a/drivers/input/joystick/iforce/iforce-main.c b/drivers/input/joystick/iforce/iforce-main.c
index baabf83..f6c688c 100644
--- a/drivers/input/joystick/iforce/iforce-main.c
+++ b/drivers/input/joystick/iforce/iforce-main.c
@@ -74,6 +74,7 @@ static struct iforce_device iforce_device[] = {
 	{ 0x05ef, 0x8884, "AVB Mag Turbo Force",			btn_avb_wheel, abs_wheel, ff_iforce },
 	{ 0x05ef, 0x8888, "AVB Top Shot Force Feedback Racing Wheel",	btn_avb_tw, abs_wheel, ff_iforce }, //?
 	{ 0x061c, 0xc0a4, "ACT LABS Force RS",                          btn_wheel, abs_wheel, ff_iforce }, //?
+	{ 0x061c, 0xc084, "ACT LABS Force RS",				btn_wheel, abs_wheel, ff_iforce },
 	{ 0x06f8, 0x0001, "Guillemot Race Leader Force Feedback",	btn_wheel, abs_wheel, ff_iforce }, //?
 	{ 0x06f8, 0x0004, "Guillemot Force Feedback Racing Wheel",	btn_wheel, abs_wheel, ff_iforce }, //?
 	{ 0x06f8, 0x0004, "Gullemot Jet Leader 3D",			btn_joystick, abs_joystick, ff_iforce }, //?
diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
index f83185a..9f289d8 100644
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -223,6 +223,7 @@ static struct usb_device_id iforce_usb_ids [] = {
 	{ USB_DEVICE(0x05ef, 0x8884) },		/* AVB Mag Turbo Force */
 	{ USB_DEVICE(0x05ef, 0x8888) },		/* AVB Top Shot FFB Racing Wheel */
 	{ USB_DEVICE(0x061c, 0xc0a4) },         /* ACT LABS Force RS */
+	{ USB_DEVICE(0x061c, 0xc084) },         /* ACT LABS Force RS */
 	{ USB_DEVICE(0x06f8, 0x0001) },		/* Guillemot Race Leader Force Feedback */
 	{ USB_DEVICE(0x06f8, 0x0004) },		/* Guillemot Force Feedback Racing Wheel */
 	{ USB_DEVICE(0x06f8, 0xa302) },		/* Guillemot Jet Leader 3D */
--168427776-205480899-1250542116=:25797--
