From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] driver: input :touchscreen : add Raydium I2C touch driver
Date: Sat, 21 May 2016 11:18:15 -0700
Message-ID: <20160521181815.GA26789@dtor-ws>
References: <20160513041852.GA8932@dtor-ws>
 <1463501223-20723-1-git-send-email-jeffrey.lin@rad-ic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1463501223-20723-1-git-send-email-jeffrey.lin-s3Ivl27awEzQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "jeffrey.lin" <yajohn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: rydberg-Hk7bIW8heu4wFerOooGFRg@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jeesw-iQTvn4YitUrQT0dZR+AlfA@public.gmane.org, bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, jeffrey.lin-s3Ivl27awEzQT0dZR+AlfA@public.gmane.org, roger.yang-s3Ivl27awEzQT0dZR+AlfA@public.gmane.org, KP.li-s3Ivl27awEzQT0dZR+AlfA@public.gmane.org, albert.shieh-s3Ivl27awEzQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, May 18, 2016 at 12:07:02AM +0800, jeffrey.lin wrote:
> Hi Dmitry:
> > >static int raydium_i2c_read_message(struct i2c_client *client,
> > >				    u32 addr, void *data, size_t len)
> > >{
> > >	__be32 be_addr;
> > >	size_t xfer_len;
> > >	int error;
> > >	while (len) {
> > >		xfer_len = min_t(size_t, len, RM_MAX_READ_SIZE);
> > >
> > >		be_addr = cpu_to_be32(addr);
> > >
> > >		error = raydium_i2c_send(client, RM_CMD_BANK_SWITCH,
> > >					 &be_addr, sizeof(be_addr));
> > >		if (!error)
> > >			error = raydium_i2c_read(client, addr & 0xff,
> > >						 data, xfer_len);
> > Change as:
> > 		if (!error)
> > 			error = raydium_i2c_read(client, (be_addr >> 24) & 0xff,
> > 						 data, xfer_len);
> 
> >I think it is the same on LE, and I suspect it will not work correctly
> >on BE... You want to have the 8 least significant bits of the bank to be
> >used as the address, right?

> This function work correctly with the kernel 3.18 of chromebook in my
> hand. Raydium touch direct access mode can recieve the BE address

That is because it is a little-endian device.

>
> after bank switch command 0xaa. For example, if we'll read 10 bytes
> data begin on 0x12345678. We need send the command sequences as 0xaa->
> 0x12->0x34->0x56-> 0x78 and then recive 10 bytes from 0x78.
> 

Right. So the thing is - on any architecture, be it little- or
big-endian, expression "value & 0xff" will extract the 8 least
significant bits from the value, while "(value >> 24) & 0xff" will
extract the most significant bits (assuming that the value is 32 bits). So with your example if you do
cpu_to_be32() on LE architecture it will actually reshuffle the bytes so
that former LSB will become MSB and then you will extract that MSB and
use it. On BE arches cpu_to_be32() is a noop, so addr and be_addr will
have the same value, and your expression will produce 0x12 and not 0x78
as you expect. On the other hand, doing "addr & 0xff" will produce 0x78
regardless of endianness.

> > static int raydium_i2c_fw_write_page(struct i2c_client *client,
> > 				     u16 page_idx, const void *data, size_t len)
> > {
> > 	u8 buf[RM_BL_WRT_LEN];
> > 	u8 pkg_idx = 1;
> > 	u8 div_cnt;
> > 	size_t xfer_len;
> > 	int error;
> > 	int i;
> > 
> > 	div_cnt = len % RM_BL_WRT_PKG_SIZE ?
> > 		len / RM_BL_WRT_PKG_SIZE + 1:len / RM_BL_WRT_PKG_SIZE;
> >
> >Drop this. BTW, if you ever need it we have DIV_ROUND_UP macro.
> 
> > 
> > 	for (i = 0; i < div_cnt; i++) {
> >
> >	while (len) {
> >
> > 		xfer_len = min_t(size_t, len, RM_BL_WRT_PKG_SIZE);
> > 		buf[BL_HEADER] = RM_CMD_BOOT_PAGE_WRT;
> > 		/*FIXME,Touch MCU need zero index as start page*/
> > 		buf[BL_PAGE_STR] = page_idx ? 0xff : 0;
> > 		buf[BL_PKG_IDX] = pkg_idx++;
> > 
> > 		memcpy(&buf[BL_DATA_STR], data, xfer_len);
> >
> >		/* we need to pad to full page size */
> >		if (len < RM_BL_WRT_PKG_SIZE)
> >			memset(&buf[BL_DATA_STR] + len, 0xff,
> >				RM_BL_WRT_PKG_SIZE - len);
> > 
> > 		if (len == 0)
> > 			memset(buf + BL_DATA_STR, 0xff, RM_BL_WRT_PKG_SIZE);
> > 		else if (len < RM_BL_WRT_PKG_SIZE)
> > 			memset(buf + BL_DATA_STR + xfer_len, 0xff,
> > 			RM_BL_WRT_PKG_SIZE - xfer_len);
> > 
> > 		error = raydium_i2c_write_object(client, buf, RM_BL_WRT_LEN,
> > 						 RAYDIUM_WAIT_READY);
> > 		if (error) {
> > 			dev_err(&client->dev,
> > 				"page write command failed for page %d, chunk %d: %d\n",
> > 				page_idx, pkg_idx, error);
> > 			return error;
> > 		}
> > 		data += RM_BL_WRT_PKG_SIZE;
> > 		len -= RM_BL_WRT_PKG_SIZE;
> > 	}
> > 
> > 	return error;
> > }
> Modify as below.
> 
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
> 			buf[BL_PKG_IDX] = 4;

Why 4???

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
> > 
> > >static void raydium_mt_event(struct raydium_data *ts)
> > >{
> > >	int i;
> > >	int error;
> > memory allocate
> > 	ts->report_data = kmalloc(ts->report_size, GFP_KERNEL);
> > 	if (!ts->report_data)
> > 		return;
> >
> >I thought I was allocating it after I queried the touchscreen
> >parameters... If not it was oversight. I do not think we should be
> >doing this on every interrupt, so please do the allocation in ->probe()
> >code.
> Move memory allocate to raydium_i2c_probe(). 

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
