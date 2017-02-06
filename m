From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 02/10] Input: synaptics-rmi4 - Add rmi_find_function()
Date: Mon, 6 Feb 2017 11:28:12 -0800
Message-ID: <20170206192812.GC17441@dtor-ws>
References: <20170110161128.7441-1-benjamin.tissoires@redhat.com>
 <20170110161128.7441-3-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35691 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751517AbdBFT2P (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 6 Feb 2017 14:28:15 -0500
Content-Disposition: inline
In-Reply-To: <20170110161128.7441-3-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: KT Liao <kt.liao@emc.com.tw>, Andrew Duggan <aduggan@synaptics.com>, Adrian Alves <aalves@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Tue, Jan 10, 2017 at 05:11:20PM +0100, Benjamin Tissoires wrote:
> If a function needs to communicate with an other, it's better to have
> a way to retrieve this other.
> 
> Reviewed-by: Andrew Duggan <aduggan@synaptics.com>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied, thank you.

> ---
>  drivers/input/rmi4/rmi_driver.c | 13 +++++++++++++
>  drivers/input/rmi4/rmi_driver.h |  1 +
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> index 11447ab..87dbb0c 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -265,6 +265,19 @@ static int rmi_irq_init(struct rmi_device *rmi_dev)
>  	return 0;
>  }
>  
> +struct rmi_function *rmi_find_function(struct rmi_device *rmi_dev, u8 number)
> +{
> +	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
> +	struct rmi_function *entry;
> +
> +	list_for_each_entry(entry, &data->function_list, node) {
> +		if (entry->fd.function_number == number)
> +			return entry;
> +	}
> +
> +	return NULL;
> +}
> +
>  static int suspend_one_function(struct rmi_function *fn)
>  {
>  	struct rmi_function_handler *fh;
> diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
> index 24f8f76..0506371 100644
> --- a/drivers/input/rmi4/rmi_driver.h
> +++ b/drivers/input/rmi4/rmi_driver.h
> @@ -93,6 +93,7 @@ bool rmi_is_physical_driver(struct device_driver *);
>  int rmi_register_physical_driver(void);
>  void rmi_unregister_physical_driver(void);
>  void rmi_free_function_list(struct rmi_device *rmi_dev);
> +struct rmi_function *rmi_find_function(struct rmi_device *rmi_dev, u8 number);
>  int rmi_enable_sensor(struct rmi_device *rmi_dev);
>  int rmi_scan_pdt(struct rmi_device *rmi_dev, void *ctx,
>  		 int (*callback)(struct rmi_device *rmi_dev, void *ctx,
> -- 
> 2.9.3
> 

-- 
Dmitry
