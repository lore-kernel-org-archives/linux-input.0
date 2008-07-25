From: Harley Laue <losinggeneration@gmail.com>
Subject: [PATCH] The Pelican Eclipse's D-Pad isn't functional without this.
Date: Fri, 25 Jul 2008 15:09:57 -0500
Message-ID: <488A3315.5020300@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060403090406010406040309"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:5421 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572AbYGYUKF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Jul 2008 16:10:05 -0400
Received: by py-out-1112.google.com with SMTP id p76so2648751pyb.10
        for <linux-input@vger.kernel.org>; Fri, 25 Jul 2008 13:10:04 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

This is a multi-part message in MIME format.
--------------060403090406010406040309
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I got tired of having to add this every time I wanted to use the pad. I
hope everything sends alright and I made the patch correctly.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkiKMxUACgkQulFr2MEc2vtnBACbBMNlJsIC8+x8snylQyUyFpcD
FNgAoIhxA5ELWAIKMOYuCId2O14t1a0/
=g4ZM
-----END PGP SIGNATURE-----

--------------060403090406010406040309
Content-Type: text/x-patch;
 name="0001-The-Pelican-Eclipse-s-D-Pad-isn-t-functional-without.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-The-Pelican-Eclipse-s-D-Pad-isn-t-functional-without.pa";
 filename*1="tch"

>From b0cf0f02b7c64dfb3e76fd785b0170ddf5666898 Mon Sep 17 00:00:00 2001
From: Harley Laue <losinggeneration@gmail.com>
Date: Fri, 25 Jul 2008 10:53:42 -0500
Subject: [PATCH] The Pelican Eclipse's D-Pad isn't functional without this.

Signed-off-by: Harley Laue <losinggeneration@gmail.com>
---
 drivers/input/joystick/xpad.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 87d3e7e..6791be8 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -127,6 +127,7 @@ static const struct xpad_device {
 	{ 0x0738, 0x4716, "Mad Catz Wired Xbox 360 Controller", MAP_DPAD_TO_AXES, XTYPE_XBOX360 },
 	{ 0x0738, 0x6040, "Mad Catz Beat Pad Pro", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX },
 	{ 0x0c12, 0x8802, "Zeroplus Xbox Controller", MAP_DPAD_TO_AXES, XTYPE_XBOX },
+	{ 0x0c12, 0x880a, "Pelican Eclipse PL-2023", MAP_DPAD_TO_AXES, XTYPE_XBOX },
 	{ 0x0c12, 0x8810, "Zeroplus Xbox Controller", MAP_DPAD_TO_AXES, XTYPE_XBOX },
 	{ 0x0c12, 0x9902, "HAMA VibraX - *FAULTY HARDWARE*", MAP_DPAD_TO_AXES, XTYPE_XBOX },
 	{ 0x0e4c, 0x1097, "Radica Gamester Controller", MAP_DPAD_TO_AXES, XTYPE_XBOX },
-- 
1.5.6.2


--------------060403090406010406040309--
