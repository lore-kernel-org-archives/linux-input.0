From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH 06/11] Input: synaptics-rmi4 - Add rmi_find_function()
Date: Fri, 26 Aug 2016 18:35:29 -0700
Message-ID: <d8a6254e-6065-26fc-7e30-a4064e7d8bec@synaptics.com>
References: <1471512289-10648-1-git-send-email-benjamin.tissoires@redhat.com>
 <1471512289-10648-7-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx1.synaptics.com ([192.147.44.131]:28402 "EHLO
        us-mx1.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752303AbcH0Bgw (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 26 Aug 2016 21:36:52 -0400
In-Reply-To: <1471512289-10648-7-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lyude Paul <thatslyude@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Resending as plain text

On 08/18/2016 02:24 AM, Benjamin Tissoires wrote:
> If a function needs to communicate with an other, it's better to have
> a way to retrieve this other.
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Reviewed-by: Andrew Duggan <aduggan@synaptics.com>

> ---
>  drivers/input/rmi4/rmi_driver.c | 13 +++++++++++++
>  drivers/input/rmi4/rmi_driver.h |  1 +
>  2 files changed, 14 insertions(+)
>
> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> index faa295e..304f142 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -181,6 +181,19 @@ int rmi_process_interrupt_requests(struct rmi_device *rmi_dev)
>  }
>  EXPORT_SYMBOL_GPL(rmi_process_interrupt_requests);
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
> index a7cb383..e4be773 100644
> --- a/drivers/input/rmi4/rmi_driver.h
> +++ b/drivers/input/rmi4/rmi_driver.h
> @@ -95,6 +95,7 @@ bool rmi_register_desc_has_subpacket(const struct rmi_register_desc_item *item,
>  bool rmi_is_physical_driver(struct device_driver *);
>  int rmi_register_physical_driver(void);
>  void rmi_unregister_physical_driver(void);
> +struct rmi_function *rmi_find_function(struct rmi_device *rmi_dev, u8 number);
>
>  char *rmi_f01_get_product_ID(struct rmi_function *fn);
>
>

