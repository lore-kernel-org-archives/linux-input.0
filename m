From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [RFC PATCH 1/1] Input: add new keycodes useful in mobile devices
Date: Thu, 22 Oct 2009 12:32:20 +0300
Message-ID: <72a6deb76f693b5e50dbfe150154e7a4724d0568.1256200562.git.ext-jani.1.nikula@nokia.com>
References: <cover.1256200562.git.ext-jani.1.nikula@nokia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:30227 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754528AbZJVJcc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Oct 2009 05:32:32 -0400
In-Reply-To: <cover.1256200562.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <cover.1256200562.git.ext-jani.1.nikula@nokia.com>
References: <cover.1256200562.git.ext-jani.1.nikula@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, ext-jani.1.nikula@nokia.com

From: Jani Nikula <ext-jani.1.nikula@nokia.com>

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
---
 include/linux/input.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/linux/input.h b/include/linux/input.h
index 0ccfc30..3c246b1 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -595,6 +595,8 @@ struct input_absinfo {
 #define KEY_NUMERIC_STAR	0x20a
 #define KEY_NUMERIC_POUND	0x20b
 
+#define KEY_CAMERA_FOCUS	0x210
+
 /* We avoid low common keys in module aliases so they don't get huge. */
 #define KEY_MIN_INTERESTING	KEY_MUTE
 #define KEY_MAX			0x2ff
@@ -677,6 +679,9 @@ struct input_absinfo {
 #define SW_LINEOUT_INSERT	0x06  /* set = inserted */
 #define SW_JACK_PHYSICAL_INSERT 0x07  /* set = mechanical switch set */
 #define SW_VIDEOOUT_INSERT	0x08  /* set = inserted */
+#define SW_CAMERA_LENSE_COVER	0x09  /* set = lense covered */
+#define SW_KEYPAD_SLIDE		0x0a  /* set = keypad slide out */
+#define SW_PROXIMITY		0x0b  /* set = proximity sensor covered */
 #define SW_MAX			0x0f
 #define SW_CNT			(SW_MAX+1)
 
-- 
1.6.3.2

