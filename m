From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 1/2] input.h: add BUS_CEC type
Date: Sat, 18 Jun 2016 16:50:27 +0200
Message-ID: <1466261428-12616-2-git-send-email-hverkuil@xs4all.nl>
References: <1466261428-12616-1-git-send-email-hverkuil@xs4all.nl>
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1466261428-12616-1-git-send-email-hverkuil@xs4all.nl>
Sender: linux-media-owner@vger.kernel.org
To: linux-media@vger.kernel.org
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, Hans Verkuil <hans.verkuil@cisco.com>
List-Id: linux-input@vger.kernel.org

From: Hans Verkuil <hans.verkuil@cisco.com>

Inputs can come in over the HDMI CEC bus, so add a new type for this.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 include/uapi/linux/input.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index 0111384..c514941 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -247,6 +247,7 @@ struct input_mask {
 #define BUS_ATARI		0x1B
 #define BUS_SPI			0x1C
 #define BUS_RMI			0x1D
+#define BUS_CEC			0x1E
 
 /*
  * MT_TOOL types
-- 
2.8.1
