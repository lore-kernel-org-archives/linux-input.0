From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2] input: bma150: Only claim to support the bma180 if the
 separate iio bma180 driver is not build
Date: Mon, 14 Nov 2016 14:11:14 +0100
Message-ID: <20161114131114.6053-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Hans de Goede <hdegoede@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

commit ef3714fdbc8d ("Input: bma150 - extend chip detection for bma180"),
adds bma180 chip-ids to the input bma150 driver, assuming that they are
100% compatible, but the bma180 is not compatible with the bma150 at all,
it has 14 bits resolution instead of 10, and it has quite different
control registers too.

Treating the bma180 as a bma150 wrt its data registers will just result
in throwing away the lowest 4 bits, which is not too bad. But the ctrl
registers are a different story. Things happen to just work but supporting
that certainly does not make treating the bma180 the same as the bma150
right.

Since some setups depend on the evdev interface the bma150 driver offers
on top of the bma180, we cannot simply remove the bma180 ids.

So this commit only removes the bma180 id when the bma180 iio driver,
which does treat the bma180 properly, is enabled.

Cc: Dr. H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Use IS_ENABLED(CONFIG_BMA180) instead of #ifdef CONFIG_BMA180
---
 drivers/input/misc/bma150.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/bma150.c b/drivers/input/misc/bma150.c
index b0d4453..2124390 100644
--- a/drivers/input/misc/bma150.c
+++ b/drivers/input/misc/bma150.c
@@ -538,8 +538,13 @@ static int bma150_probe(struct i2c_client *client,
 		return -EIO;
 	}
 
+	/*
+	 * Note if the IIO CONFIG_BMA180 driver is enabled we want to fail
+	 * the probe for the bma180 as the iio driver is preferred.
+	 */
 	chip_id = i2c_smbus_read_byte_data(client, BMA150_CHIP_ID_REG);
-	if (chip_id != BMA150_CHIP_ID && chip_id != BMA180_CHIP_ID) {
+	if (chip_id != BMA150_CHIP_ID &&
+	    (IS_ENABLED(CONFIG_BMA180) || chip_id != BMA180_CHIP_ID)) {
 		dev_err(&client->dev, "BMA150 chip id error: %d\n", chip_id);
 		return -EINVAL;
 	}
@@ -643,7 +648,9 @@ static UNIVERSAL_DEV_PM_OPS(bma150_pm, bma150_suspend, bma150_resume, NULL);
 
 static const struct i2c_device_id bma150_id[] = {
 	{ "bma150", 0 },
+#if !IS_ENABLED(CONFIG_BMA180)
 	{ "bma180", 0 },
+#endif
 	{ "smb380", 0 },
 	{ "bma023", 0 },
 	{ }
-- 
2.9.3
