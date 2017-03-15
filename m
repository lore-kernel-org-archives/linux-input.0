From: Icenowy Zheng <icenowy@aosc.xyz>
Subject: [PATCH 1/4] dt-bindings: add vendor prefix for Shenzhen Nsiway
 Techonology Co., Ltd.
Date: Wed, 15 Mar 2017 23:51:37 +0800
Message-ID: <20170315155140.54518-2-icenowy@aosc.xyz>
References: <20170315155140.54518-1-icenowy@aosc.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170315155140.54518-1-icenowy@aosc.xyz>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: devicetree@vger.kernel.org, Icenowy Zheng <icenowy@aosc.xyz>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Shenzhen Nsiway Technology Co., Ltd. manufactures various analog ICs,
including pulse amplifiers, power management ICs and resistive
touchscreen controllers.

http://www.nsiway.com.cn

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 28c868638c6c..55ecac6737c3 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -215,6 +215,7 @@ newhaven	Newhaven Display International
 ni	National Instruments
 nintendo	Nintendo
 nokia	Nokia
+nsiway	Shenzhen Nsiway Technology Co., Ltd.
 nuvoton	Nuvoton Technology Corporation
 nvd	New Vision Display
 nvidia	NVIDIA
-- 
2.12.0
