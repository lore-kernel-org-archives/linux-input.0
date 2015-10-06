From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/3] Input: db9 - store object at correct index
Date: Mon, 5 Oct 2015 17:32:05 -0700
Message-ID: <20151006003205.GA30418@dtor-ws>
References: <1443864298-20950-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:32850 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131AbbJFAcJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Oct 2015 20:32:09 -0400
Content-Disposition: inline
In-Reply-To: <1443864298-20950-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Sat, Oct 03, 2015 at 02:54:56PM +0530, Sudip Mukherjee wrote:
> The variable i is used to check the port to attach to and we are
> supposed to save the reference of struct db9 in the location given by
> db9_base[i]. But after finding out the index, i is getting modified again
> so we saved in a wrong index.
> While at it mark db9_base[i] as NULL after it is freed.
> 
> Fixes: 2260c419b52b ("Input: db9 - use parallel port device model")
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>

Applied the lot, thank you.

> ---
>  drivers/input/joystick/db9.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/input/joystick/db9.c b/drivers/input/joystick/db9.c
> index cf1f602..932d073 100644
> --- a/drivers/input/joystick/db9.c
> +++ b/drivers/input/joystick/db9.c
> @@ -560,25 +560,25 @@ static void db9_attach(struct parport *pp)
>  	const struct db9_mode_data *db9_mode;
>  	struct pardevice *pd;
>  	struct input_dev *input_dev;
> -	int i, j;
> +	int i, j, port_idx;
>  	int mode;
>  	struct pardev_cb db9_parport_cb;
>  
> -	for (i = 0; i < DB9_MAX_PORTS; i++) {
> -		if (db9_cfg[i].nargs == 0 ||
> -		    db9_cfg[i].args[DB9_ARG_PARPORT] < 0)
> +	for (port_idx = 0; port_idx < DB9_MAX_PORTS; port_idx++) {
> +		if (db9_cfg[port_idx].nargs == 0 ||
> +		    db9_cfg[port_idx].args[DB9_ARG_PARPORT] < 0)
>  			continue;
>  
> -		if (db9_cfg[i].args[DB9_ARG_PARPORT] == pp->number)
> +		if (db9_cfg[port_idx].args[DB9_ARG_PARPORT] == pp->number)
>  			break;
>  	}
>  
> -	if (i == DB9_MAX_PORTS) {
> +	if (port_idx == DB9_MAX_PORTS) {
>  		pr_debug("Not using parport%d.\n", pp->number);
>  		return;
>  	}
>  
> -	mode = db9_cfg[i].args[DB9_ARG_MODE];
> +	mode = db9_cfg[port_idx].args[DB9_ARG_MODE];
>  
>  	if (mode < 1 || mode >= DB9_MAX_PAD || !db9_modes[mode].n_buttons) {
>  		printk(KERN_ERR "db9.c: Bad device type %d\n", mode);
> @@ -594,7 +594,7 @@ static void db9_attach(struct parport *pp)
>  
>  	db9_parport_cb.flags = PARPORT_FLAG_EXCL;
>  
> -	pd = parport_register_dev_model(pp, "db9", &db9_parport_cb, i);
> +	pd = parport_register_dev_model(pp, "db9", &db9_parport_cb, port_idx);
>  	if (!pd) {
>  		printk(KERN_ERR "db9.c: parport busy already - lp.o loaded?\n");
>  		return;
> @@ -649,7 +649,7 @@ static void db9_attach(struct parport *pp)
>  			goto err_free_dev;
>  	}
>  
> -	db9_base[i] = db9;
> +	db9_base[port_idx] = db9;
>  	return;
>  
>   err_free_dev:
> @@ -676,6 +676,7 @@ static void db9_detach(struct parport *port)
>  		return;
>  
>  	db9 = db9_base[i];
> +	db9_base[i] = NULL;
>  
>  	for (i = 0; i < min(db9_modes[db9->mode].n_pads, DB9_MAX_DEVICES); i++)
>  		input_unregister_device(db9->dev[i]);
> -- 
> 1.9.1
> 

-- 
Dmitry
