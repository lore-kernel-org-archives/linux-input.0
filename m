From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH] input:Adding support for Wacom Stylus with I2c interface
Date: Tue, 4 Oct 2011 09:53:04 +0200
Message-ID: <201110040953.04734.oneukum@suse.de>
References: <1317714263-9851-1-git-send-email-tobita.tatsunosuke@wacom.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39601 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754184Ab1JDHw4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 4 Oct 2011 03:52:56 -0400
In-Reply-To: <1317714263-9851-1-git-send-email-tobita.tatsunosuke@wacom.co.jp>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tatsunosuke Tobita <junkpainting@gmail.com>
Cc: linux-input@vger.kernel.org, Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>

Am Dienstag, 4. Oktober 2011, 09:44:23 schrieb Tatsunosuke Tobita:

Hi,

> +static int wacom_i2c_probe(struct i2c_client *client,
> +                          const struct i2c_device_id *id)
> +{
> +       struct wacom_i2c *wac_i2c;
> +       int i, ret;
> +       i = ret = 0;
> +
> +       if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> +               goto err2;
> +
> +       wac_i2c = kzalloc(sizeof(struct wacom_i2c), GFP_KERNEL);
> +       wac_i2c->wac_feature = wacom_feature_EMR;

potentially following the NULL pointer

> +
> +       mutex_init(&wac_i2c->lock);
> +
> +       wac_i2c->dev = input_allocate_device();
> +       if (wac_i2c == NULL || wac_i2c->dev == NULL)
> +               goto fail;

You must test before you use

> +       wacom_i2c_set_input_values(client, wac_i2c, wac_i2c->dev);
> +
> +       wac_i2c->client = client;
> +
> +       INIT_WORK(&wac_i2c->workq, wacom_i2c_workqueue);
> +
> +       ret = wacom_send_query(wac_i2c);
> +       if (ret < 0)
> +               goto err1;
> +
> +       wac_i2c->dev->id.version = wac_i2c->wac_feature.fw_version;
> +       input_set_abs_params(wac_i2c->dev, ABS_X, 0,
> +                            wac_i2c->wac_feature.x_max, 0, 0);
> +       input_set_abs_params(wac_i2c->dev, ABS_Y, 0,
> +                            wac_i2c->wac_feature.y_max, 0, 0);
> +       input_set_abs_params(wac_i2c->dev, ABS_PRESSURE, 0,
> +                            wac_i2c->wac_feature.pressure_max, 0, 0);
> +       input_set_drvdata(wac_i2c->dev, wac_i2c);
> +
> +       i2c_set_clientdata(client, wac_i2c);
> +       if (input_register_device(wac_i2c->dev))
> +               goto err1;
> +
> +       hrtimer_init(&wac_i2c->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +       wac_i2c->timer.function = wacom_i2c_timer;
> +       hrtimer_start(&wac_i2c->timer, ktime_set(1, 0), HRTIMER_MODE_REL);

I think you want to initialize this before you register the input device to prevent
a race condition.

> +       printk(KERN_INFO "WACOM_I2C_DIGITIZER: initialized and started \n");
> +
> +       return 0;
> +
> + err2:
> +       printk(KERN_ERR "wacom_i2c:No I2C functionality found\n");
> +       return -ENODEV;
> +
> + err1:
> +       printk(KERN_ERR "wacom_i2c:err1 occured(num:%d)\n", ret);
> +       input_free_device(wac_i2c->dev);
> +       wac_i2c->dev = NULL;
> +       return -EIO;
> +
> + fail:
> +       printk(KERN_ERR "wacom_i2c:fail occured\n");
> +       return -ENOMEM;
> +}
> +

	Regards
		Oliver
