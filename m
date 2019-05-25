From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] Input: tca8418 - Remove set but not used variable ''
Date: Sat, 25 May 2019 22:29:21 +0800
Message-ID: <20190525142921.18812-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: linux-input@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/input/keyboard/tca8418_keypad.c: In function tca8418_keypad_probe:
drivers/input/keyboard/tca8418_keypad.c:269:24: warning: variable max_keys set but not used [-Wunused-but-set-variable]

It's not used since commit 16ff7cb1848a ("Input:
tca8418-keypad - switch to using managed resources")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/input/keyboard/tca8418_keypad.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
index 6da607d3b811..3bbd7e652533 100644
--- a/drivers/input/keyboard/tca8418_keypad.c
+++ b/drivers/input/keyboard/tca8418_keypad.c
@@ -266,7 +266,7 @@ static int tca8418_keypad_probe(struct i2c_client *client,
 	struct tca8418_keypad *keypad_data;
 	struct input_dev *input;
 	u32 rows = 0, cols = 0;
-	int error, row_shift, max_keys;
+	int error, row_shift;
 	u8 reg;
 
 	/* Check i2c driver capabilities */
@@ -291,7 +291,6 @@ static int tca8418_keypad_probe(struct i2c_client *client,
 	}
 
 	row_shift = get_count_order(cols);
-	max_keys = rows << row_shift;
 
 	/* Allocate memory for keypad_data and input device */
 	keypad_data = devm_kzalloc(dev, sizeof(*keypad_data), GFP_KERNEL);
-- 
2.17.1
