From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH RFC 1/4] input: add an EV_REL event for high-res vertical wheel
Date: Sat, 25 Mar 2017 19:49:39 -0300
Message-ID: <cf7b2e1587f2986abfa7252f9e8d2799b20911cc.1490481944.git.mchehab@s-opensource.com>
References: <cover.1490481944.git.mchehab@s-opensource.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:54809 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751205AbdCYWu2 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 25 Mar 2017 18:50:28 -0400
In-Reply-To: <cover.1490481944.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1490481944.git.mchehab@s-opensource.com>
References: <cover.1490481944.git.mchehab@s-opensource.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans Verkuil <hans.verkuil@cisco.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Douglas Anderson <dianders@chromium.org>, Kamil Debski <kamil@wypas.org>, Ping Cheng <pinglinux@gmail.com>

As some devices can produce either low-res or high-res
vertical wheel EV_REL events, add a new event to allow
userspace to distinguish between them.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 include/uapi/linux/input-event-codes.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 3af60ee69053..23b2d377af59 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -703,6 +703,7 @@
 #define REL_DIAL		0x07
 #define REL_WHEEL		0x08
 #define REL_MISC		0x09
+#define REL_HIRES_WHEEL		0x0a
 #define REL_MAX			0x0f
 #define REL_CNT			(REL_MAX+1)
 
-- 
2.9.3


