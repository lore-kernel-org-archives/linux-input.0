From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: twl4030-vibra: Fix ERROR: Bad of_node_put()
 warning
Date: Thu, 23 Jul 2015 13:53:14 -0700
Message-ID: <20150723205314.GB12733@dtor-ws>
References: <1437683914-4660-1-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36059 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753765AbbGWUxT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jul 2015 16:53:19 -0400
Content-Disposition: inline
In-Reply-To: <1437683914-4660-1-git-send-email-marek@goldelico.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, hns@goldelico.com

On Thu, Jul 23, 2015 at 10:38:34PM +0200, Marek Belisko wrote:
> Fix following:
> [    8.862274] ERROR: Bad of_node_put() on /ocp/i2c@48070000/twl@48/audio
> [    8.869293] CPU: 0 PID: 1003 Comm: modprobe Not tainted 4.2.0-rc2-letux+ #1175
> [    8.876922] Hardware name: Generic OMAP36xx (Flattened Device Tree)
> [    8.883514] [<c00159e0>] (unwind_backtrace) from [<c0012488>] (show_stack+0x10/0x14)
> [    8.891693] [<c0012488>] (show_stack) from [<c05cb810>] (dump_stack+0x78/0x94)
> [    8.899322] [<c05cb810>] (dump_stack) from [<c02cfd5c>] (kobject_release+0x68/0x7c)
> [    8.907409] [<c02cfd5c>] (kobject_release) from [<bf0040c4>] (twl4030_vibra_probe+0x74/0x188 [twl4030_vibra])
> [    8.917877] [<bf0040c4>] (twl4030_vibra_probe [twl4030_vibra]) from [<c03816ac>] (platform_drv_probe+0x48/0x90)
> [    8.928497] [<c03816ac>] (platform_drv_probe) from [<c037feb4>] (really_probe+0xd4/0x238)
> [    8.937103] [<c037feb4>] (really_probe) from [<c0380160>] (driver_probe_device+0x30/0x48)
> [    8.945678] [<c0380160>] (driver_probe_device) from [<c03801e0>] (__driver_attach+0x68/0x8c)
> [    8.954589] [<c03801e0>] (__driver_attach) from [<c037ea60>] (bus_for_each_dev+0x50/0x84)
> [    8.963226] [<c037ea60>] (bus_for_each_dev) from [<c037f828>] (bus_add_driver+0xcc/0x1e4)
> [    8.971832] [<c037f828>] (bus_add_driver) from [<c0380b60>] (driver_register+0x9c/0xe0)
> [    8.980255] [<c0380b60>] (driver_register) from [<c00097e0>] (do_one_initcall+0x100/0x1b8)
> [    8.988983] [<c00097e0>] (do_one_initcall) from [<c00b8008>] (do_init_module+0x58/0x1c0)
> [    8.997497] [<c00b8008>] (do_init_module) from [<c00b8cac>] (SyS_init_module+0x54/0x64)
> [    9.005950] [<c00b8cac>] (SyS_init_module) from [<c000ed20>] (ret_fast_syscall+0x0/0x54)
> [    9.015838] input: twl4030:vibrator as /devices/platform/68000000.ocp/48070000.i2c/i2c-0/0-0048/48070000.i2c:twl@48:audio/input/input2
> 
> node passed to of_find_node_by_name is put inside that function and new node
> is returned if found. Free returned node not already freed node.

Hmm, if of_find_node_by_name() "puts" passed in node should we not "get"
it before calling of_find_node_by_name()? The node pointer in question
is simply copied from parent device.

Thanks.

> 
> Signed-off-by: Marek Belisko <marek@goldelico.com>
> ---
>  drivers/input/misc/twl4030-vibra.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/twl4030-vibra.c b/drivers/input/misc/twl4030-vibra.c
> index fc17b95..10c4e3d 100644
> --- a/drivers/input/misc/twl4030-vibra.c
> +++ b/drivers/input/misc/twl4030-vibra.c
> @@ -183,7 +183,8 @@ static bool twl4030_vibra_check_coexist(struct twl4030_vibra_data *pdata,
>  	if (pdata && pdata->coexist)
>  		return true;
>  
> -	if (of_find_node_by_name(node, "codec")) {
> +	node = of_find_node_by_name(node, "codec");
> +	if (node) {
>  		of_node_put(node);
>  		return true;
>  	}
> -- 
> 1.9.1
> 

-- 
Dmitry
