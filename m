From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 1/2] devicetree: bindings: Update gpio-keys-polled with support for abs/rel axis
Date: Thu, 17 Sep 2015 18:14:39 -0400
Message-ID: <1442528080-28712-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45994 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751868AbbIQWOy (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Sep 2015 18:14:54 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>

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
---
 Documentation/devicetree/bindings/input/gpio-keys-polled.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/gpio-keys-polled.txt b/Documentation/devicetree/bindings/input/gpio-keys-polled.txt
index 5b91f5a..05f8ebe 100644
--- a/Documentation/devicetree/bindings/input/gpio-keys-polled.txt
+++ b/Documentation/devicetree/bindings/input/gpio-keys-polled.txt
@@ -13,11 +13,16 @@ Subnode properties:
 
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
+	  are released.
 	- debounce-interval: Debouncing interval time in milliseconds.
 	  If not specified defaults to 5.
 	- wakeup-source: Boolean, button can wake-up the system.
-- 
2.4.3

