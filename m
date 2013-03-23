From: "Vishwanathrao Badarkhe, Manish" <manishv.b@ti.com>
Subject: [PATCH 2/2] ARM: davinci: da850: add tps6507x touchscreen DT data
Date: Sat, 23 Mar 2013 18:29:31 +0530
Message-ID: <1364043571-9210-3-git-send-email-manishv.b@ti.com>
References: <1364043571-9210-1-git-send-email-manishv.b@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1364043571-9210-1-git-send-email-manishv.b@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, linux-doc@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, rob@landley.net, rob.herring@calxeda.com, grant.likely@secretlab.ca, manishv.b@ti.com
List-Id: linux-input@vger.kernel.org

Add tps6507x touchscreen device tree data to da850-evm.

Signed-off-by: Vishwanathrao Badarkhe, Manish <manishv.b@ti.com>
---
:100644 100644 d1d091b... 5652501... M	arch/arm/boot/dts/da850-evm.dts
 arch/arm/boot/dts/da850-evm.dts |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index d1d091b..5652501 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -108,4 +108,13 @@
 			regulator-boot-on;
 		};
 	};
+
+	tsc {
+		ti,poll_period = <30>;
+		ti,min_pressure = <0x30>;
+		ti,vref = <0>;
+		ti,vendor = <0>;
+		ti,product = <65070>;
+		ti,version = <0x100>;
+	};
 };
-- 
1.7.4.1

