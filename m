From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH RFC 3/4] input: add a EV_SW event for ratchet switch
Date: Sat, 25 Mar 2017 19:49:41 -0300
Message-ID: <c48652786b1e139503834f67b1a5037ff677a174.1490481944.git.mchehab@s-opensource.com>
References: <cover.1490481944.git.mchehab@s-opensource.com>
 <cf7b2e1587f2986abfa7252f9e8d2799b20911cc.1490481944.git.mchehab@s-opensource.com>
 <2529a55b0477cc638f1104a423cb67de1628a96d.1490481944.git.mchehab@s-opensource.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:46068 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751313AbdCYWtz (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 25 Mar 2017 18:49:55 -0400
In-Reply-To: <2529a55b0477cc638f1104a423cb67de1628a96d.1490481944.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1490481944.git.mchehab@s-opensource.com>
References: <cover.1490481944.git.mchehab@s-opensource.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Ingo Tuchscherer <ingo.tuchscherer@linux.vnet.ibm.com>, Stuart Yoder <stuart.yoder@nxp.com>, Hans Verkuil <hans.verkuil@cisco.com>, Douglas Anderson <dianders@chromium.org>, Ping Cheng <pinglinux@gmail.com>, Kamil Debski <kamil@wypas.org>

Some mouses have a switch on their wheel, allowing to switch
between ratchet or free wheel mode. Add support for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 include/linux/mod_devicetable.h        | 2 +-
 include/uapi/linux/input-event-codes.h | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 8a57f0b1242d..73534c591b40 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -292,7 +292,7 @@ struct pcmcia_device_id {
 #define INPUT_DEVICE_ID_LED_MAX		0x0f
 #define INPUT_DEVICE_ID_SND_MAX		0x07
 #define INPUT_DEVICE_ID_FF_MAX		0x7f
-#define INPUT_DEVICE_ID_SW_MAX		0x0f
+#define INPUT_DEVICE_ID_SW_MAX		0x1f
 
 #define INPUT_DEVICE_ID_MATCH_BUS	1
 #define INPUT_DEVICE_ID_MATCH_VENDOR	2
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 23b2d377af59..a3eafd0527f1 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -782,7 +782,9 @@
 #define SW_LINEIN_INSERT	0x0d  /* set = inserted */
 #define SW_MUTE_DEVICE		0x0e  /* set = device disabled */
 #define SW_PEN_INSERTED		0x0f  /* set = pen inserted */
-#define SW_MAX			0x0f
+#define SW_RATCHET		0x10  /* set = ratchet mode,
+					 unset: free wheel */
+#define SW_MAX			0x1f
 #define SW_CNT			(SW_MAX+1)
 
 /*
-- 
2.9.3


