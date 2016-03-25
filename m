From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCHv14 04/18] input.h: add BUS_CEC type
Date: Fri, 25 Mar 2016 14:10:02 +0100
Message-ID: <1458911416-47981-5-git-send-email-hverkuil@xs4all.nl>
References: <1458911416-47981-1-git-send-email-hverkuil@xs4all.nl>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1458911416-47981-1-git-send-email-hverkuil@xs4all.nl>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org, lars@opdenkamp.eu, linux@arm.linux.org.uk, Hans Verkuil <hans.verkuil@cisco.com>
List-Id: linux-input@vger.kernel.org

From: Hans Verkuil <hans.verkuil@cisco.com>

Inputs can come in over the HDMI CEC bus, so add a new type for this.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 include/uapi/linux/input.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index 2758687..4f8c813 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -246,6 +246,7 @@ struct input_mask {
 #define BUS_GSC			0x1A
 #define BUS_ATARI		0x1B
 #define BUS_SPI			0x1C
+#define BUS_CEC			0x1D
 
 /*
  * MT_TOOL types
-- 
2.7.0
