From: Stefan Achatz <erazor_de@users.sourceforge.net>
Subject: [PATCH] HID: roccat: Fixed wrong sysfs attr size for koneplus tcu.
Date: Sat, 17 Nov 2012 21:27:11 +0100
Message-ID: <1353184031.4973.9.camel@neuromancer.tessier-ashpool>
Reply-To: erazor_de@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-in-18.arcor-online.net ([151.189.21.58]:55200 "EHLO
	mail-in-18.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752133Ab2KQU1O (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 17 Nov 2012 15:27:14 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

More thorough testing revealed a typo in last koneplus cleanups.

Signed-off-by: Stefan Achatz <erazor_de@users.sourceforge.net>
---
 drivers/hid/hid-roccat-koneplus.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-roccat-koneplus.h b/drivers/hid/hid-roccat-koneplus.h
index d2b55f2..af7f57e 100644
--- a/drivers/hid/hid-roccat-koneplus.h
+++ b/drivers/hid/hid-roccat-koneplus.h
@@ -24,7 +24,7 @@ enum {
 	KONEPLUS_SIZE_PROFILE_BUTTONS = 0x4d,
 	KONEPLUS_SIZE_SENSOR = 0x06,
 	KONEPLUS_SIZE_TALK = 0x10,
-	KONEPLUS_SIZE_TCU = 0x03,
+	KONEPLUS_SIZE_TCU = 0x04,
 	KONEPLUS_SIZE_TCU_IMAGE = 0x0404,
 };
 
-- 
1.7.3.4



