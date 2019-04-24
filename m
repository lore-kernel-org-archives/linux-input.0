From: Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 3/5] input: edt-ft5x06 - Call devm_of_device_links_add() to create links
Date: Wed, 24 Apr 2019 12:19:11 +0200
Message-ID: <20190424101913.1534-4-benjamin.gaignard@st.com>
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
 drivers/input/touchscreen/edt-ft5x06.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 702bfda7ee77..ac9f7e85efb0 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -1167,6 +1167,8 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, tsdata);
 
+	devm_of_device_links_add(&client->dev);
+
 	irq_flags = irq_get_trigger_type(client->irq);
 	if (irq_flags == IRQF_TRIGGER_NONE)
 		irq_flags = IRQF_TRIGGER_FALLING;
-- 
2.15.0
