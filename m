From: S Twiss <stwiss.opensource@diasemi.com>
Subject: [PATCH V2 2/3] devicetree: da9062: Add device tree bindings for
 DA9062 RTC
Date: Tue, 21 Jul 2015 10:43:09 +0100
Message-ID: <4e56d79b368e5ba3a15ad32ef08bc5095d8f7217.1437471790.git.stwiss.opensource@diasemi.com>
References: <cover.1437471790.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1437471790.git.stwiss.opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: DEVICETREE <devicetree@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, LINUXINPUT <linux-input@vger.kernel.org>, LINUXKERNEL <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, RTCLINUX <rtc-linux@googlegroups.com>, Rob Herring <robh+dt@kernel.org>, S Twiss <stwiss.opensource@diasemi.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, David Dajun Chen <david.chen@diasemi.com>, Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Support Opensource <support.opensource@diasemi.com>
List-Id: linux-input@vger.kernel.org

From: S Twiss <stwiss.opensource@diasemi.com>

Add device tree bindings for the DA9062 RTC driver component

Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

---
Checks performed with linux-next/next-20150708/scripts/checkpatch.pl
 da9062.txt                total: 0 errors, 0 warnings, 88 lines checked
This patch applies against linux-next and next-20150708 


 Documentation/devicetree/bindings/mfd/da9062.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt b/Documentation/devicetree/bindings/mfd/da9062.txt
index 5765ed9..38802b5 100644
--- a/Documentation/devicetree/bindings/mfd/da9062.txt
+++ b/Documentation/devicetree/bindings/mfd/da9062.txt
@@ -5,6 +5,7 @@ DA9062 consists of a large and varied group of sub-devices:
 Device                   Supply Names    Description
 ------                   ------------    -----------
 da9062-regulator        :               : LDOs & BUCKs
+da9062-rtc              :               : Real-Time Clock
 da9062-watchdog         :               : Watchdog Timer
 
 ======
@@ -41,6 +42,10 @@ Sub-nodes:
   Documentation/devicetree/bindings/regulator/regulator.txt
 
 
+- rtc : This node defines settings required for the Real-Time Clock associated
+  with the DA9062. There are currently no entries in this binding, however
+  compatible = "dlg,da9062-rtc" should be added if a node is created.
+
 - watchdog: This node defines the settings for the watchdog driver associated
   with the DA9062 PMIC. The compatible = "dlg,da9062-watchdog" should be added
   if a node is created.
@@ -55,6 +60,10 @@ Example:
 		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 
+		rtc {
+			compatible = "dlg,da9062-rtc";
+		};
+
 		watchdog {
 			compatible = "dlg,da9062-watchdog";
 		};
-- 
end-of-patch for PATCH V2
