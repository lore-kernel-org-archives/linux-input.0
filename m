From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH 3.0-rc1 v2] Input: omap-keypad: add missing input_sync()
Date: Sat, 4 Jun 2011 17:00:41 +0200
Message-ID: <201106041700.44677.jkrzyszt@tis.icnet.pl>
References: <201106032226.44976.jkrzyszt@tis.icnet.pl> <20110604123530.GA1530@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:44115 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756706Ab1FDPBV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 4 Jun 2011 11:01:21 -0400
In-Reply-To: <20110604123530.GA1530@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Otherwise the updated evdev driver (commit cdda911c34006f1089f3c87b1a1f, 
"Input: evdev - only signal polls on full packets") no longer works on 
top of omap-keypad.

Tested on Amstrad Delta.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
v1 -> v2 change, suggested by Henrik Rydberg (thanks!):
- no need for a special variable tracing if input_sync is required - 
  the input core already does the same thing.

 drivers/input/keyboard/omap-keypad.c |    1 +
 1 file changed, 1 insertion(+)

--- git/drivers/input/keyboard/omap-keypad.c.orig	2011-06-04 16:18:37.000000000 +0200
+++ git/drivers/input/keyboard/omap-keypad.c	2011-06-04 16:46:23.000000000 +0200
@@ -209,6 +209,7 @@ static void omap_kp_tasklet(unsigned lon
 #endif
 		}
 	}
+	input_sync(omap_kp_data->input);
 	memcpy(keypad_state, new_state, sizeof(keypad_state));
 
 	if (key_down) {
