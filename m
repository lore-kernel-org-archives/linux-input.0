From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH v2 2/3] input: increase INPUT_DEVICES to 512 to allow dynamic minors
Date: Thu, 20 Sep 2012 19:52:02 +0200
Message-ID: <1348163523-2062-3-git-send-email-dh.herrmann@googlemail.com>
References: <1348163523-2062-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1348163523-2062-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, Bernie Thompson <bernie@plugable.com>, David Herrmann <dh.herrmann@googlemail.com>
List-Id: linux-input@vger.kernel.org

All minor numbers for input devices are currently reserved for static
allocations. So increase the maximum number of input-devices to 512 to
give room of 256 devices for dynamic-minor allocation.

register_chrdev uses 256 as default limit so we need to change this
function call to actually pass the new number of devices. This makes it
also clearer how many minor numbers are actually allocated.

Please note that this doesn't increase the memory footprint at all. The
major/minor allocations are no longer realized by lookup-tables so we
could even increase this to some insanely large value and wouldn't loose
any performance here.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/input/input.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 2741ce1..f8d985f 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -32,7 +32,7 @@ MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
 MODULE_DESCRIPTION("Input core");
 MODULE_LICENSE("GPL");
 
-#define INPUT_DEVICES	256
+#define INPUT_DEVICES 512
 
 static LIST_HEAD(input_dev_list);
 static LIST_HEAD(input_handler_list);
@@ -2310,7 +2310,8 @@ static int __init input_init(void)
 	if (err)
 		goto fail1;
 
-	err = register_chrdev(INPUT_MAJOR, "input", &input_fops);
+	err = __register_chrdev(INPUT_MAJOR, 0, INPUT_DEVICES, "input",
+				&input_fops);
 	if (err) {
 		pr_err("unable to register char major %d", INPUT_MAJOR);
 		goto fail2;
-- 
1.7.12
