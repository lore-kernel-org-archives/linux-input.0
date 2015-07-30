From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] drivers/input/joystick: convert to dynamic input_dev
 allocation
Date: Thu, 30 Jul 2015 11:04:47 -0700
Message-ID: <20150730180447.GG13165@dtor-ws>
References: <20150728170024.GD21317@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:33977 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbbG3SEw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Jul 2015 14:04:52 -0400
Received: by pdbbh15 with SMTP id bh15so28017163pdb.1
        for <linux-input@vger.kernel.org>; Thu, 30 Jul 2015 11:04:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150728170024.GD21317@mwanda>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-input@vger.kernel.org

On Tue, Jul 28, 2015 at 08:00:24PM +0300, Dan Carpenter wrote:
> Hello Dmitry Torokhov,
> 
> The patch 17dd3f0f7aa7: "[PATCH] drivers/input/joystick: convert to
> dynamic input_dev allocation" from Sep 15, 2005, leads to the
> following static checker warning:
> 
> 	drivers/input/joystick/turbografx.c:235 tgfx_probe()
> 	error: buffer overflow 'tgfx_buttons' 5 <= 5
> 
> drivers/input/joystick/turbografx.c
>    195          for (i = 0; i < n_devs; i++) {
>    196                  if (n_buttons[i] < 1)
>    197                          continue;
>    198  
>    199                  if (n_buttons[i] > 6) {
>                             ^^^^^^^^^^^^^^^^
> Possibly off by one.  >= 6.

How about this:

Input: turbografx - fix potential out of bound access

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Patch 17dd3f0f7aa7: "[PATCH] drivers/input/joystick: convert to dynamic
input_dev allocation" from Sep 15, 2005, leads to the following static
checker warning:

        drivers/input/joystick/turbografx.c:235 tgfx_probe()
        error: buffer overflow 'tgfx_buttons' 5 <= 5

drivers/input/joystick/turbografx.c
   195          for (i = 0; i < n_devs; i++) {
   196                  if (n_buttons[i] < 1)
   197                          continue;
   198
   199                  if (n_buttons[i] > 6) {
                            ^^^^^^^^^^^^^^^^
Possibly off by one.  >= 6.

Let's change the upper value to ARRAY_SIZE(tgfx_buttons) to ensure we do
not reach past the end of the array.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/turbografx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/joystick/turbografx.c b/drivers/input/joystick/turbografx.c
index 27b6a3c..891797a 100644
--- a/drivers/input/joystick/turbografx.c
+++ b/drivers/input/joystick/turbografx.c
@@ -196,7 +196,7 @@ static struct tgfx __init *tgfx_probe(int parport, int *n_buttons, int n_devs)
 		if (n_buttons[i] < 1)
 			continue;
 
-		if (n_buttons[i] > 6) {
+		if (n_buttons[i] > ARRAY_SIZE(tgfx_buttons)) {
 			printk(KERN_ERR "turbografx.c: Invalid number of buttons %d\n", n_buttons[i]);
 			err = -EINVAL;
 			goto err_unreg_devs;

Thanks.

-- 
Dmitry
