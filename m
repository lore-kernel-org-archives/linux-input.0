From: Dudley Du <dudl@cypress.com>
Subject: [PATCH 1/3] input: cyapa: add regulator vcc support
Date: Fri, 24 Jul 2015 13:05:57 +0800
Message-ID: <1437714359-2484-2-git-send-email-dudl@cypress.com>
References: <1437714359-2484-1-git-send-email-dudl@cypress.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437714359-2484-1-git-send-email-dudl@cypress.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, mark.rutland@arm.com, robh+dt@kernel.org
Cc: Dudley Du <dudl@cypress.com>, bleung@google.com, jmmahler@gmail.com, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Add power management regulator vcc support.
It's described to be supported in the cypress,cyapa.txt document.

Signed-off-by: Dudley Du <dudl@cypress.com>
---
 drivers/input/mouse/cyapa.c | 28 ++++++++++++++++++++++++++++
 drivers/input/mouse/cyapa.h |  1 +
 2 files changed, 29 insertions(+)

diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
index 6195ccb..2159c5e 100644
--- a/drivers/input/mouse/cyapa.c
+++ b/drivers/input/mouse/cyapa.c
@@ -1241,6 +1241,13 @@ static void cyapa_remove_sysfs_group(void *data)
 	sysfs_remove_group(&cyapa->client->dev.kobj, &cyapa_sysfs_group);
 }
 
+static void cyapa_disable_regulator(void *data)
+{
+	struct cyapa *cyapa = data;
+
+	regulator_disable(cyapa->vcc);
+}
+
 static int cyapa_probe(struct i2c_client *client,
 		       const struct i2c_device_id *dev_id)
 {
@@ -1274,6 +1281,27 @@ static int cyapa_probe(struct i2c_client *client,
 	sprintf(cyapa->phys, "i2c-%d-%04x/input0", client->adapter->nr,
 		client->addr);
 
+	cyapa->vcc = devm_regulator_get(dev, "vcc");
+	if (IS_ERR(cyapa->vcc)) {
+		error = PTR_ERR(cyapa->vcc);
+		dev_err(dev, "failed to get vcc regulator: %d\n", error);
+		return error;
+	}
+
+	error = regulator_enable(cyapa->vcc);
+	if (error) {
+		dev_err(dev, "failed to enable regulator: %d\n", error);
+		return error;
+	}
+
+	error = devm_add_action(dev, cyapa_disable_regulator, cyapa);
+	if (error) {
+		cyapa_disable_regulator(cyapa);
+		dev_err(dev, "failed to add disable regulator action: %d\n",
+			error);
+		return error;
+	}
+
 	error = cyapa_initialize(cyapa);
 	if (error) {
 		dev_err(dev, "failed to detect and initialize tp device.\n");
diff --git a/drivers/input/mouse/cyapa.h b/drivers/input/mouse/cyapa.h
index af12536..b812bba 100644
--- a/drivers/input/mouse/cyapa.h
+++ b/drivers/input/mouse/cyapa.h
@@ -321,6 +321,7 @@ struct cyapa {
 	u8 status[BL_STATUS_SIZE];
 	bool operational; /* true: ready for data reporting; false: not. */
 
+	struct regulator *vcc;
 	struct i2c_client *client;
 	struct input_dev *input;
 	char phys[32];	/* Device physical location */
-- 
1.9.1


---------------------------------------------------------------
This message and any attachments may contain Cypress (or its
subsidiaries) confidential information. If it has been received
in error, please advise the sender and immediately delete this
message.
---------------------------------------------------------------
