From: Courtney Cavin <courtney.cavin@sonymobile.com>
Subject: Re: [PATCH 04/05] input synaptics-rmi4: rmi_driver - Export some
 symbols and functions for use by reflash.
Date: Mon, 10 Mar 2014 08:04:48 -0700
Message-ID: <20140310150448.GD18578@sonymobile.com>
References: <1394245795-17347-1-git-send-email-cheiny@synaptics.com>
 <1394245795-17347-4-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([212.209.106.2]:18179 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753425AbaCJPC4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Mar 2014 11:02:56 -0400
Content-Disposition: inline
In-Reply-To: <1394245795-17347-4-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

On Sat, Mar 08, 2014 at 03:29:54AM +0100, Christopher Heiny wrote:
> Reflash functionality will need to unload the existing functions and
> rescan the PDT before starting reflash; then reload the functions
> afterwards.
> 
> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
> Signed-off-by: Vincent Huang <vincent.huang@tw.synaptics.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: Linux Walleij <linus.walleij@linaro.org>
> Cc: David Herrmann <dh.herrmann@gmail.com>
> Cc: Jiri Kosina <jkosina@suse.cz>
> 
> ---
> 
>  drivers/input/rmi4/rmi_driver.c | 165 ++++++++++++++++++++++------------------
>  drivers/input/rmi4/rmi_driver.h |  22 +++---
>  2 files changed, 101 insertions(+), 86 deletions(-)
[...]
> diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
[...]
> -int rmi_read_pdt_entry(struct rmi_device *rmi_dev, struct pdt_entry *entry,
> -			u16 pdt_address);
> +#define RMI_SCAN_CONTINUE	0
> +#define RMI_SCAN_DONE		1
> +
> +int rmi_scan_pdt(struct rmi_device *rmi_dev, void *ctx,
> +		 int (*callback)(struct rmi_device *rmi_dev,
> +				 void *ctx, const struct pdt_entry *entry));

I don't really like this callback.  The main reason for it is early
abort of PDT scanning, right?  It is really that beneficial?
>  
>  bool rmi_is_physical_driver(struct device_driver *);
>  int rmi_register_physical_driver(void);
> @@ -113,4 +109,10 @@ void rmi_unregister_physical_driver(void);
>  int rmi_register_f01_handler(void);
>  void rmi_unregister_f01_handler(void);
>  
> +int check_bootloader_mode(struct rmi_device *rmi_dev,
> +			  const struct pdt_entry *pdt);

This is a silly function name to put in a header. rmi_* perhaps?

> +void rmi_free_function_list(struct rmi_device *rmi_dev);
> +int rmi_driver_detect_functions(struct rmi_device *rmi_dev);
> +
> +
>  #endif

-Courtney
