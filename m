From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] HID: i2c-hid: Add a small delay after powering on/off the device
Date: Mon,  1 Oct 2018 11:53:13 +0800
Message-ID: <20181001035313.21453-1-kai.heng.feng@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org
Cc: benjamin.tissoires@redhat.com, hdegoede@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Kai-Heng Feng <kai.heng.feng@canonical.com>
List-Id: linux-input@vger.kernel.org

Raydium touchpanel (2386:4B33) sometimes does not workin desktop session
although it works in display manager.

During user logging, the display manager exits, close the HID device,
then the device gets runtime suspended and powered off. The desktop
session begins shortly after, opens the HID device, then the device gets
runtime resumed and powered on.

If the trasition from display manager to desktop sesesion is fast, the
touchpanel cannot switch from powered off to powered on in short
timeframe. So add a small delay to workaround the issue.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/hid/i2c-hid/i2c-hid.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index f3076659361a..ff5682cc1bce 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -409,6 +409,8 @@ static int i2c_hid_set_power(struct i2c_client *client, int power_state)
 
 	if (ret)
 		dev_err(&client->dev, "failed to change power setting.\n");
+	else
+		msleep(20);
 
 set_pwr_exit:
 	return ret;
-- 
2.17.1
