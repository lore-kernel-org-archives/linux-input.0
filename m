Return-Path: <SRS0=5/zS=7C=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E733C433E0
	for <linux-input@archiver.kernel.org>; Wed, 20 May 2020 15:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 794D4206B6
	for <linux-input@archiver.kernel.org>; Wed, 20 May 2020 15:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgETPj7 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 20 May 2020 11:39:59 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38850 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgETPjv (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 20 May 2020 11:39:51 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 856132A0313
Received: by jupiter.universe (Postfix, from userid 1000)
        id 6DD05480103; Wed, 20 May 2020 17:39:45 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ahmet Inan <inan@distec.de>,
        Martin Fuzzey <martin.fuzzey@flowbird.group>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv3 5/5] Input: EXC3000: Add reset gpio support
Date:   Wed, 20 May 2020 17:39:36 +0200
Message-Id: <20200520153936.46869-6-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520153936.46869-1-sebastian.reichel@collabora.com>
References: <20200520153936.46869-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Add basic support for an optional reset gpio.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../input/touchscreen/eeti,exc3000.yaml         |  2 ++
 drivers/input/touchscreen/exc3000.c             | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/eeti,exc3000.yaml b/Documentation/devicetree/bindings/input/touchscreen/eeti,exc3000.yaml
index 7e6e23f8fa00..007adbc89c14 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/eeti,exc3000.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/eeti,exc3000.yaml
@@ -22,6 +22,8 @@ properties:
     const: 0x2a
   interrupts:
     maxItems: 1
+  reset-gpios:
+    maxItems: 1
   touchscreen-size-x: true
   touchscreen-size-y: true
   touchscreen-inverted-x: true
diff --git a/drivers/input/touchscreen/exc3000.c b/drivers/input/touchscreen/exc3000.c
index b5a3bbb63504..de9d0ae1210a 100644
--- a/drivers/input/touchscreen/exc3000.c
+++ b/drivers/input/touchscreen/exc3000.c
@@ -8,7 +8,9 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
 #include <linux/input/mt.h>
@@ -33,6 +35,9 @@
 
 #define EXC3000_TIMEOUT_MS		100
 
+#define EXC3000_RESET_MS		10
+#define EXC3000_READY_MS		100
+
 static const struct i2c_device_id exc3000_id[];
 
 struct eeti_dev_info {
@@ -66,6 +71,7 @@ struct exc3000_data {
 	const struct eeti_dev_info *info;
 	struct input_dev *input;
 	struct touchscreen_properties prop;
+	struct gpio_desc *reset;
 	struct timer_list timer;
 	u8 buf[2 * EXC3000_LEN_FRAME];
 	struct completion wait_event;
@@ -325,6 +331,17 @@ static int exc3000_probe(struct i2c_client *client)
 	init_completion(&data->wait_event);
 	mutex_init(&data->query_lock);
 
+	data->reset = devm_gpiod_get_optional(&client->dev, "reset",
+					      GPIOD_OUT_HIGH);
+	if (IS_ERR(data->reset))
+		return PTR_ERR(data->reset);
+
+	if (data->reset) {
+		msleep(EXC3000_RESET_MS);
+		gpiod_set_value_cansleep(data->reset, 0);
+		msleep(EXC3000_READY_MS);
+	}
+
 	input = devm_input_allocate_device(&client->dev);
 	if (!input)
 		return -ENOMEM;
-- 
2.26.2

