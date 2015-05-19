From: S Twiss <stwiss.opensource@diasemi.com>
Subject: [RESEND PATCH V4 2/3] devicetree: Add bindings for DA9063 OnKey
Date: Tue, 19 May 2015 11:32:45 +0100
Message-ID: <72933a3c053b445e7998c818b7a73317fa1e2d8a.1432031565.git.stwiss.opensource@diasemi.com>
References: <cover.1432031565.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail1.bemta14.messagelabs.com ([193.109.254.119]:50037 "EHLO
	mail1.bemta14.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753121AbbESKhq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 May 2015 06:37:46 -0400
In-Reply-To: <cover.1432031565.git.stwiss.opensource@diasemi.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Steve Twiss <stwiss.opensource@diasemi.com>
Cc: DT <devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, INPUT <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Support Opensource <support.opensource@diasemi.com>

From: Steve Twiss <stwiss.opensource@diasemi.com>

Add device tree bindings for the DA9063 OnKey driver

Acked-by: Lee Jones <lee.jones@linaro.org>

Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

---
Version History

Changes in V4
 - No change

Changes in V3
 - No change

Changes in V2
 - Remove the circular dependency comment linking patches in the main e-mail
 - Search and replace 'keyword' with 'property' in onkey sub-node description
 - Reformat onkey sub-node content to move the description for key-power into
   a new optional properties sub-section so it has a more promiment position

This patch applies against linux-next and v4.1-rc3 


 Documentation/devicetree/bindings/mfd/da9063.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/da9063.txt b/Documentation/devicetree/bindings/mfd/da9063.txt
index 42c6fa6..05b21bc 100644
--- a/Documentation/devicetree/bindings/mfd/da9063.txt
+++ b/Documentation/devicetree/bindings/mfd/da9063.txt
@@ -5,6 +5,7 @@ DA9093 consists of a large and varied group of sub-devices (I2C Only):
 Device                   Supply Names    Description
 ------                   ------------    -----------
 da9063-regulator        :               : LDOs & BUCKs
+da9063-onkey            :               : On Key
 da9063-rtc              :               : Real-Time Clock
 da9063-watchdog         :               : Watchdog
 
@@ -51,6 +52,18 @@ Sub-nodes:
   the DA9063. There are currently no entries in this binding, however
   compatible = "dlg,da9063-rtc" should be added if a node is created.
 
+- onkey : This node defines the OnKey settings for controlling the key
+  functionality of the device. The node should contain the compatible property
+  with the value "dlg,da9063-onkey".
+
+  Optional onkey properties:
+
+  - dlg,disable-key-power : Disable power-down using a long key-press. If this
+    entry exists the OnKey driver will remove support for the KEY_POWER key
+    press. If this entry does not exist then by default the key-press
+    triggered power down is enabled and the OnKey will support both KEY_POWER
+    and KEY_SLEEP.
+
 - watchdog : This node defines settings for the Watchdog timer associated
   with the DA9063. There are currently no entries in this binding, however
   compatible = "dlg,da9063-watchdog" should be added if a node is created.
@@ -73,6 +86,11 @@ Example:
 			compatible = "dlg,da9063-watchdog";
 		};
 
+		onkey {
+			compatible = "dlg,da9063-onkey";
+			dlg,disable-key-power;
+		};
+
 		regulators {
 			DA9063_BCORE1: bcore1 {
 				regulator-name = "BCORE1";
-- 
end-of-patch for RESEND PATCH V4

