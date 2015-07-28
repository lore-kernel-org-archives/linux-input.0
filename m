From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: [PATCH] drivers/input/joystick: convert to dynamic input_dev
 allocation
Date: Tue, 28 Jul 2015 20:00:24 +0300
Message-ID: <20150728170024.GD21317@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:29120 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752461AbbG1RAu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Jul 2015 13:00:50 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hello Dmitry Torokhov,

The patch 17dd3f0f7aa7: "[PATCH] drivers/input/joystick: convert to
dynamic input_dev allocation" from Sep 15, 2005, leads to the
following static checker warning:

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


   200                          printk(KERN_ERR "turbografx.c: Invalid number of buttons %d\n", n_buttons[i]);
   201                          err = -EINVAL;
   202                          goto err_unreg_devs;
   203                  }
   204  
   205                  tgfx->dev[i] = input_dev = input_allocate_device();
   206                  if (!input_dev) {
   207                          printk(KERN_ERR "turbografx.c: Not enough memory for input device\n");
   208                          err = -ENOMEM;
   209                          goto err_unreg_devs;
   210                  }
   211  
   212                  tgfx->sticks |= (1 << i);
   213                  snprintf(tgfx->name[i], sizeof(tgfx->name[i]),
   214                           "TurboGraFX %d-button Multisystem joystick", n_buttons[i]);
   215                  snprintf(tgfx->phys[i], sizeof(tgfx->phys[i]),
   216                           "%s/input%d", tgfx->pd->port->name, i);
   217  
   218                  input_dev->name = tgfx->name[i];
   219                  input_dev->phys = tgfx->phys[i];
   220                  input_dev->id.bustype = BUS_PARPORT;
   221                  input_dev->id.vendor = 0x0003;
   222                  input_dev->id.product = n_buttons[i];
   223                  input_dev->id.version = 0x0100;
   224  
   225                  input_set_drvdata(input_dev, tgfx);
   226  
   227                  input_dev->open = tgfx_open;
   228                  input_dev->close = tgfx_close;
   229  
   230                  input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
   231                  input_set_abs_params(input_dev, ABS_X, -1, 1, 0, 0);
   232                  input_set_abs_params(input_dev, ABS_Y, -1, 1, 0, 0);
   233  
   234                  for (j = 0; j < n_buttons[i]; j++)
   235                          set_bit(tgfx_buttons[j], input_dev->keybit);
                                        ^^^^^^^^^^^^^^^
Leading to an off by one write here.  This only has 5 elements.

   236 

regards,
dan carpenter
