From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 01/22 v4] Input: atmel_mxt_ts - set phys to i2c client adapter name
Date: Mon, 18 Jun 2012 12:08:21 +0800
Message-ID: <1339992522-22073-2-git-send-email-djkurtz@chromium.org>
References: <1339992522-22073-1-git-send-email-djkurtz@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1339992522-22073-1-git-send-email-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Nick Dyer <nick.dyer@itdev.co.uk>, linux-input@vger.kernel.org
Cc: Iiro Valkonen <iiro.valkonen@atmel.com>, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, Olof Johansson <olofj@chromium.org>, linux-kernel@vger.kernel.org, Daniel Kurtz <djkurtz@chromium.org>
List-Id: linux-input@vger.kernel.org

This allows userspace to more easily distinguish which bus a particular
atmel_mxt_ts device is attached to.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 42e6450..eda9eed 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1106,6 +1106,7 @@ static int __devinit mxt_probe(struct i2c_client *client,
 	}
 
 	input_dev->name = "Atmel maXTouch Touchscreen";
+	input_dev->phys = client->adapter->name;
 	input_dev->id.bustype = BUS_I2C;
 	input_dev->dev.parent = &client->dev;
 	input_dev->open = mxt_input_open;
-- 
1.7.7.3
