From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] Input: gpio_keys_polled - use struct_size() in devm_kzalloc()
Date: Wed, 19 Jun 2019 09:26:55 -0500
Message-ID: <20190619142655.GA20218@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-input@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct gpio_keys_polled_dev {
	...
        struct gpio_keys_button_data data[0];
};

size = sizeof(struct gpio_keys_polled_dev) + count * sizeof(struct gpio_keys_button_data);
instance = devm_kzalloc(dev, size, GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = devm_kzalloc(dev, struct_size(instance, data, count), GFP_KERNEL);

Notice that, in this case, variable size is not necessary, hence it
is removed.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/input/keyboard/gpio_keys_polled.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index edc7262103b9..c4087be0c2e0 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -235,7 +235,6 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 	struct gpio_keys_polled_dev *bdev;
 	struct input_polled_dev *poll_dev;
 	struct input_dev *input;
-	size_t size;
 	int error;
 	int i;
 
@@ -250,9 +249,8 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	size = sizeof(struct gpio_keys_polled_dev) +
-			pdata->nbuttons * sizeof(struct gpio_keys_button_data);
-	bdev = devm_kzalloc(dev, size, GFP_KERNEL);
+	bdev = devm_kzalloc(dev, struct_size(bdev, data, pdata->nbuttons),
+			    GFP_KERNEL);
 	if (!bdev) {
 		dev_err(dev, "no memory for private data\n");
 		return -ENOMEM;
-- 
2.21.0
