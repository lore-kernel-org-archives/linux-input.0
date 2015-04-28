From: Antonio Ospite <ao2@ao2.it>
Subject: [PATCH 01/12] trivial: HID: Makefile: fix alignment of objs-* entries
Date: Tue, 28 Apr 2015 13:11:20 +0200
Message-ID: <1430219491-5076-2-git-send-email-ao2@ao2.it>
References: <1430219491-5076-1-git-send-email-ao2@ao2.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp209.alice.it ([82.57.200.105]:58697 "EHLO smtp209.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933012AbbD1LMN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Apr 2015 07:12:13 -0400
In-Reply-To: <1430219491-5076-1-git-send-email-ao2@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <trivial@kernel.org>
Cc: Antonio Ospite <ao2@ao2.it>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

Most of the entries are aligned with TABs, fix those which are not.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org
---
 drivers/hid/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index e4a21df..2f8a41d 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -24,7 +24,7 @@ obj-$(CONFIG_HID_A4TECH)	+= hid-a4tech.o
 obj-$(CONFIG_HID_ACRUX)		+= hid-axff.o
 obj-$(CONFIG_HID_APPLE)		+= hid-apple.o
 obj-$(CONFIG_HID_APPLEIR)	+= hid-appleir.o
-obj-$(CONFIG_HID_AUREAL)        += hid-aureal.o
+obj-$(CONFIG_HID_AUREAL)	+= hid-aureal.o
 obj-$(CONFIG_HID_BELKIN)	+= hid-belkin.o
 obj-$(CONFIG_HID_BETOP_FF)	+= hid-betopff.o
 obj-$(CONFIG_HID_CHERRY)	+= hid-cherry.o
@@ -46,12 +46,12 @@ obj-$(CONFIG_HID_ICADE)		+= hid-icade.o
 obj-$(CONFIG_HID_KENSINGTON)	+= hid-kensington.o
 obj-$(CONFIG_HID_KEYTOUCH)	+= hid-keytouch.o
 obj-$(CONFIG_HID_KYE)		+= hid-kye.o
-obj-$(CONFIG_HID_LCPOWER)       += hid-lcpower.o
+obj-$(CONFIG_HID_LCPOWER)	+= hid-lcpower.o
 obj-$(CONFIG_HID_LENOVO)	+= hid-lenovo.o
 obj-$(CONFIG_HID_LOGITECH)	+= hid-logitech.o
 obj-$(CONFIG_HID_LOGITECH_DJ)	+= hid-logitech-dj.o
 obj-$(CONFIG_HID_LOGITECH_HIDPP)	+= hid-logitech-hidpp.o
-obj-$(CONFIG_HID_MAGICMOUSE)    += hid-magicmouse.o
+obj-$(CONFIG_HID_MAGICMOUSE)	+= hid-magicmouse.o
 obj-$(CONFIG_HID_MICROSOFT)	+= hid-microsoft.o
 obj-$(CONFIG_HID_MONTEREY)	+= hid-monterey.o
 obj-$(CONFIG_HID_MULTITOUCH)	+= hid-multitouch.o
-- 
2.1.4

