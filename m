From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: Input: elo - add support for non-pressure-sensitive touchscreens
Date: Mon, 23 May 2016 20:30:26 +0300
Message-ID: <20160523173026.GA24864@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:35120 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753066AbcEWRai (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 May 2016 13:30:38 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: sjackman@gmail.com
Cc: linux-input@vger.kernel.org

Hello Shaun Jackman,

The patch fae3006e4b42: "Input: elo - add support for
non-pressure-sensitive touchscreens" from Aug 5, 2006, leads to the
following static checker warning:

	drivers/input/touchscreen/elo.c:349 elo_connect()
	warn: missing error code here? 'elo_setup_10()' failed. 'err' = '0'

drivers/input/touchscreen/elo.c
   308  static int elo_connect(struct serio *serio, struct serio_driver *drv)
   309  {
   310          struct elo *elo;
   311          struct input_dev *input_dev;
   312          int err;
   313  
   314          elo = kzalloc(sizeof(struct elo), GFP_KERNEL);
   315          input_dev = input_allocate_device();
   316          if (!elo || !input_dev) {
   317                  err = -ENOMEM;
   318                  goto fail1;
   319          }
   320  
   321          elo->serio = serio;
   322          elo->id = serio->id.id;
   323          elo->dev = input_dev;
   324          elo->expected_packet = ELO10_TOUCH_PACKET;
   325          mutex_init(&elo->cmd_mutex);
   326          init_completion(&elo->cmd_done);
   327          snprintf(elo->phys, sizeof(elo->phys), "%s/input0", serio->phys);
   328  
   329          input_dev->name = "Elo Serial TouchScreen";
   330          input_dev->phys = elo->phys;
   331          input_dev->id.bustype = BUS_RS232;
   332          input_dev->id.vendor = SERIO_ELO;
   333          input_dev->id.product = elo->id;
   334          input_dev->id.version = 0x0100;
   335          input_dev->dev.parent = &serio->dev;
   336  
   337          input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
   338          input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
   339  
   340          serio_set_drvdata(serio, elo);
   341          err = serio_open(serio, drv);
   342          if (err)
   343                  goto fail2;
   344  
   345          switch (elo->id) {
   346  
   347          case 0: /* 10-byte protocol */
   348                  if (elo_setup_10(elo))
   349                          goto fail3;

This should return -1 (or -EPERM, I guess, if you want to avoid magic
numbers).

   350  
   351                  break;
   352  
   353          case 1: /* 6-byte protocol */
   354                  input_set_abs_params(input_dev, ABS_PRESSURE, 0, 15, 0, 0);
   355  
   356          case 2: /* 4-byte protocol */
   357                  input_set_abs_params(input_dev, ABS_X, 96, 4000, 0, 0);
   358                  input_set_abs_params(input_dev, ABS_Y, 96, 4000, 0, 0);
   359                  break;
   360  
   361          case 3: /* 3-byte protocol */
   362                  input_set_abs_params(input_dev, ABS_X, 0, 255, 0, 0);
   363                  input_set_abs_params(input_dev, ABS_Y, 0, 255, 0, 0);
   364                  break;
   365          }
   366  
   367          err = input_register_device(elo->dev);
   368          if (err)
   369                  goto fail3;
   370  
   371          return 0;
   372  
   373   fail3: serio_close(serio);
   374   fail2: serio_set_drvdata(serio, NULL);
   375   fail1: input_free_device(input_dev);
   376          kfree(elo);
   377          return err;
   378  }

regards,
dan carpenter
