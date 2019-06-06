From: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: [PATCH v5 1/3] Input: elan_i2c: Add comment about link between elan_i2c and hid-quirks
Date: Thu,  6 Jun 2019 09:13:12 -0700
Message-ID: <20190606161312.47143-1-jeffrey.l.hugo@gmail.com>
References: <20190606161055.47089-1-jeffrey.l.hugo@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190606161055.47089-1-jeffrey.l.hugo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com, jikos@kernel.org
Cc: bjorn.andersson@linaro.org, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, agross@kernel.org, david.brown@linaro.org, hdegoede@redhat.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
List-Id: linux-input@vger.kernel.org

Elan_i2c and hid-quirks work in conjunction to decide which devices each
driver will handle.  Document this link in elan_i2c as a reminder that
updates to elan_i2c need to be mirrored to hid-quirks.

Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
---
 drivers/input/mouse/elan_i2c_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 65cd325eabc3..4cb49925a8b4 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1374,6 +1374,10 @@ static const struct i2c_device_id elan_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, elan_id);
 
+/*
+ * when these whitelists get updated, the corresponding blacklist in hid-quirks
+ * needs to be updated to match.
+ */
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id elan_acpi_id[] = {
 	{ "ELAN0000", 0 },
-- 
2.17.1
