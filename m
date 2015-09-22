From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 1/4] devicetree: bindings: Update gpio-keys-polled with support for abs/rel axis
Date: Tue, 22 Sep 2015 15:23:57 +0200
Message-ID: <1442928240-2452-2-git-send-email-hdegoede@redhat.com>
References: <1442928240-2452-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56527 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932214AbbIVNYF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Sep 2015 09:24:05 -0400
In-Reply-To: <1442928240-2452-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>

The devicetree binding for gpio-keys-polled already allows specifying
what type of events (key / rel / abs) a button generates when pressed.

But for rel / abs axis we also need to specify which value this specific
gpio represents.

One usecase is digital joysticks / direction-pads which are hooked up to
gpio, in this case we've left and right buttons which we want to map to
EV_ABS, ABS_X and we want generate events for left with a value of -1 and
for right with a value of +1 (and similar for up / down and ABS_Y).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes in v2:
-Add Rob's ack
-s/send/sent/
-Make the remarks of axis reporting a value of 0 when all buttons tied to
 that axis are released also apply to EV_REL axis
Changes in v3:
-Document that linux,input-value is a *signed* 32 bit variable and an example
 how to specify a negative value
---
 Documentation/devicetree/bindings/input/gpio-keys-polled.txt | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/gpio-keys-polled.txt b/Documentation/devicetree/bindings/input/gpio-keys-polled.txt
index 5b91f5a..97e2467 100644
--- a/Documentation/devicetree/bindings/input/gpio-keys-polled.txt
+++ b/Documentation/devicetree/bindings/input/gpio-keys-polled.txt
@@ -13,11 +13,18 @@ Subnode properties:
 
 	- gpios: OF device-tree gpio specification.
 	- label: Descriptive name of the key.
-	- linux,code: Keycode to emit.
+	- linux,code: Key / Axis code to emit.
 
 Optional subnode-properties:
 	- linux,input-type: Specify event type this button/key generates.
 	  If not specified defaults to <1> == EV_KEY.
+	- linux,input-value: If linux,input-type is EV_ABS or EV_REL then this
+	  value is sent for events this button generates when pressed.
+	  EV_ABS/EV_REL axis will generate an event with a value of 0 when
+	  all buttons with linux,input-type == type and linux,code == axis
+	  are released. This value is interpreted as a signed 32 bit value,
+	  e.g. to make a button generate a value of -1 use:
+	  linux,input-value = <0xffffffff>; /* -1 */
 	- debounce-interval: Debouncing interval time in milliseconds.
 	  If not specified defaults to 5.
 	- wakeup-source: Boolean, button can wake-up the system.
-- 
2.4.3

