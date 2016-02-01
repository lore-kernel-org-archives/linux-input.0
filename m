From: Sushaanth Srirangapathi <sushaanth.s@ti.com>
Subject: [PATCH 3/3] ARM: DTS: da850: add DT node for tps6507x-ts
Date: Mon, 1 Feb 2016 11:58:50 +0530
Message-ID: <1454308130-12452-5-git-send-email-sushaanth.s@ti.com>
References: <1454308130-12452-1-git-send-email-sushaanth.s@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1454308130-12452-1-git-send-email-sushaanth.s@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joe Perches <joe@perches.com>, Javier Martinez Canillas <javier@osg.samsung.com>
Cc: devicetree@vger.kernel.org, Sushaanth Srirangapathi <sushaanth.s@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

add tps6507x touchscreen device tree node information to
DA850 EVM

Signed-off-by: Sushaanth Srirangapathi <sushaanth.s@ti.com>
---
 arch/arm/boot/dts/da850-evm.dts |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index ef061e9..b4f54fc 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -222,6 +222,9 @@
 			regulator-boot-on;
 		};
 	};
+	touchscreen {
+		ti,min-pressure = <0x30>;
+	};
 };
 
 &mcasp0 {
-- 
1.7.9.5
