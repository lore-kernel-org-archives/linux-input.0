From: Andi Shyti <andi@etezian.org>
Subject: [PATCH v3 3/3] Input: ad7897 - use separate error handling for different allocators
Date: Wed,  8 Nov 2017 17:50:20 +0200
Message-ID: <20171108155020.3851-4-andi@etezian.org>
References: <20171108155020.3851-1-andi@etezian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171108155020.3851-1-andi@etezian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>, Andi Shyti <andi.shyti@samsung.com>
List-Id: linux-input@vger.kernel.org

Split the error between devm_kzalloc and
devm_input_allocate_device, there is no need to call the second
allocator if the first has failed. Besides this doesn't provide
practical advantages.

CC: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Andi Shyti <andi@etezian.org>
---
 drivers/input/touchscreen/ad7877.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchscreen/ad7877.c
index 04ab8fbc8184..98deffde3fe2 100644
--- a/drivers/input/touchscreen/ad7877.c
+++ b/drivers/input/touchscreen/ad7877.c
@@ -710,8 +710,11 @@ static int ad7877_probe(struct spi_device *spi)
 	}
 
 	ts = devm_kzalloc(&spi->dev, sizeof(struct ad7877), GFP_KERNEL);
+	if (!ts)
+		return -ENOMEM;
+
 	input_dev = devm_input_allocate_device(&spi->dev);
-	if (!ts || !input_dev)
+	if (!input_dev)
 		return -ENOMEM;
 
 	err = devm_add_action_or_reset(&spi->dev, ad7877_disable, ts);
-- 
2.15.0
