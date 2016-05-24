From: "jeffrey.lin" <yajohn@gmail.com>
Subject: Re: [PATCH] driver: input :touchscreen : add Raydium I2C touch driver
Date: Tue, 24 May 2016 17:31:41 +0800
Message-ID: <1464082301-11539-1-git-send-email-jeffrey.lin@rad-ic.com>
References: <20160513041852.GA8932@dtor-ws>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160513041852.GA8932@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, rydberg@euromail.se, grant.likely@linaro.org, robh+dt@kernel.org, jeesw@melfas.com, bleung@chromium.org
Cc: jeffrey.lin@rad-ic.com, roger.yang@rad-ic.com, KP.li@rad-ic.com, albert.shieh@rad-ic.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry:
>
>	BUILD_BUG_ON((RM_FW_PAGE_SIZE % RM_BL_WRT_PKG_SIZE) != 0);
>
>	for (i = 0; i < RM_FW_PAGE_SIZE / RM_BL_WRT_PKG_SIZE; i++) {
>		buf[BL_HEADER] = RM_CMD_BOOT_PAGE_WRT;
>		buf[BL_PAGE_STR] = i ? 0xff : 0;
Change to buf[BL_PAGE_STR] = page_idx ? 0xff : 0;
>		buf[BL_PKG_IDX] = i;
>
>		xfer_len = min_t(size_t, len, RM_BL_WRT_PKG_SIZE);
>		memcpy(&buf[BL_DATA_STR], data, xfer_len);
>		if (len < RM_BL_WRT_PKG_SIZE)
>			memset(&buf[BL_DATA_STR + xfer_len], 0xff,
>				RM_BL_WRT_PKG_SIZE - xfer_len);
>
>		error = raydium_i2c_write_object(client, buf, RM_BL_WRT_LEN,
>						 RAYDIUM_WAIT_READY);
>		if (error) {
>			dev_err(&client->dev,
>				"page write command failed for page %d, chunk %d: %d\n",
>				page_idx, pkg_idx, error);
>			return error;
>		}
>
>		data += xfer_len;
>		len -= xfer_len;
>	}
This work on my hand chromebook.

> static int raydium_i2c_read_message(struct i2c_client *client,
> 				    u32 addr, void *data, size_t len)
> {
> 	__le32 le_addr;
> 	size_t xfer_len;
> 	int error;
> 
> 	while (len) {
> 		xfer_len = min_t(size_t, len, RM_MAX_READ_SIZE);
> 
> 		le_addr = cpu_to_le32(addr);
> 
> 		error = raydium_i2c_send(client, RM_CMD_BANK_SWITCH,
> 					 &le_addr, sizeof(le_addr));
> 		if (!error)/*read from last byte addr.*/
> 			error = raydium_i2c_read(client, le_addr & 0xff,
> 						 data, xfer_len)
Change as
			error = raydium_i2c_read(client, addr & 0xff,
						 data, xfer_len);

I've fixed this issues and submit new patch to upstream. Please help check that.

Thanks.

Jeffrey
