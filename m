From: Josh Boyer <jwboyer@redhat.com>
Subject: [PATCH] HID: hid-input: default HID_BATTERY_STRENGTH to no
Date: Wed, 18 Apr 2012 10:05:17 -0400
Message-ID: <20120418140517.GM19507@zod.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48249 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071Ab2DROFu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Apr 2012 10:05:50 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@fedoraproject.org

Commit 4f5ca836b "HID: hid-input: add support for HID devices reporting
Battery Strength" added the CONFIG_HID_BATTERY_STRENGTH option to report
the battery strength of HID devices.  The commit log explicitly mentions
it not working properly with recent userspace, but it is default y
anyway.  This is rather odd, and actually causes problems on real
systems.

This works around Fedora bug
https://bugzilla.redhat.com/show_bug.cgi?id=806295

Signed-off-by: Josh Boyer <jwboyer@redhat.com>

---

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index a3d0332..ffddcba 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -34,7 +34,7 @@ config HID
 config HID_BATTERY_STRENGTH
 	bool
 	depends on HID && POWER_SUPPLY && HID = POWER_SUPPLY
-	default y
+	default n
 
 config HIDRAW
 	bool "/dev/hidraw raw HID device support"
