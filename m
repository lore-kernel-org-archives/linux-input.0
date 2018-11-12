From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 2/6] dt-bindings: marvell,mmp2: Add clock id for the SP clock
Date: Mon, 12 Nov 2018 03:30:25 +0100
Message-ID: <20181112023029.648408-3-lkundrak@v3.sk>
References: <20181112023029.648408-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181112023029.648408-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lubomir Rintel <lkundrak@v3.sk>
List-Id: linux-input@vger.kernel.org

This is the clock for the "security processor" core.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 include/dt-bindings/clock/marvell,mmp2.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/marvell,mmp2.h b/include/dt-bindin=
gs/clock/marvell,mmp2.h
index 228a5e234af0..7b24fc791146 100644
--- a/include/dt-bindings/clock/marvell,mmp2.h
+++ b/include/dt-bindings/clock/marvell,mmp2.h
@@ -71,6 +71,7 @@
 #define MMP2_CLK_CCIC1_MIX		117
 #define MMP2_CLK_CCIC1_PHY		118
 #define MMP2_CLK_CCIC1_SPHY		119
+#define MMP2_CLK_SP			120
=20
 #define MMP2_NR_CLKS			200
 #endif
--=20
2.19.1
