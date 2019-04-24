From: Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 5/5] input: goodix - Call devm_of_device_links_add() to create links
Date: Wed, 24 Apr 2019 12:19:13 +0200
Message-ID: <20190424101913.1534-6-benjamin.gaignard@st.com>
References: <20190424101913.1534-1-benjamin.gaignard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190424101913.1534-1-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rafael.j.wysocki@intel.com, dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, hadess@hadess.net, frowand.list@gmail.com, m.felsch@pengutronix.de, agx@sigxcpu.org, yannick.fertre@st.com, arnd@arndb.de
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, broonie@kernel.org, Benjamin Gaignard <benjamin.gaignard@st.com>
List-Id: linux-input@vger.kernel.org

From: Yannick FertrÃ© <yannick.fertre@st.com>

Add a call to devm_of_device_links_add() to create links with suppliers
at probe time.

Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/input/touchscreen/goodix.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index f57d82220a88..9aefbfa39319 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -30,6 +30,7 @@
 #include <linux/slab.h>
 #include <linux/acpi.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <asm/unaligned.h>
 
 struct goodix_ts_data;
@@ -812,6 +813,8 @@ static int goodix_ts_probe(struct i2c_client *client,
 
 	ts->chip = goodix_get_chip_data(ts->id);
 
+	devm_of_device_links_add(&client->dev);
+
 	if (ts->gpiod_int && ts->gpiod_rst) {
 		/* update device config */
 		ts->cfg_name = devm_kasprintf(&client->dev, GFP_KERNEL,
-- 
2.15.0
