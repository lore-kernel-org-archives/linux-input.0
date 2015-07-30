From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: drivers/joystick: use parallel port device model
Date: Thu, 30 Jul 2015 09:53:23 -0700
Message-ID: <20150730165323.GC13165@dtor-ws>
References: <1438265194-20366-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36612 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999AbbG3Qx2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Jul 2015 12:53:28 -0400
Content-Disposition: inline
In-Reply-To: <1438265194-20366-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Sudip,

On Thu, Jul 30, 2015 at 07:36:34PM +0530, Sudip Mukherjee wrote:
> Modify db9 driver to use the new Parallel Port device model.
> 
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---
> 
> It will generate a checkpatch warning about long line but I have not
> changed it as it was only 2 char more and for 2 char it is more readable
> now.

You can also write it as

	if (!have_dev)
		return -ENODEV;

	return parport_register_driver(...);


Could you please tell me how you tested this change? With these devices
becoming exceedingly rare just compile-tested changes may introduce
regressions that are not easily noticed.

> 
>  drivers/input/joystick/db9.c | 114 ++++++++++++++++++++++---------------------
>  1 file changed, 59 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/input/joystick/db9.c b/drivers/input/joystick/db9.c
> index 8e7de5c..a69ab29 100644
> --- a/drivers/input/joystick/db9.c
> +++ b/drivers/input/joystick/db9.c
> @@ -48,7 +48,7 @@ struct db9_config {
>  };
>  
>  #define DB9_MAX_PORTS		3
> -static struct db9_config db9_cfg[DB9_MAX_PORTS] __initdata;
> +static struct db9_config db9_cfg[DB9_MAX_PORTS];
>  
>  module_param_array_named(dev, db9_cfg[0].args, int, &db9_cfg[0].nargs, 0);
>  MODULE_PARM_DESC(dev, "Describes first attached device (<parport#>,<type>)");
> @@ -106,6 +106,7 @@ struct db9 {
>  	struct pardevice *pd;
>  	int mode;
>  	int used;
> +	int parportno;
>  	struct mutex mutex;
>  	char phys[DB9_MAX_DEVICES][32];
>  };
> @@ -553,54 +554,65 @@ static void db9_close(struct input_dev *dev)
>  	mutex_unlock(&db9->mutex);
>  }
>  
> -static struct db9 __init *db9_probe(int parport, int mode)
> +static void db9_attach(struct parport *pp)
>  {
>  	struct db9 *db9;
>  	const struct db9_mode_data *db9_mode;
> -	struct parport *pp;
>  	struct pardevice *pd;
>  	struct input_dev *input_dev;
>  	int i, j;
> -	int err;
> +	int mode;
> +	struct pardev_cb db9_parport_cb;
> +
> +	for (i = 0; i < DB9_MAX_PORTS; i++) {
> +		if (db9_cfg[i].nargs == 0 ||
> +		    db9_cfg[i].args[DB9_ARG_PARPORT] < 0)
> +			continue;
> +
> +		if (db9_cfg[i].nargs < 2) {
> +			pr_warn("db9.c: Device type must be specified.\n");
> +			return;
> +		}
> +
> +		if (db9_cfg[i].args[DB9_ARG_PARPORT] == pp->number)
> +			break;
> +	}
> +
> +	if (i == DB9_MAX_PORTS) {
> +		pr_debug("Not using parport%d.\n", pp->number);
> +		return;
> +	}

Why do we validate module options in attach() instead of how we did this
in module init function? By doing this here we losing the ability to
abort module loading when parameters are invalid.

> +
> +	mode = db9_cfg[i].args[DB9_ARG_MODE];
>  
>  	if (mode < 1 || mode >= DB9_MAX_PAD || !db9_modes[mode].n_buttons) {
>  		printk(KERN_ERR "db9.c: Bad device type %d\n", mode);
> -		err = -EINVAL;
> -		goto err_out;
> +		return;
>  	}
>  
>  	db9_mode = &db9_modes[mode];
>  
> -	pp = parport_find_number(parport);
> -	if (!pp) {
> -		printk(KERN_ERR "db9.c: no such parport\n");
> -		err = -ENODEV;
> -		goto err_out;
> -	}
> -
>  	if (db9_mode->bidirectional && !(pp->modes & PARPORT_MODE_TRISTATE)) {
>  		printk(KERN_ERR "db9.c: specified parport is not bidirectional\n");
> -		err = -EINVAL;
> -		goto err_put_pp;
> +		return;
>  	}
>  
> -	pd = parport_register_device(pp, "db9", NULL, NULL, NULL, PARPORT_DEV_EXCL, NULL);
> +	db9_parport_cb.flags = PARPORT_FLAG_EXCL;
> +
> +	pd = parport_register_dev_model(pp, "db9", &db9_parport_cb, i);
>  	if (!pd) {
>  		printk(KERN_ERR "db9.c: parport busy already - lp.o loaded?\n");
> -		err = -EBUSY;
> -		goto err_put_pp;
> +		return;
>  	}
>  
>  	db9 = kzalloc(sizeof(struct db9), GFP_KERNEL);
> -	if (!db9) {
> -		printk(KERN_ERR "db9.c: Not enough memory\n");
> -		err = -ENOMEM;
> +	if (!db9)
>  		goto err_unreg_pardev;
> -	}
>  
>  	mutex_init(&db9->mutex);
>  	db9->pd = pd;
>  	db9->mode = mode;
> +	db9->parportno = pp->number;
>  	init_timer(&db9->timer);
>  	db9->timer.data = (long) db9;
>  	db9->timer.function = db9_timer;
> @@ -610,7 +622,6 @@ static struct db9 __init *db9_probe(int parport, int mode)
>  		db9->dev[i] = input_dev = input_allocate_device();
>  		if (!input_dev) {
>  			printk(KERN_ERR "db9.c: Not enough memory for input device\n");
> -			err = -ENOMEM;
>  			goto err_unreg_devs;
>  		}
>  
> @@ -639,13 +650,12 @@ static struct db9 __init *db9_probe(int parport, int mode)
>  				input_set_abs_params(input_dev, db9_abs[j], 1, 255, 0, 0);
>  		}
>  
> -		err = input_register_device(input_dev);
> -		if (err)
> +		if (input_register_device(input_dev))
>  			goto err_free_dev;
>  	}
>  
> -	parport_put_port(pp);
> -	return db9;
> +	db9_base[i] = db9;

Instead of using static array maybe store db9 in pardevice's private
pointer? Given that we are using parport exclusively on detach we can
just get the first pardevice and get db9 from it.

> +	return;
>  
>   err_free_dev:
>  	input_free_device(db9->dev[i]);
> @@ -655,15 +665,22 @@ static struct db9 __init *db9_probe(int parport, int mode)
>  	kfree(db9);
>   err_unreg_pardev:
>  	parport_unregister_device(pd);
> - err_put_pp:
> -	parport_put_port(pp);
> - err_out:
> -	return ERR_PTR(err);
>  }
>  
> -static void db9_remove(struct db9 *db9)
> +static void db9_detach(struct parport *port)
>  {
>  	int i;
> +	struct db9 *db9;
> +
> +	for (i = 0; i < DB9_MAX_PORTS; i++) {
> +		if (db9_base[i] && db9_base[i]->parportno == port->number)
> +			break;
> +	}
> +
> +	if (i == DB9_MAX_PORTS)
> +		return;
> +
> +	db9 = db9_base[i];
>  
>  	for (i = 0; i < min(db9_modes[db9->mode].n_pads, DB9_MAX_DEVICES); i++)
>  		input_unregister_device(db9->dev[i]);
> @@ -671,11 +688,17 @@ static void db9_remove(struct db9 *db9)
>  	kfree(db9);
>  }
>  
> +static struct parport_driver db9_parport_driver = {
> +	.name = "db9",
> +	.match_port = db9_attach,
> +	.detach = db9_detach,
> +	.devmodel = true,
> +};
> +
>  static int __init db9_init(void)
>  {
>  	int i;
>  	int have_dev = 0;
> -	int err = 0;
>  
>  	for (i = 0; i < DB9_MAX_PORTS; i++) {
>  		if (db9_cfg[i].nargs == 0 || db9_cfg[i].args[DB9_ARG_PARPORT] < 0)
> @@ -683,37 +706,18 @@ static int __init db9_init(void)
>  
>  		if (db9_cfg[i].nargs < 2) {
>  			printk(KERN_ERR "db9.c: Device type must be specified.\n");
> -			err = -EINVAL;
> -			break;
> -		}
> -
> -		db9_base[i] = db9_probe(db9_cfg[i].args[DB9_ARG_PARPORT],
> -					db9_cfg[i].args[DB9_ARG_MODE]);
> -		if (IS_ERR(db9_base[i])) {
> -			err = PTR_ERR(db9_base[i]);
> -			break;
> +			return -EINVAL;
>  		}
>  
>  		have_dev = 1;
>  	}
>  
> -	if (err) {
> -		while (--i >= 0)
> -			if (db9_base[i])
> -				db9_remove(db9_base[i]);
> -		return err;
> -	}
> -
> -	return have_dev ? 0 : -ENODEV;
> +	return have_dev ? parport_register_driver(&db9_parport_driver) : -ENODEV;
>  }
>  
>  static void __exit db9_exit(void)
>  {
> -	int i;
> -
> -	for (i = 0; i < DB9_MAX_PORTS; i++)
> -		if (db9_base[i])
> -			db9_remove(db9_base[i]);
> +	parport_unregister_driver(&db9_parport_driver);
>  }
>  
>  module_init(db9_init);
> -- 
> 1.9.1
> 

Thanks.

-- 
Dmitry
