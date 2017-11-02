From: Andi Shyti <andi@etezian.org>
Subject: [PATCH 5/5] Input: ad7897 - use separate error handling for different allocators
Date: Thu,  2 Nov 2017 17:01:36 +0200
Message-ID: <20171102150136.1476-6-andi@etezian.org>
References: <20171102150136.1476-1-andi@etezian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171102150136.1476-1-andi@etezian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>, Andi Shyti <andi.shyti@samsung.com>
List-Id: linux-input@vger.kernel.org

Split the error between devm_kzalloc and
devm_input_allocate_device, there is no need to call the second
allocator if the first has failed. Besides this doesn't provide
practical advantages.

CC: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Andi Shyti <andi@etezian.org>
---
 drivers/input/touchscreen/ad7877.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchscreen/ad7877.c
index c8a143db8681..dc2cb99dc43d 100644
--- a/drivers/input/touchscreen/ad7877.c
+++ b/drivers/input/touchscreen/ad7877.c
@@ -708,6 +708,9 @@ static int ad7877_probe(struct spi_device *spi)
 	}
 
 	ts = devm_kzalloc(&spi->dev, sizeof(struct ad7877), GFP_KERNEL);
+	if (!ts)
+		return -ENOMEM;
+
 	input_dev = devm_input_allocate_device(&spi->dev);
 	if (!input_dev)
 		return -ENOMEM;
-- 
2.15.0
