From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] input: Enable to report clicks with Clickapd devices
Date: Mon, 14 Dec 2009 11:01:28 +0100
Message-ID: <1260784889-5205-2-git-send-email-tiwai@suse.de>
References: <1260784889-5205-1-git-send-email-tiwai@suse.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:33158 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754633AbZLNKDa (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Dec 2009 05:03:30 -0500
In-Reply-To: <1260784889-5205-1-git-send-email-tiwai@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Takashi Iwai <tiwai@suse.de>

The new Synaptics "Clickpad" devices seem to report the click as a
middle button.  But the synaptics driver doesn't expose because the
device doesn't set the necessary capability bits.

This patch adds a check of the product id bits and forces to enable the
middle-button reporting on Clickpad devices.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/input/mouse/synaptics.c |    5 +++++
 drivers/input/mouse/synaptics.h |    2 ++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 05689e7..8d8365e 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -701,6 +701,11 @@ int synaptics_init(struct psmouse *psmouse)
 		SYN_ID_MAJOR(priv->identity), SYN_ID_MINOR(priv->identity),
 		priv->model_id, priv->capabilities, priv->ext_cap);
 
+	if (SYN_CAP_CLICKPAD(priv->ext_cap)) {
+		/* force to enable the middle button */
+		priv->capabilities |= (1 << 18);
+	}
+
 	set_input_params(psmouse->dev, priv);
 
 	/*
diff --git a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
index 838e7f2..35360a6 100644
--- a/drivers/input/mouse/synaptics.h
+++ b/drivers/input/mouse/synaptics.h
@@ -48,6 +48,8 @@
 #define SYN_CAP_VALID(c)		((((c) & 0x00ff00) >> 8) == 0x47)
 #define SYN_EXT_CAP_REQUESTS(c)		(((c) & 0x700000) >> 20)
 #define SYN_CAP_MULTI_BUTTON_NO(ec)	(((ec) & 0x00f000) >> 12)
+#define SYN_CAP_PRODUCT_ID(ec)		(((ec) & 0xff0000) >> 16)
+#define SYN_CAP_CLICKPAD(ec)		(SYN_CAP_PRODUCT_ID(ec) == 0xe4)
 
 /* synaptics modes query bits */
 #define SYN_MODE_ABSOLUTE(m)		((m) & (1 << 7))
-- 
1.6.5.5

