From: "jeffrey.lin" <yajohn@gmail.com>
Subject: Re: [PATCH] driver: input :touchscreen : add Raydium I2C touch driver
Date: Mon, 16 May 2016 23:57:28 +0800
Message-ID: <1463414248-422-1-git-send-email-jeffrey.lin@rad-ic.com>
References: <20160513041852.GA8932@dtor-ws>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160513041852.GA8932@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, rydberg@euromail.se, grant.likely@linaro.org, robh+dt@kernel.org, jeesw@melfas.com, bleung@chromium.org
Cc: jeffrey.lin@rad-ic.com, roger.yang@rad-ic.com, KP.li@rad-ic.com, albert.shieh@rad-ic.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

>static int raydium_i2c_do_update_firmware(struct raydium_data *ts,
>					 const struct firmware *fw)
>{
>	struct i2c_client *client = ts->client;
>	const void *data;
>	size_t data_len;
>	size_t len;
>	int page_nr;
>	int i;
>	int error;
>	u16 fw_checksum;
>
>	if (fw->size == 0) {
additional protect.
	if (fw->size == 0 || fw->size > RM_MAX_FW_SIZE) {
>		dev_err(&client->dev, "Invalid firmware length\n");
>		return -EINVAL;
>	}
>
>	error = raydium_i2c_check_fw_status(ts);
>	if (error) {
>		dev_err(&client->dev, "Unable to access IC %d\n", error);
>		return error;
>	}
>
>	if (ts->boot_mode == RAYDIUM_TS_MAIN) {
>		for (i = 0; i < RM_MAX_RETRIES; i++) {
>			error = raydium_i2c_enter_bl(client);
>			if (!error) {
>				error = raydium_i2c_check_fw_status(ts);
>				if (error) {
>					dev_err(&client->dev,
>						"unable to access IC: %d\n",
>						error);
>					return error;
>				}
>
>				if (ts->boot_mode == RAYDIUM_TS_BLDR)
>					break;
>			}
>		}
>
>		if (ts->boot_mode == RAYDIUM_TS_MAIN) {
>			dev_err(&client->dev,
>				"failied to jump to boot loader: %d\n",
>				error);
>			return -EIO;
>		}
>	}
>
>	error = raydium_i2c_disable_watch_dog(client);
>	if (error)
>		return error;
>
>	error = raydium_i2c_check_path(client);
>	if (error)
>		return error;
>
>	error = raydium_i2c_boot_trigger(client);
>	if (error) {
>		dev_err(&client->dev, "send boot trigger fail: %d\n", error);
>		return error;
>	}
additonal delay for safe
	msleep(RM_BOOT_DELAY_MS);
>
>	data = fw->data;
>	data_len = fw->size;
>	page_nr = 0;
>
>	while (data_len) {
>		len = min_t(size_t, data_len, RM_FW_PAGE_SIZE);
>
>		error = raydium_i2c_fw_write_page(client, page_nr++, data, len);
>		if (error)
>			return error;
>
>		// XXX FIXME: we already sleep in raydium_i2c_fw_write_page(),
>		// do we really need to sleep here as well?
		/*FIXME, remove delay in raydium_i2c_fw_write_page()*/
>		msleep(20);
>
>		data += len;
>		data_len -= len;
>	}
