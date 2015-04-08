From: Steve Twiss <stwiss.opensource@diasemi.com>
Subject: [PATCH V1 2/2] devicetree: Add bindings for DA9063 OnKey
Date: Wed, 8 Apr 2015 15:53:24 +0100
Message-ID: <addbebc419ed2d693d398e07131c119cd1d4160b.1428504804.git.stwiss.opensource@diasemi.com>
References: <cover.1428504804.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail1.bemta3.messagelabs.com ([195.245.230.177]:58239 "EHLO
	mail1.bemta3.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754116AbbDHPIs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 8 Apr 2015 11:08:48 -0400
In-Reply-To: <cover.1428504804.git.stwiss.opensource@diasemi.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Steve Twiss <stwiss.opensource@diasemi.com>
Cc: DT <devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, INPUT <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Samuel Ortiz <sameo@linux.intel.com>

From: Steve Twiss <stwiss.opensource@diasemi.com>

Add device tree bindings for the DA9063 OnKey driver

This patch is dependent on PATCH V1 1/2 

Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

---
This patch applies against linux-next and v4.0-rc6 


 Documentation/devicetree/bindings/mfd/da9063.txt | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/da9063.txt b/Documentation/devicetree/bindings/mfd/da9063.txt
index 42c6fa6..3449b75 100644
--- a/Documentation/devicetree/bindings/mfd/da9063.txt
+++ b/Documentation/devicetree/bindings/mfd/da9063.txt
@@ -2,9 +2,10 @@
 
 DA9093 consists of a large and varied group of sub-devices (I2C Only):
 
-Device                   Supply Names    Description
-------                   ------------    -----------
+Device			 Supply Names	 Description
+------			 ------------	 -----------
 da9063-regulator        :               : LDOs & BUCKs
+da9063-onkey            :               : On Key
 da9063-rtc              :               : Real-Time Clock
 da9063-watchdog         :               : Watchdog
 
@@ -51,6 +52,18 @@ Sub-nodes:
   the DA9063. There are currently no entries in this binding, however
   compatible = "dlg,da9063-rtc" should be added if a node is created.
 
+- onkey : This node defines the OnKey settings for controlling the key
+  functionality of the device. The node should contain the compatible keyword
+  with the value "dlg,da9063-onkey".
+
+  The platform data needs to match the OTP content of high address register
+  DA9063_REG_CONFIG_I and the device tree entry "dlg,disable-key-power" can
+  be used to control this. If the onkey node contains "dlg,disable-key-power"
+  then the power down using a long key-press is disabled. If this entry is
+  missing then by default the key-press triggered power down is enabled.
+  By toggling this key-power keyword the OnKey driver will support KEY_POWER
+  and KEY_SLEEP key presses.
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
end-of-patch for PATCH V1

