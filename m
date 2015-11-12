From: Hans Verkuil <hansverk@cisco.com>
Subject: [PATCHv10 04/16] input.h: add BUS_CEC type
Date: Thu, 12 Nov 2015 13:21:33 +0100
Message-ID: <7ca542282819479e06874340cff75d04cf70a9cd.1447329279.git.hansverk@cisco.com>
References: <cover.1447329279.git.hansverk@cisco.com>
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <cover.1447329279.git.hansverk@cisco.com>
In-Reply-To: <cover.1447329279.git.hansverk@cisco.com>
References: <cover.1447329279.git.hansverk@cisco.com>
Sender: linux-media-owner@vger.kernel.org
To: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org, lars@opdenkamp.eu, linux@arm.linux.org.uk, Hans Verkuil <hans.verkuil@cisco.com>
List-Id: linux-input@vger.kernel.org

From: Hans Verkuil <hans.verkuil@cisco.com>

Inputs can come in over the HDMI CEC bus, so add a new type for this.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 include/uapi/linux/input.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index 731417c..a32bff1 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -972,6 +972,7 @@ struct input_keymap_entry {
 #define BUS_GSC			0x1A
 #define BUS_ATARI		0x1B
 #define BUS_SPI			0x1C
+#define BUS_CEC			0x1D
 
 /*
  * MT_TOOL types
-- 
2.6.2
