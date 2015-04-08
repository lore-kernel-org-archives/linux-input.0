From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH v2 14/15] HID: hid-lg4ff: Update respective sysfs interface documentation
Date: Wed,  8 Apr 2015 22:56:52 +0200
Message-ID: <1428526613-24239-15-git-send-email-madcatxster@devoid-pointer.net>
References: <1428526613-24239-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from transparentnimenzy.cz ([31.31.77.140]:33017 "EHLO
	smtp.devoid-pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754774AbbDHU52 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Apr 2015 16:57:28 -0400
In-Reply-To: <1428526613-24239-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.or, elias.vds@gmail.com, simon@mungewell.org, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>

Update respective sysfs interface documentation
- Refer to the sysfs interface for "range" using "/sys/bus/..."
- Update contact email address

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
---
 Documentation/ABI/testing/sysfs-driver-hid-logitech-lg4ff | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-hid-logitech-lg4ff =
b/Documentation/ABI/testing/sysfs-driver-hid-logitech-lg4ff
index b3f6a2a..db197a8 100644
--- a/Documentation/ABI/testing/sysfs-driver-hid-logitech-lg4ff
+++ b/Documentation/ABI/testing/sysfs-driver-hid-logitech-lg4ff
@@ -1,7 +1,7 @@
-What:		/sys/module/hid_logitech/drivers/hid:logitech/<dev>/range.
+What:		/sys/bus/hid/drivers/logitech/<dev>/range
 Date:		July 2011
 KernelVersion:	3.2
-Contact:	Michal Mal=C3=BD <madcatxster@gmail.com>
+Contact:	Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
 Description:	Display minimum, maximum and current range of the steerin=
g
 		wheel. Writing a value within min and max boundaries sets the
 		range of the wheel.
@@ -9,7 +9,7 @@ Description:	Display minimum, maximum and current range=
 of the steering
 What:		/sys/bus/hid/drivers/logitech/<dev>/alternate_modes
 Date:		Feb 2015
 KernelVersion:	4.1
-Contact:	Michal Mal=C3=BD <madcatxster@gmail.com>
+Contact:	Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
 Description:	Displays a set of alternate modes supported by a wheel. E=
ach
 		mode is listed as follows:
 		  Tag: Mode Name
@@ -45,7 +45,7 @@ Description:	Displays a set of alternate modes suppor=
ted by a wheel. Each
 What:		/sys/bus/hid/drivers/logitech/<dev>/real_id
 Date:		Feb 2015
 KernelVersion:	4.1
-Contact:	Michal Mal=C3=BD <madcatxster@gmail.com>
+Contact:	Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
 Description:	Displays the real model of the wheel regardless of any
 		alternate mode the wheel might be switched to.
 		It is a read-only value.
--=20
2.3.5

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
