From: Daniel Mack <daniel@caiaq.de>
Subject: ABS_MAX incrementation?
Date: Mon, 19 Apr 2010 19:14:12 +0200
Message-ID: <20100419171412.GH30801@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:60677 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754492Ab0DSROS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Apr 2010 13:14:18 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi,

I'm planning to write a driver for a device with a number of absolute
axis and 16 pressure-sensitive trigger pads. Alltogether, it will have
more absoulte axis informations than the API in include/input.h is able
to represent. More than that, the definitions I'm referring to won't
describe the actual information in a sane way. I'm uncertain whether
this list can be extended by something like the patch below. Or is this
a nonono as it breaks existing user space applications? Any other idea
of how to solve this?

Thanks,
Daniel


>From ad95178134ab4cf9dd1b32daf3fff14d3c7d1e17 Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@caiaq.de>
Date: Mon, 19 Apr 2010 19:08:14 +0200
Subject: [PATCH] input: add definitions for 16 trigger pads

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 include/linux/input.h |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/include/linux/input.h b/include/linux/input.h
index 7ed2251..39efad4 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -706,7 +706,24 @@ struct input_absinfo {
 #define ABS_MT_TRACKING_ID	0x39	/* Unique ID of initiated contact */
 #define ABS_MT_PRESSURE		0x3a	/* Pressure on contact area */
 
-#define ABS_MAX			0x3f
+#define ABS_PAD1		0x40
+#define ABS_PAD2		0x41
+#define ABS_PAD3		0x42
+#define ABS_PAD4		0x43
+#define ABS_PAD5		0x44
+#define ABS_PAD6		0x45
+#define ABS_PAD7		0x46
+#define ABS_PAD8		0x47
+#define ABS_PAD9		0x48
+#define ABS_PAD10		0x49
+#define ABS_PAD11		0x4a
+#define ABS_PAD12		0x4b
+#define ABS_PAD13		0x4c
+#define ABS_PAD14		0x4d
+#define ABS_PAD15		0x4e
+#define ABS_PAD16		0x4f
+
+#define ABS_MAX			0x4f
 #define ABS_CNT			(ABS_MAX+1)
 
 /*
-- 
1.7.0.3

