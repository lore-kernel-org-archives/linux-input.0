From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] Input: tca6416-keypad: use struct_size() in kzalloc()
Date: Tue, 8 Jan 2019 09:28:16 -0600
Message-ID: <20190108152816.GA7486@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-input@vger.kernel.org

One of the more common cases of allocation size calculations is finding the
size of a structure that has a zero-sized array at the end, along with memory
for some number of elements for that array. For example:

struct foo {
    int stuff;
    void *entry[];
};

instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can now
use the new struct_size() helper:

instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/input/keyboard/tca6416-keypad.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/tca6416-keypad.c b/drivers/input/keyboard/tca6416-keypad.c
index dc983ab6c0ad..cdeef180aead 100644
--- a/drivers/input/keyboard/tca6416-keypad.c
+++ b/drivers/input/keyboard/tca6416-keypad.c
@@ -219,9 +219,7 @@ static int tca6416_keypad_probe(struct i2c_client *client,
 		return -EINVAL;
 	}
 
-	chip = kzalloc(sizeof(struct tca6416_keypad_chip) +
-		       pdata->nbuttons * sizeof(struct tca6416_button),
-		       GFP_KERNEL);
+	chip = kzalloc(struct_size(chip, buttons, pdata->nbuttons), GFP_KERNEL);
 	input = input_allocate_device();
 	if (!chip || !input) {
 		error = -ENOMEM;
-- 
2.20.1
