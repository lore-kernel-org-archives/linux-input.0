From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 resend 0/1] Input: add support HiDeep touchscreen.
Date: Fri, 10 Nov 2017 10:25:15 -0800
Message-ID: <20171110182515.zg3dx5kzpqxcmxfk@dtor-ws>
References: <1510105085-18050-1-git-send-email-anthony.kim@hideep.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1510105085-18050-1-git-send-email-anthony.kim-7TZDMcjUQMzQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anthony Kim <anthony.kim-7TZDMcjUQMzQT0dZR+AlfA@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dennis.hong-7TZDMcjUQMzQT0dZR+AlfA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, Nov 08, 2017 at 10:38:04AM +0900, Anthony Kim wrote:
> Hi All,
> 
> I remaked patch for dmitry's comment.
> Please refer as follow.
> http://www.spinics.net/lists/linux-input/msg53799.html
> 
> I changed our fw binary to big endian format and confirmed that our driver
> code works well.

Applied, thank you.

> 
> - v3
>   - Reverted code for converts to big endian to previous version.
>   - Changed part of variable order of dwz info structure to order of
>     old version.
> 
> - v2
>   - Our fw binary data is little endian, but our IC protocol for fw
>     update use big endian. So it need to conert to big endian data
>     and I added about it.
>   - Changed PGM pattern value to big endian.
>   - Changed to process for product code to using switch case.
> 
> Please review this.
> Thanks!
> 
> Ps. I added to changes about code of previous version.
> 
> diff --git a/drivers/input/touchscreen/hideep.c b/drivers/input/touchscreen/hideep.c
> index 1df0a43..4455a13 100644
> --- a/drivers/input/touchscreen/hideep.c
> +++ b/drivers/input/touchscreen/hideep.c
> @@ -123,9 +123,9 @@ struct dwz_info {
> 	__be16 release_ver;
> 	__be16 custom_ver;
>  
> -	u8 model_name[6];
> 	u8 factory_id;
> 	u8 panel_type;
> +	u8 model_name[6];
>  
> 	__be16 extra_option;
> 	__be16 product_code;
> @@ -408,7 +408,7 @@ static int hideep_check_status(struct hideep_ts *ts)
>  }
>  
>  static int hideep_program_page(struct hideep_ts *ts, u32 addr,
> -			       __be32 *ucode, size_t xfer_count)
> +			       const __be32 *ucode, size_t xfer_count)
>  {
> 	u32 val;
> 	int error;
> @@ -457,15 +457,13 @@ static int hideep_program_page(struct hideep_ts *ts, u32 addr,
>  }
>  
>  static int hideep_program_nvm(struct hideep_ts *ts,
> -			      const u32 *ucode, size_t ucode_len)
> +			      const __be32 *ucode, size_t ucode_len)
>  {
> 	struct pgm_packet *packet_r = (void *)ts->xfer_buf;
> 	__be32 *current_ucode = packet_r->payload;
> -	__be32 write_ucode[HIDEEP_NVM_PAGE_SIZE];
> 	size_t xfer_len;
> 	size_t xfer_count;
> 	u32 addr = 0;
> -	int i;
> 	int error;
>  
> 	hideep_nvm_unlock(ts);
> @@ -483,14 +481,10 @@ static int hideep_program_nvm(struct hideep_ts *ts,
> 			return error;
> 		}
>  
> -		/* Need to because binary data is little endian */
> -		for (i = 0; i < xfer_len; i++)
> -			write_ucode[i] = cpu_to_be32(ucode[i]);
> -
> 		/* See if the page needs updating */
> -		if (memcmp(write_ucode, current_ucode, xfer_len)) {
> +		if (memcmp(ucode, current_ucode, xfer_len)) {
> 			error = hideep_program_page(ts, addr,
> -						    write_ucode, xfer_count);
> +						    ucode, xfer_count);
> 			if (error) {
> 				dev_err(&ts->client->dev,
> 					"%s: iwrite failure @%#08x: %d\n",
> @@ -510,11 +504,10 @@ static int hideep_program_nvm(struct hideep_ts *ts,
>  }
>  
>  static int hideep_verify_nvm(struct hideep_ts *ts,
> -			     const u32 *ucode, size_t ucode_len)
> +			     const __be32 *ucode, size_t ucode_len)
>  {
> 	struct pgm_packet *packet_r = (void *)ts->xfer_buf;
> 	__be32 *current_ucode = packet_r->payload;
> -	__be32 verify_ucode[HIDEEP_NVM_PAGE_SIZE];
> 	size_t xfer_len;
> 	size_t xfer_count;
> 	u32 addr = 0;
> @@ -534,12 +527,8 @@ static int hideep_verify_nvm(struct hideep_ts *ts,
> 			return error;
> 		}
>  
> -		/* Need to because binary data is little endian */
> -		for (i = 0; i < xfer_len; i++)
> -			verify_ucode[i] = cpu_to_be32(ucode[i]);
> -
> -		if (memcmp(verify_ucode, current_ucode, xfer_len)) {
> -			const u8 *ucode_bytes = (const u8 *)verify_ucode;
> +		if (memcmp(ucode, current_ucode, xfer_len)) {
> +			const u8 *ucode_bytes = (const u8 *)ucode;
> 			const u8 *current_bytes = (const u8 *)current_ucode;
>  
> 			for (i = 0; i < xfer_len; i++)
> @@ -611,7 +600,7 @@ static int hideep_load_dwz(struct hideep_ts *ts)
>  }
>  
>  static int hideep_flash_firmware(struct hideep_ts *ts,
> -				 const u32 *ucode, size_t ucode_len)
> +				 const __be32 *ucode, size_t ucode_len)
>  {
> 	int retry_cnt = 3;
> 	int error;
> @@ -629,7 +618,7 @@ static int hideep_flash_firmware(struct hideep_ts *ts,
>  }
>  
>  static int hideep_update_firmware(struct hideep_ts *ts,
> -				  const u32 *ucode, size_t ucode_len)
> +				  const __be32 *ucode, size_t ucode_len)
>  {
> 	int error, error2;
>  
> @@ -909,7 +898,7 @@ static ssize_t hideep_update_fw(struct device *dev,
> 	mutex_lock(&ts->dev_mutex);
> 	disable_irq(client->irq);
>  
> -	error = hideep_update_firmware(ts, (const u32 *)fw_entry->data,
> +	error = hideep_update_firmware(ts, (const __be32 *)fw_entry->data,
> 				       fw_entry->size);
>  
> 	enable_irq(client->irq);
> 
> Anthony Kim (1):
>   Input: add support for HiDeep touchscreen
> 
>  .../bindings/input/touchscreen/hideep.txt          |   42 +
>  .../devicetree/bindings/vendor-prefixes.txt        |    1 +
>  drivers/input/touchscreen/Kconfig                  |   11 +
>  drivers/input/touchscreen/Makefile                 |    1 +
>  drivers/input/touchscreen/hideep.c                 | 1120 ++++++++++++++++++++
>  5 files changed, 1175 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/hideep.txt
>  create mode 100644 drivers/input/touchscreen/hideep.c
> 
> -- 
> 2.7.4
> 

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
