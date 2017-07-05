From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] input: keyboard: constify attribute_group structures.
Date: Wed,  5 Jul 2017 16:16:46 +0530
Message-ID: <5c9063817d021c487f3429a4fee60fa84e0e93d6.1499251467.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, geert+renesas@glider.be, linus.walleij@linaro.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

attribute_groups are not supposed to change at runtime. All functions
working with attribute_groups provided by <linux/sysfs.h> work with const
attribute_group. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
   5693	    464	      0	   6157	   180d	drivers/input/keyboard/gpio_keys.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   5749	    400	      0	   6149	   1805	drivers/input/keyboard/gpio_keys.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/input/keyboard/gpio_keys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index da3d362..55cf8aa 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -352,7 +352,7 @@ static DEVICE_ATTR(disabled_switches, S_IWUSR | S_IRUGO,
 	NULL,
 };
 
-static struct attribute_group gpio_keys_attr_group = {
+static const struct attribute_group gpio_keys_attr_group = {
 	.attrs = gpio_keys_attrs,
 };
 
-- 
1.9.1
