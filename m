From: Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v2 5/5] input: goodix - Call of_device_links_add() to create links
Date: Wed, 15 May 2019 15:11:54 +0200
Message-ID: <20190515131154.18373-6-benjamin.gaignard@st.com>
References: <20190515131154.18373-1-benjamin.gaignard@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190515131154.18373-1-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rafael.j.wysocki@intel.com, dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, hadess@hadess.net, frowand.list@gmail.com, m.felsch@pengutronix.de, agx@sigxcpu.org, arnd@arndb.de
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, broonie@kernel.org, Benjamin Gaignard <benjamin.gaignard@st.com>
List-Id: linux-input@vger.kernel.org

Add a call to of_device_links_add() to create links with
suspend dependencies at probe time.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/input/touchscreen/goodix.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index f57d82220a88..49fd4763f17b 100644
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
 
+	of_device_links_add(&client->dev);
+
 	if (ts->gpiod_int && ts->gpiod_rst) {
 		/* update device config */
 		ts->cfg_name = devm_kasprintf(&client->dev, GFP_KERNEL,
-- 
2.15.0
