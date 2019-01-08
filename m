From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] Input: mcs_touchkey - use struct_size() in kzalloc()
Date: Tue, 8 Jan 2019 15:15:56 -0600
Message-ID: <20190108211556.GA5760@embeddedor>
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
 drivers/input/keyboard/mcs_touchkey.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/mcs_touchkey.c b/drivers/input/keyboard/mcs_touchkey.c
index be56d4f262a7..b132662201a4 100644
--- a/drivers/input/keyboard/mcs_touchkey.c
+++ b/drivers/input/keyboard/mcs_touchkey.c
@@ -113,9 +113,8 @@ static int mcs_touchkey_probe(struct i2c_client *client,
 		return -EINVAL;
 	}
 
-	data = kzalloc(sizeof(struct mcs_touchkey_data) +
-			sizeof(data->keycodes[0]) * (pdata->key_maxval + 1),
-			GFP_KERNEL);
+	data = kzalloc(struct_size(data, keycodes, pdata->key_maxval + 1),
+		       GFP_KERNEL);
 	input_dev = input_allocate_device();
 	if (!data || !input_dev) {
 		dev_err(&client->dev, "Failed to allocate memory\n");
-- 
2.20.1
