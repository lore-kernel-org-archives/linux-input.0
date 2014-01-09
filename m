From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH v2] input: synaptics-rmi4 - use snprintf instead of sprintf
 in rmi_i2c.c
Date: Thu, 9 Jan 2014 12:29:46 -0800
Message-ID: <52CF06BA.5040000@synaptics.com>
References: <1389230319-4737-1-git-send-email-cheiny@synaptics.com> <20140109080454.GA27160@core.coreip.homeip.net> <20140109082858.GE27160@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:52645 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751AbaAIU3r (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jan 2014 15:29:47 -0500
In-Reply-To: <20140109082858.GE27160@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On 01/09/2014 12:28 AM, Dmitry Torokhov wrote:
> On Thu, Jan 09, 2014 at 12:04:54AM -0800, Dmitry Torokhov wrote:
>> On Wed, Jan 08, 2014 at 05:18:39PM -0800, Christopher Heiny wrote:
>>> This is a trivial change to replace the sprintf loop with snprintf using
>>> up-to-date format capability.
>>
>> Hmm, how about we do this instead:
>
> And another small one...
>
> Input: synaptics-rmi4 - transport name should be a const pointer
>
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Looks good to me.  I think the correct protocol is to Ack the patch, so...

Acked-by: Christopher Heiny <cheiny@synaptics.com>


> ---
>   drivers/input/rmi4/rmi_bus.h |    2 +-
>   drivers/input/rmi4/rmi_i2c.c |    4 +---
>   2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/input/rmi4/rmi_bus.h b/drivers/input/rmi4/rmi_bus.h
> index 65dd934..3e8b57a 100644
> --- a/drivers/input/rmi4/rmi_bus.h
> +++ b/drivers/input/rmi4/rmi_bus.h
> @@ -148,7 +148,7 @@ struct rmi_driver {
>    * @att_count Number of times ATTN assertions have been handled.
>    */
>   struct rmi_transport_info {
> -	char *proto;
> +	const char *proto;
>   	long tx_count;
>   	long tx_bytes;
>   	long tx_errs;
> diff --git a/drivers/input/rmi4/rmi_i2c.c b/drivers/input/rmi4/rmi_i2c.c
> index ea01823..ebe74ec 100644
> --- a/drivers/input/rmi4/rmi_i2c.c
> +++ b/drivers/input/rmi4/rmi_i2c.c
> @@ -38,8 +38,6 @@ struct rmi_i2c_data {
>   #define RMI_PAGE_SELECT_REGISTER 0xff
>   #define RMI_I2C_PAGE(addr) (((addr) >> 8) & 0xff)
>
> -static char *xport_proto_name = "i2c";
> -
>   /*
>    * rmi_set_page - Set RMI page
>    * @xport: The pointer to the rmi_transport_dev struct
> @@ -217,7 +215,7 @@ static int rmi_i2c_probe(struct i2c_client *client,
>
>   	xport->write_block = rmi_i2c_write_block;
>   	xport->read_block = rmi_i2c_read_block;
> -	xport->info.proto = xport_proto_name;
> +	xport->info.proto = "i2c";
>
>   	mutex_init(&data->page_mutex);
>
>


-- 

Christopher Heiny
Senior Staff Firmware Engineer
Synaptics Incorporated
