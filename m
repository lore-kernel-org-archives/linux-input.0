From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3] Input: synaptics-rmi4 - enable IRQ operation in F34
 V7
Date: Sat, 15 Apr 2017 10:51:07 -0700
Message-ID: <20170415175107.GB33447@dtor-ws>
References: <1490403540-31425-1-git-send-email-nick@shmanahar.org>
 <1490403540-31425-4-git-send-email-nick@shmanahar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35774 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754683AbdDORvL (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 15 Apr 2017 13:51:11 -0400
Received: by mail-pf0-f194.google.com with SMTP id a188so19073278pfa.2
        for <linux-input@vger.kernel.org>; Sat, 15 Apr 2017 10:51:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1490403540-31425-4-git-send-email-nick@shmanahar.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick@shmanahar.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, linux-input@vger.kernel.org, Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>

On Sat, Mar 25, 2017 at 12:59:00AM +0000, Nick Dyer wrote:
> The polled firmware update proved unreliable when testing on S7817. Use
> attention to signal commands are complete.
> 
> Signed-off-by: Nick Dyer <nick@shmanahar.org>
> ---
>  drivers/input/rmi4/rmi_f34.c   |  27 +++++++---
>  drivers/input/rmi4/rmi_f34.h   |   7 +--
>  drivers/input/rmi4/rmi_f34v7.c | 114 ++++++++++++++++++++++-------------------
>  3 files changed, 81 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_f34.c b/drivers/input/rmi4/rmi_f34.c
> index 425fe14..a37efca 100644
> --- a/drivers/input/rmi4/rmi_f34.c
> +++ b/drivers/input/rmi4/rmi_f34.c
> @@ -105,16 +105,27 @@ static int rmi_f34_attention(struct rmi_function *fn, unsigned long *irq_bits)
>  {
>  	struct f34_data *f34 = dev_get_drvdata(&fn->dev);
>  	int ret;
> +	u8 status;
>  
> -	if (f34->bl_version != 5)
> -		return 0;
> +	if (f34->bl_version == 5) {
> +		ret = rmi_read(f34->fn->rmi_dev, f34->v5.ctrl_address,
> +			       &status);
> +		rmi_dbg(RMI_DEBUG_FN, &fn->dev, "%s: status: %#02x, ret: %d\n",
> +			__func__, status, ret);
>  
> -	ret = rmi_read(f34->fn->rmi_dev, f34->v5.ctrl_address, &f34->v5.status);
> -	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "%s: status: %#02x, ret: %d\n",
> -		__func__, f34->v5.status, ret);
> -
> -	if (!ret && !(f34->v5.status & 0x7f))
> -		complete(&f34->v5.cmd_done);
> +		if (!ret && !(status & 0x7f))
> +			complete(&f34->v5.cmd_done);
> +	} else {
> +		ret = rmi_read_block(f34->fn->rmi_dev,
> +                        f34->fn->fd.data_base_addr + f34->v7.off.flash_status,
> +                        &status,
> +                        sizeof(status));
> +		rmi_dbg(RMI_DEBUG_FN, &fn->dev, "%s: status: %#02x, ret: %d\n",
> +			__func__, status, ret);
> +
> +		if (!ret && !(status & 0x1f))
> +			complete(&f34->v7.cmd_done);
> +	}
>  
>  	return 0;
>  }
> diff --git a/drivers/input/rmi4/rmi_f34.h b/drivers/input/rmi4/rmi_f34.h
> index 43a9134..32c4e95 100644
> --- a/drivers/input/rmi4/rmi_f34.h
> +++ b/drivers/input/rmi4/rmi_f34.h
> @@ -30,6 +30,7 @@
>  #define F34_IDLE_WAIT_MS	500
>  #define F34_ENABLE_WAIT_MS	300
>  #define F34_ERASE_WAIT_MS	5000
> +#define F34_WRITE_WAIT_MS	3000
>  
>  #define F34_BOOTLOADER_ID_LEN	2
>  
> @@ -47,11 +48,6 @@
>  #define CONFIG_ID_SIZE			32
>  #define PRODUCT_ID_SIZE			10
>  
> -#define ENABLE_WAIT_MS			(1 * 1000)
> -#define WRITE_WAIT_MS			(3 * 1000)
> -
> -#define MIN_SLEEP_TIME_US		50
> -#define MAX_SLEEP_TIME_US		100
>  
>  #define HAS_BSR				BIT(5)
>  #define HAS_CONFIG_ID			BIT(3)
> @@ -292,6 +288,7 @@ struct f34v7_data {
>  
>  	const void *config_data;
>  	const void *image;
> +	struct completion cmd_done;
>  };
>  
>  struct f34_data {
> diff --git a/drivers/input/rmi4/rmi_f34v7.c b/drivers/input/rmi4/rmi_f34v7.c
> index 56c6c39..e6b4a8c 100644
> --- a/drivers/input/rmi4/rmi_f34v7.c
> +++ b/drivers/input/rmi4/rmi_f34v7.c
> @@ -15,6 +15,7 @@
>  #include <asm/unaligned.h>
>  #include <linux/delay.h>
>  #include <linux/slab.h>
> +#include <linux/jiffies.h>
>  
>  #include "rmi_driver.h"
>  #include "rmi_f34.h"
> @@ -31,7 +32,7 @@ static int rmi_f34v7_read_flash_status(struct f34_data *f34)
>  			sizeof(status));
>  	if (ret < 0) {
>  		rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev,
> -			"%s: Failed to read flash status\n", __func__);
> +			"%s: Error %d reading flash status\n", __func__, ret);
>  		return ret;
>  	}
>  
> @@ -60,28 +61,17 @@ static int rmi_f34v7_read_flash_status(struct f34_data *f34)
>  
>  static int rmi_f34v7_wait_for_idle(struct f34_data *f34, int timeout_ms)
>  {
> -	int count = 0;
> -	int timeout_count = ((timeout_ms * 1000) / MAX_SLEEP_TIME_US) + 1;
> +	unsigned long timeout;
>  
> -	do {
> -		usleep_range(MIN_SLEEP_TIME_US, MAX_SLEEP_TIME_US);
> -
> -		count++;
> -
> -		rmi_f34v7_read_flash_status(f34);
> -
> -		if ((f34->v7.command == v7_CMD_IDLE)
> -		    && (f34->v7.flash_status == 0x00)) {
> -			rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev,
> -				"Idle status detected\n");
> -			return 0;
> -		}
> -	} while (count < timeout_count);
> +	timeout = msecs_to_jiffies(timeout_ms);
>  
> -	dev_err(&f34->fn->dev,
> -		"%s: Timed out waiting for idle status\n", __func__);
> +	if (!wait_for_completion_timeout(&f34->v7.cmd_done, timeout)) {
> +		dev_warn(&f34->fn->dev, "%s: Timed out waiting for idle status\n",
> +			 __func__);
> +		return -ETIMEDOUT;
> +	}
>  
> -	return -ETIMEDOUT;
> +	return 0;
>  }
>  
>  static int rmi_f34v7_write_command_single_transaction(struct f34_data *f34,
> @@ -285,9 +275,10 @@ static int rmi_f34v7_write_partition_id(struct f34_data *f34, u8 cmd)
>  	return 0;
>  }
>  
> -static int rmi_f34v7_read_f34v7_partition_table(struct f34_data *f34)
> +static int rmi_f34v7_read_partition_table(struct f34_data *f34)
>  {
>  	int ret;
> +	unsigned long timeout;
>  	u8 base;
>  	__le16 length;
>  	u16 block_number = 0;
> @@ -320,6 +311,8 @@ static int rmi_f34v7_read_f34v7_partition_table(struct f34_data *f34)
>  		return ret;
>  	}
>  
> +	init_completion(&f34->v7.cmd_done);
> +
>  	ret = rmi_f34v7_write_command(f34, v7_CMD_READ_CONFIG);
>  	if (ret < 0) {
>  		dev_err(&f34->fn->dev, "%s: Failed to write command\n",
> @@ -327,11 +320,14 @@ static int rmi_f34v7_read_f34v7_partition_table(struct f34_data *f34)
>  		return ret;
>  	}
>  
> -	ret = rmi_f34v7_wait_for_idle(f34, WRITE_WAIT_MS);
> -	if (ret < 0) {
> -		dev_err(&f34->fn->dev, "%s: Failed to wait for idle status\n",
> -			__func__);
> -		return ret;
> +	timeout = msecs_to_jiffies(F34_WRITE_WAIT_MS);
> +	while (time_before(jiffies, timeout)) {
> +		msleep(5);

Changed this for "usleep_range(5000, 6000)".

> +		rmi_f34v7_read_flash_status(f34);
> +
> +		if ((f34->v7.command == v7_CMD_IDLE)
> +		   && (f34->v7.flash_status == 0x00))
> +			break;
>  	}
>  
>  	ret = rmi_read_block(f34->fn->rmi_dev,
> @@ -570,7 +566,7 @@ static int rmi_f34v7_read_queries(struct f34_data *f34)
>  	f34->v7.read_config_buf_size = f34->v7.partition_table_bytes;
>  	ptable = f34->v7.read_config_buf;
>  
> -	ret = rmi_f34v7_read_f34v7_partition_table(f34);
> +	ret = rmi_f34v7_read_partition_table(f34);
>  	if (ret < 0) {
>  		dev_err(&f34->fn->dev, "%s: Failed to read partition table\n",
>  				__func__);
> @@ -666,6 +662,8 @@ static int rmi_f34v7_erase_config(struct f34_data *f34)
>  
>  	dev_info(&f34->fn->dev, "Erasing config...\n");
>  
> +	init_completion(&f34->v7.cmd_done);
> +
>  	switch (f34->v7.config_area) {
>  	case v7_UI_CONFIG_AREA:
>  		ret = rmi_f34v7_write_command(f34, v7_CMD_ERASE_UI_CONFIG);
> @@ -684,11 +682,11 @@ static int rmi_f34v7_erase_config(struct f34_data *f34)
>  		break;
>  	}
>  
> -	ret = rmi_f34v7_wait_for_idle(f34, ENABLE_WAIT_MS);
> +	ret = rmi_f34v7_wait_for_idle(f34, F34_ERASE_WAIT_MS);
>  	if (ret < 0)
>  		return ret;
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static int rmi_f34v7_erase_guest_code(struct f34_data *f34)
> @@ -697,11 +695,13 @@ static int rmi_f34v7_erase_guest_code(struct f34_data *f34)
>  
>  	dev_info(&f34->fn->dev, "Erasing guest code...\n");
>  
> +	init_completion(&f34->v7.cmd_done);
> +
>  	ret = rmi_f34v7_write_command(f34, v7_CMD_ERASE_GUEST_CODE);
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = rmi_f34v7_wait_for_idle(f34, ENABLE_WAIT_MS);
> +	ret = rmi_f34v7_wait_for_idle(f34, F34_ERASE_WAIT_MS);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -714,11 +714,13 @@ static int rmi_f34v7_erase_all(struct f34_data *f34)
>  
>  	dev_info(&f34->fn->dev, "Erasing firmware...\n");
>  
> +	init_completion(&f34->v7.cmd_done);
> +
>  	ret = rmi_f34v7_write_command(f34, v7_CMD_ERASE_UI_FIRMWARE);
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = rmi_f34v7_wait_for_idle(f34, ENABLE_WAIT_MS);
> +	ret = rmi_f34v7_wait_for_idle(f34, F34_ERASE_WAIT_MS);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -743,7 +745,7 @@ static int rmi_f34v7_erase_all(struct f34_data *f34)
>  	return 0;
>  }
>  
> -static int rmi_f34v7_read_f34v7_blocks(struct f34_data *f34, u16 block_cnt,
> +static int rmi_f34v7_read_blocks(struct f34_data *f34, u16 block_cnt,
>  				       u8 command)
>  {
>  	int ret;
> @@ -787,17 +789,15 @@ static int rmi_f34v7_read_f34v7_blocks(struct f34_data *f34, u16 block_cnt,
>  			return ret;
>  		}
>  
> +		init_completion(&f34->v7.cmd_done);
> +
>  		ret = rmi_f34v7_write_command(f34, command);
>  		if (ret < 0)
>  			return ret;
>  
> -		ret = rmi_f34v7_wait_for_idle(f34, ENABLE_WAIT_MS);
> -		if (ret < 0) {
> -			dev_err(&f34->fn->dev,
> -				"%s: Wait for idle failed (%d blks remaining)\n",
> -				__func__, remaining);
> +		ret = rmi_f34v7_wait_for_idle(f34, F34_ENABLE_WAIT_MS);
> +		if (ret < 0)
>  			return ret;
> -		}
>  
>  		ret = rmi_read_block(f34->fn->rmi_dev,
>  				base + f34->v7.off.payload,
> @@ -853,6 +853,8 @@ static int rmi_f34v7_write_f34v7_blocks(struct f34_data *f34,
>  		transfer = min(remaining, max_transfer);
>  		put_unaligned_le16(transfer, &length);
>  
> +		init_completion(&f34->v7.cmd_done);
> +
>  		ret = rmi_write_block(f34->fn->rmi_dev,
>  				base + f34->v7.off.transfer_length,
>  				&length, sizeof(length));
> @@ -877,13 +879,9 @@ static int rmi_f34v7_write_f34v7_blocks(struct f34_data *f34,
>  			return ret;
>  		}
>  
> -		ret = rmi_f34v7_wait_for_idle(f34, ENABLE_WAIT_MS);
> -		if (ret < 0) {
> -			dev_err(&f34->fn->dev,
> -				"%s: Failed wait for idle (%d blks remaining)\n",
> -				__func__, remaining);
> +		ret = rmi_f34v7_wait_for_idle(f34, F34_ENABLE_WAIT_MS);
> +		if (ret < 0)
>  			return ret;
> -		}
>  
>  		block_ptr += (transfer * f34->v7.block_size);
>  		remaining -= transfer;
> @@ -945,6 +943,8 @@ static int rmi_f34v7_write_flash_config(struct f34_data *f34)
>  		return -EINVAL;
>  	}
>  
> +	init_completion(&f34->v7.cmd_done);
> +
>  	ret = rmi_f34v7_write_command(f34, v7_CMD_ERASE_FLASH_CONFIG);
>  	if (ret < 0)
>  		return ret;
> @@ -952,7 +952,7 @@ static int rmi_f34v7_write_flash_config(struct f34_data *f34)
>  	rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev,
>  		"%s: Erase flash config command written\n", __func__);
>  
> -	ret = rmi_f34v7_wait_for_idle(f34, ENABLE_WAIT_MS);
> +	ret = rmi_f34v7_wait_for_idle(f34, F34_WRITE_WAIT_MS);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -981,7 +981,7 @@ static int rmi_f34v7_write_partition_table(struct f34_data *f34)
>  
>  	f34->v7.read_config_buf_size = f34->v7.config_size;
>  
> -	ret = rmi_f34v7_read_f34v7_blocks(f34, block_count, v7_CMD_READ_CONFIG);
> +	ret = rmi_f34v7_read_blocks(f34, block_count, v7_CMD_READ_CONFIG);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -1287,6 +1287,8 @@ static int rmi_f34v7_enter_flash_prog(struct f34_data *f34)
>  {
>  	int ret;
>  
> +	f34->fn->rmi_dev->driver->set_irq_bits(f34->fn->rmi_dev, f34->fn->irq_mask);
> +
>  	ret = rmi_f34v7_read_flash_status(f34);
>  	if (ret < 0)
>  		return ret;
> @@ -1294,19 +1296,16 @@ static int rmi_f34v7_enter_flash_prog(struct f34_data *f34)
>  	if (f34->v7.in_bl_mode)
>  		return 0;
>  
> +	init_completion(&f34->v7.cmd_done);
> +
>  	ret = rmi_f34v7_write_command(f34, v7_CMD_ENABLE_FLASH_PROG);
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = rmi_f34v7_wait_for_idle(f34, ENABLE_WAIT_MS);
> +	ret = rmi_f34v7_wait_for_idle(f34, F34_ENABLE_WAIT_MS);
>  	if (ret < 0)
>  		return ret;
>  
> -	if (!f34->v7.in_bl_mode) {
> -		dev_err(&f34->fn->dev, "%s: BL mode not entered\n", __func__);
> -		return -EINVAL;
> -	}
> -
>  	return 0;
>  }
>  
> @@ -1314,6 +1313,8 @@ int rmi_f34v7_start_reflash(struct f34_data *f34, const struct firmware *fw)
>  {
>  	int ret = 0;
>  
> +	f34->fn->rmi_dev->driver->set_irq_bits(f34->fn->rmi_dev, f34->fn->irq_mask);
> +
>  	f34->v7.config_area = v7_UI_CONFIG_AREA;
>  	f34->v7.image = fw->data;
>  
> @@ -1376,8 +1377,13 @@ int rmi_f34v7_probe(struct f34_data *f34)
>  
>  	memset(&f34->v7.blkcount, 0x00, sizeof(f34->v7.blkcount));
>  	memset(&f34->v7.phyaddr, 0x00, sizeof(f34->v7.phyaddr));
> -	rmi_f34v7_read_queries(f34);
>  
> -	f34->v7.force_update = false;
> +	init_completion(&f34->v7.cmd_done);
> +
> +	ret = rmi_f34v7_read_queries(f34);
> +	if (ret < 0)
> +		return ret;
> +
> +	f34->v7.force_update = true;
>  	return 0;
>  }
> -- 
> 2.7.4
> 

-- 
Dmitry
