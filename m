From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 02/17] clk: sunxi: Propagate rate changes to parent for mux clocks
Date: Tue,  6 Jan 2015 10:35:12 +0800
Message-ID: <1420511727-8242-3-git-send-email-wens@csie.org>
References: <1420511727-8242-1-git-send-email-wens@csie.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:40937 "EHLO
	smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754311AbbAFCfl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Jan 2015 21:35:41 -0500
In-Reply-To: <1420511727-8242-1-git-send-email-wens@csie.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

The cpu clock on sunxi machines is just a mux clock, which is normally
fed by the main PLL, but can be muxed to the main or low power oscillator.

Make the mux clock propagate rate changes to its parent, so we can
change the clock rate of the PLL, and thus actually implement rate
changing on the cpu clock.

This patch also removes the no reparenting limit.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi/clk-sunxi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index d8f17bbcb8e3..df18a2af33ad 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -778,7 +778,7 @@ static void __init sunxi_mux_clk_setup(struct device_node *node,
 	of_property_read_string(node, "clock-output-names", &clk_name);
 
 	clk = clk_register_mux(NULL, clk_name, parents, i,
-			       CLK_SET_RATE_NO_REPARENT, reg,
+			       CLK_SET_RATE_PARENT, reg,
 			       data->shift, SUNXI_MUX_GATE_WIDTH,
 			       0, &clk_lock);
 
-- 
2.1.4

