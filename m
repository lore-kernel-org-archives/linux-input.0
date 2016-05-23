From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] driver: input :touchscreen : add Raydium I2C touch driver
Date: Mon, 23 May 2016 09:27:37 -0700
Message-ID: <20160523162737.GA20465@dtor-ws>
References: <20160513041852.GA8932@dtor-ws>
 <1464014633-20829-1-git-send-email-jeffrey.lin@rad-ic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1464014633-20829-1-git-send-email-jeffrey.lin-s3Ivl27awEzQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "jeffrey.lin" <yajohn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: rydberg-Hk7bIW8heu4wFerOooGFRg@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jeesw-iQTvn4YitUrQT0dZR+AlfA@public.gmane.org, bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, jeffrey.lin-s3Ivl27awEzQT0dZR+AlfA@public.gmane.org, roger.yang-s3Ivl27awEzQT0dZR+AlfA@public.gmane.org, KP.li-s3Ivl27awEzQT0dZR+AlfA@public.gmane.org, albert.shieh-s3Ivl27awEzQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Jeffrey,

On Mon, May 23, 2016 at 10:43:53PM +0800, jeffrey.lin wrote:
> Hi Dmitry:
> 
> >static int raydium_i2c_read_message(struct i2c_client *client,
> >				    u32 addr, void *data, size_t len)
> >{
> >	__le32 le_addr;
> >	size_t xfer_len;
> >	u32 shift_addr;
> >	int error;
> >
> >	while (len) {
> >		xfer_len = min_t(size_t, len, RM_MAX_READ_SIZE);
> >
> >		le_addr = cpu_to_le32(addr);
> >
> >		shift_addr = le_addr >> 8;/*send the first 3rd byte addr.*/
> Drop this. Change touch MCU setting to solve this issue
> >		error = raydium_i2c_send(client, RM_CMD_BANK_SWITCH,
> >					 &shift_addr, sizeof(le_addr));
> >		if (!error)/*read from last byte addr.*/
> >			error = raydium_i2c_read(client, le_addr & 0xff,
> >						 data, xfer_len);
> >		if (error)
> >			return error;
> >
> >		len -= xfer_len;
> >		data += xfer_len;
> >		addr += xfer_len;
> >	}
> >
> >	return 0;
> >}
> modify as below.
> 
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
> 						 data, xfer_len);

No, not "le_addr & 0xff", "addr & 0xff"! When you do calculations, you
have to do it using values in CPU endianness, not fixed endianness (BE
or LE) so that the code will work on all architectures.

> 		if (error)
> 			return error;
> 
> 		len -= xfer_len;
> 		data += xfer_len;
> 		addr += xfer_len;
> 	}
> 
> 	return 0;
> }
> 
> >
> >>> static int raydium_i2c_fw_write_page(struct i2c_client *client,
> >>> 				     u16 page_idx, const void *data, size_t len)
> >>> {
> >>> 	u8 buf[RM_BL_WRT_LEN];
> >>> 	u8 pkg_idx = 1;
> >>> 	size_t xfer_len;
> >>> 	int error;
> >>> 
> >>> 	while (len) {
> >>> 		xfer_len = min_t(size_t, len, RM_BL_WRT_PKG_SIZE);
> >>> 		buf[BL_HEADER] = RM_CMD_BOOT_PAGE_WRT;
> >>> 		/*FIXME,Touch MCU need zero index as start page*/
> >>> 		buf[BL_PAGE_STR] = page_idx ? 0xff : 0;
> >>> 		buf[BL_PKG_IDX] = pkg_idx++;
> >>> 
> >>> 		memcpy(&buf[BL_DATA_STR], data, xfer_len);
> >>> 
> >>> 		if (len < RM_BL_WRT_PKG_SIZE) {
> >>> 			buf[BL_PKG_IDX] = 4;
> Drop this one. Modfy boot loader firmware to meet this issue. So final function as below.
> static int raydium_i2c_fw_write_page(struct i2c_client *client,
> 				     u16 page_idx, const void *data, size_t len)
> {
> 	u8 buf[RM_BL_WRT_LEN];
> 	u8 pkg_idx = 1;
> 	size_t xfer_len;
> 	int error;
> 
> 	while (len) {
> 		xfer_len = min_t(size_t, len, RM_BL_WRT_PKG_SIZE);
> 		buf[BL_HEADER] = RM_CMD_BOOT_PAGE_WRT;
> 		/*FIXME,Touch MCU need zero index as start page*/
> 		buf[BL_PAGE_STR] = page_idx ? 0xff : 0;
> 		buf[BL_PKG_IDX] = pkg_idx++;
> 
> 		memcpy(&buf[BL_DATA_STR], data, xfer_len);
> 
> 		if (len < RM_BL_WRT_PKG_SIZE) {
> 			memset(buf + BL_DATA_STR + xfer_len, 0xff,
> 				RM_BL_WRT_PKG_SIZE - xfer_len);
> 		}
> 
> 		error = raydium_i2c_write_object(client, buf, RM_BL_WRT_LEN,
> 						 RAYDIUM_WAIT_READY);
> 		if (error) {
> 			dev_err(&client->dev,
> 				"page write command failed for page %d, chunk %d: %d\n",
> 				page_idx, pkg_idx, error);
> 			return error;
> 		}
> 		data += xfer_len;
> 		len -= xfer_len;
> 	}
> 
> 	return error;
> }

What will be the trigger for the flash? If you really need full page,
then you want to :

	BUILD_BUG_ON((RM_FW_PAGE_SIZE % RM_BL_WRT_PKG_SIZE) != 0);

	for (i = 0; i < RM_FW_PAGE_SIZE / RM_BL_WRT_PKG_SIZE; i++) {
		buf[BL_HEADER] = RM_CMD_BOOT_PAGE_WRT;
		buf[BL_PAGE_STR] = i ? 0xff : 0;
		buf[BL_PKG_IDX] = i;

		xfer_len = min_t(size_t, len, RM_BL_WRT_PKG_SIZE);
		memcpy(&buf[BL_DATA_STR], data, xfer_len);
		if (len < RM_BL_WRT_PKG_SIZE)
			memset(&buf[BL_DATA_STR + xfer_len], 0xff,
				RM_BL_WRT_PKG_SIZE - xfer_len);

		error = raydium_i2c_write_object(client, buf, RM_BL_WRT_LEN,
						 RAYDIUM_WAIT_READY);
		if (error) {
			dev_err(&client->dev,
				"page write command failed for page %d, chunk %d: %d\n",
				page_idx, pkg_idx, error);
			return error;
		}

		data += xfer_len;
		len -= xfer_len;
	}

The BUILD_BUG_ON is because I do not want to handle the case where last
chunk would cross over the page boundary so we'd have to cut it short.
It simply is not worth it.

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
