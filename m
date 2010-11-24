From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: [PATCH WIP 4/6] fixup gpio_buttons: show units of poll_interval platform data member
Date: Wed, 24 Nov 2010 16:01:38 -0500
Message-ID: <6fc21c21286244c8ffcdad5b9565709be5349efb.1290631852.git.bengardiner@nanometrics.ca>
References: <1290524800-21419-10-git-send-email-juhosg@openwrt.org> <cover.1290631852.git.bengardiner@nanometrics.ca>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:52844 "HELO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756333Ab0KXVBs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Nov 2010 16:01:48 -0500
Received: by gxk24 with SMTP id 24so132653gxk.18
        for <linux-input@vger.kernel.org>; Wed, 24 Nov 2010 13:01:47 -0800 (PST)
In-Reply-To: <cover.1290631852.git.bengardiner@nanometrics.ca>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gabor Juhos <juhosg@openwrt.org>
Cc: linux-input@vger.kernel.org


Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
---
 include/linux/gpio_buttons.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/gpio_buttons.h b/include/linux/gpio_buttons.h
index 4d43de9..f7f1467 100644
--- a/include/linux/gpio_buttons.h
+++ b/include/linux/gpio_buttons.h
@@ -20,7 +20,7 @@
 struct gpio_buttons_platform_data {
 	struct gpio_keys_button *buttons;
 	int	nbuttons;		/* number of buttons */
-	int	poll_interval;		/* polling interval */
+	int	poll_interval;		/* polling interval in msecs*/
 };
 
 #endif /* _GPIO_BUTTONS_H_ */
-- 
1.7.0.4

