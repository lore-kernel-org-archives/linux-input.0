From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH 11/12] HID: hid-lg4ff: Update respective sysfs interface documentation
Date: Sat, 21 Mar 2015 12:47:41 +0100
Message-ID: <1426938462-884-12-git-send-email-madcatxster@devoid-pointer.net>
References: <1426938462-884-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426938462-884-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, elias.vds@gmail.com, simon@mungewell.org, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
List-Id: linux-input@vger.kernel.org

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
2.3.3
