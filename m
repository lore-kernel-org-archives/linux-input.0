From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH v2] input: synaptics-rmi4 - use snprintf instead of sprintf
 in rmi_i2c.c
Date: Thu, 9 Jan 2014 13:23:37 -0800
Message-ID: <52CF1359.6080207@synaptics.com>
References: <1389230319-4737-1-git-send-email-cheiny@synaptics.com> <20140109080454.GA27160@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:52201 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757537AbaAIVXj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jan 2014 16:23:39 -0500
In-Reply-To: <20140109080454.GA27160@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On 01/09/2014 12:04 AM, Dmitry Torokhov wrote:
> On Wed, Jan 08, 2014 at 05:18:39PM -0800, Christopher Heiny wrote:
>> This is a trivial change to replace the sprintf loop with snprintf using
>> up-to-date format capability.
>
> Hmm, how about we do this instead:
>
> Input: synaptics-rmi4 - clean up debug handling in rmi_i2c
>
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> Kernel now has standard facility to format and print binary buffers, let's
> use it. By doing so we no longer need to allocate memory for debug buffers
> and we can let debugfs code go as well.

Not sure where to put this comment, so I'll drop it here.

I agree the buffers can go.  I realized that on the drive home last 
night, but was too tired to follow up.

Talking with some of the folks who use this feature, there's a desire to 
keep some sort of finer control on whether the comms buffers are printed 
or not - either the existing debugfs setup (preferred, since it lets 
them turn on the dmesg clutter only when needed), or by converting to a 
config option such as CONFIG_RMI4_COMMS_DEBUG.  It's very useful in new 
platform development, since there's a surprising number of ways in which 
the reads and writes can go wonky on new hardware.

> We have a new limitation however - output is limited to the first 64 bytes
> of the buffer. However if we really need to capture larger messages dumping
> them in dmesg is not right interface anyway.
>
> Also clean up extra includes, while we are at it.

That's good, too.


> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>   drivers/input/rmi4/rmi_i2c.c |  131 +++++-------------------------------------
>   1 file changed, 15 insertions(+), 116 deletions(-)
>
> diff --git a/drivers/input/rmi4/rmi_i2c.c b/drivers/input/rmi4/rmi_i2c.c
> index b33074c..c2ad1aa 100644
> --- a/drivers/input/rmi4/rmi_i2c.c
> +++ b/drivers/input/rmi4/rmi_i2c.c
> @@ -8,16 +8,10 @@
>    */
>
>   #include <linux/kernel.h>
> -#include <linux/delay.h>
>   #include <linux/i2c.h>
> -#include <linux/interrupt.h>
> -#include <linux/kconfig.h>
> -#include <linux/lockdep.h>
>   #include <linux/module.h>
> -#include <linux/pm.h>
>   #include <linux/rmi.h>
>   #include <linux/slab.h>
> -#include <linux/uaccess.h>
>   #include "rmi_driver.h"
>
>   #define BUFFER_SIZE_INCREMENT 32
> @@ -31,11 +25,6 @@
>    *
>    * @tx_buf: Buffer used for transmitting data to the sensor over i2c.
>    * @tx_buf_size: Size of the buffer
> - * @debug_buf: Buffer used for exposing buffer contents using dev_dbg
> - * @debug_buf_size: Size of the debug buffer.
> - *
> - * @comms_debug: Latest data read/written for debugging I2C communications
> - * @debugfs_comms: Debugfs file for debugging I2C communications
>    */
>   struct rmi_i2c_data {
>   	struct mutex page_mutex;
> @@ -44,56 +33,8 @@ struct rmi_i2c_data {
>
>   	u8 *tx_buf;
>   	int tx_buf_size;
> -	u8 *debug_buf;
> -	int debug_buf_size;
> -
> -	u32 comms_debug;
> -#ifdef CONFIG_RMI4_DEBUG
> -	struct dentry *debugfs_comms;
> -#endif
>   };
>
> -#ifdef CONFIG_RMI4_DEBUG
> -
> -static int setup_debugfs(struct rmi_device *rmi_dev, struct rmi_i2c_data *data)
> -{
> -	if (!rmi_dev->debugfs_root)
> -		return -ENODEV;
> -
> -	data->debugfs_comms = debugfs_create_bool("comms_debug",
> -			(S_IRUGO | S_IWUGO), rmi_dev->debugfs_root,
> -			&data->comms_debug);
> -	if (!data->debugfs_comms || IS_ERR(data->debugfs_comms)) {
> -		dev_warn(&rmi_dev->dev,
> -			 "Failed to create debugfs comms_debug.\n");
> -		data->debugfs_comms = NULL;
> -	}
> -
> -	return 0;
> -}
> -
> -static void teardown_debugfs(struct rmi_i2c_data *data)
> -{
> -	if (data->debugfs_comms)
> -		debugfs_remove(data->debugfs_comms);
> -}
> -
> -#else
> -
> -static inline int setup_debugfs(struct rmi_device *rmi_dev,
> -				struct rmi_i2c_data *data)
> -{
> -	return 0;
> -}
> -
> -static inline void teardown_debugfs(struct rmi_i2c_data *data)
> -{
> -}
> -
> -#endif
> -
> -#define COMMS_DEBUG(data) (IS_ENABLED(CONFIG_RMI4_DEBUG) && data->comms_debug)
> -
>   #define RMI_PAGE_SELECT_REGISTER 0xff
>   #define RMI_I2C_PAGE(addr) (((addr) >> 8) & 0xff)
>
> @@ -120,8 +61,7 @@ static int rmi_set_page(struct rmi_transport_dev *xport, u8 page)
>   	u8 txbuf[2] = {RMI_PAGE_SELECT_REGISTER, page};
>   	int retval;
>
> -	if (COMMS_DEBUG(data))
> -		dev_dbg(&client->dev, "writes 3 bytes: %02x %02x\n",
> +	dev_dbg(&client->dev, "writes 3 bytes: %02x %02x\n",
>   			txbuf[0], txbuf[1]);
>   	xport->info.tx_count++;
>   	xport->info.tx_bytes += sizeof(txbuf);
> @@ -136,34 +76,6 @@ static int rmi_set_page(struct rmi_transport_dev *xport, u8 page)
>   	return 0;
>   }
>
> -static int copy_to_debug_buf(struct device *dev, struct rmi_i2c_data *data,
> -			     const u8 *buf, const int len) {
> -	int i;
> -	int n = 0;
> -	char *temp;
> -	int dbg_size = 3 * len + 1;
> -
> -	if (!data->debug_buf || data->debug_buf_size < dbg_size) {
> -		if (data->debug_buf)
> -			devm_kfree(dev, data->debug_buf);
> -		data->debug_buf_size = dbg_size + BUFFER_SIZE_INCREMENT;
> -		data->debug_buf = devm_kzalloc(dev, data->debug_buf_size,
> -					       GFP_KERNEL);
> -		if (!data->debug_buf) {
> -			data->debug_buf_size = 0;
> -			return -ENOMEM;
> -		}
> -	}
> -	temp = data->debug_buf;
> -
> -	for (i = 0; i < len; i++) {
> -		n = sprintf(temp, " %02x", buf[i]);
> -		temp += n;
> -	}
> -
> -	return 0;
> -}
> -
>   static int rmi_i2c_write_block(struct rmi_transport_dev *xport, u16 addr,
>   			       const void *buf, const int len)
>   {
> @@ -195,12 +107,8 @@ static int rmi_i2c_write_block(struct rmi_transport_dev *xport, u16 addr,
>   			goto exit;
>   	}
>
> -	if (COMMS_DEBUG(data)) {
> -		int rc = copy_to_debug_buf(&client->dev, data, (u8 *) buf, len);
> -		if (!rc)
> -			dev_dbg(&client->dev, "writes %d bytes at %#06x:%s\n",
> -				len, addr, data->debug_buf);
> -	}
> +	dev_dbg(&client->dev,
> +		"writes %d bytes at %#06x: %*ph\n", len, addr, len, buf);
>
>   	xport->info.tx_count++;
>   	xport->info.tx_bytes += tx_size;
> @@ -232,8 +140,7 @@ static int rmi_i2c_read_block(struct rmi_transport_dev *xport, u16 addr,
>   			goto exit;
>   	}
>
> -	if (COMMS_DEBUG(data))
> -		dev_dbg(&client->dev, "writes 1 bytes: %02x\n", txbuf[0]);
> +	dev_dbg(&client->dev, "writes 1 bytes: %02x\n", txbuf[0]);
>
>   	xport->info.tx_count++;
>   	xport->info.tx_bytes += sizeof(txbuf);
> @@ -244,18 +151,16 @@ static int rmi_i2c_read_block(struct rmi_transport_dev *xport, u16 addr,
>   		goto exit;
>   	}
>
> -	retval = i2c_master_recv(client, (u8 *) buf, len);
> +	retval = i2c_master_recv(client, buf, len);
>
>   	xport->info.rx_count++;
>   	xport->info.rx_bytes += len;
>   	if (retval < 0)
>   		xport->info.rx_errs++;
> -	else if (COMMS_DEBUG(data)) {
> -		int rc = copy_to_debug_buf(&client->dev, data, (u8 *) buf, len);
> -		if (!rc)
> -			dev_dbg(&client->dev, "read %d bytes at %#06x:%s\n",
> -				len, addr, data->debug_buf);
> -	}
> +	else
> +		dev_dbg(&client->dev,
> +			"read %d bytes at %#06x: %*ph\n",
> +			len, addr, len, buf);
>
>   exit:
>   	mutex_unlock(&data->page_mutex);
> @@ -265,9 +170,9 @@ exit:
>   static int rmi_i2c_probe(struct i2c_client *client,
>   			 const struct i2c_device_id *id)
>   {
> +	const struct rmi_device_platform_data *pdata = dev_get_platdata(&client->dev);
>   	struct rmi_transport_dev *xport;
>   	struct rmi_i2c_data *data;
> -	struct rmi_device_platform_data *pdata = client->dev.platform_data;
>   	int retval;
>
>   	if (!pdata) {
> @@ -318,7 +223,8 @@ static int rmi_i2c_probe(struct i2c_client *client,
>
>   	mutex_init(&data->page_mutex);
>
> -	/* Setting the page to zero will (a) make sure the PSR is in a
> +	/*
> +	 * Setting the page to zero will (a) make sure the PSR is in a
>   	 * known state, and (b) make sure we can talk to the device.
>   	 */
>   	retval = rmi_set_page(xport, 0);
> @@ -335,11 +241,6 @@ static int rmi_i2c_probe(struct i2c_client *client,
>   	}
>   	i2c_set_clientdata(client, xport);
>
> -	retval = setup_debugfs(xport->rmi_dev, data);
> -	if (retval < 0)
> -		dev_warn(&client->dev, "Failed to setup debugfs. Code: %d.\n",
> -			 retval);
> -
>   	dev_info(&client->dev, "registered rmi i2c driver at %#04x.\n",
>   			client->addr);
>   	return 0;
> @@ -353,14 +254,12 @@ err_gpio:
>   static int rmi_i2c_remove(struct i2c_client *client)
>   {
>   	struct rmi_transport_dev *xport = i2c_get_clientdata(client);
> -	struct rmi_device_platform_data *pd = client->dev.platform_data;
> -
> -	teardown_debugfs(xport->data);
> +	struct rmi_device_platform_data *pdata = dev_get_platdata(&client->dev);
>
>   	rmi_unregister_transport_device(xport);
>
> -	if (pd->gpio_config)
> -		pd->gpio_config(&pd->gpio_data, false);
> +	if (pdata->gpio_config)
> +		pdata->gpio_config(&pdata->gpio_data, false);
>
>   	return 0;
>   }
>


-- 

Christopher Heiny
Senior Staff Firmware Engineer
Synaptics Incorporated
