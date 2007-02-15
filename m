From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [PATCH] gpio-keys
Date: Thu, 15 Feb 2007 13:19:06 +0100
Message-ID: <1171541946.4325.3.camel@localhost.localdomain>
References: <1171537620.27151.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <1171537620.27151.5.camel@localhost.localdomain>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-input@atrey.karlin.mff.cuni.cz
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

And a small compile fix, 'ret' was renamed to 'error'.

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>

Index: linux-2.6/drivers/input/keyboard/gpio_keys.c
===================================================================
--- linux-2.6.orig/drivers/input/keyboard/gpio_keys.c	2007-02-15 13:12:21.000000000 +0100
+++ linux-2.6/drivers/input/keyboard/gpio_keys.c	2007-02-15 13:10:43.000000000 +0100
@@ -82,7 +82,7 @@
 				     pdata->buttons[i].desc ? pdata->buttons[i].desc : "gpio_keys",
 				     pdev);
 		if (error) {
-			printk(KERN_ERR "gpio-keys: unable to claim irq %d; error %d\n", irq, ret);
+			printk(KERN_ERR "gpio-keys: unable to claim irq %d; error %d\n", irq, error);
 			goto fail;
 		}
 		set_bit(code, input->keybit);
