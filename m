From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 3/3] Revert "dt-bindings: marvell,mmp2: Add clock id for the SP clock"
Date: Mon, 21 Jan 2019 07:22:56 +0100
Message-ID: <20190121062255.551587-4-lkundrak@v3.sk>
References: <20190121062255.551587-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190121062255.551587-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
List-Id: linux-input@vger.kernel.org

It seems that the kernel has no business managing this clock: once the SP
clock is disabled, it's not sufficient to just enable it in order to brin=
g
the SP core back up.

Pretty sure nothing ever used this and it's safe to remove.

This reverts commit e8a2c779141415105825e65a4715f1130bba61b1.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 include/dt-bindings/clock/marvell,mmp2.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/dt-bindings/clock/marvell,mmp2.h b/include/dt-bindin=
gs/clock/marvell,mmp2.h
index 7b24fc791146..228a5e234af0 100644
--- a/include/dt-bindings/clock/marvell,mmp2.h
+++ b/include/dt-bindings/clock/marvell,mmp2.h
@@ -71,7 +71,6 @@
 #define MMP2_CLK_CCIC1_MIX		117
 #define MMP2_CLK_CCIC1_PHY		118
 #define MMP2_CLK_CCIC1_SPHY		119
-#define MMP2_CLK_SP			120
=20
 #define MMP2_NR_CLKS			200
 #endif
--=20
2.20.1
