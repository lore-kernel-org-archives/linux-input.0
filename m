From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elan_i2c - Fix typos for validpage_count
Date: Fri, 28 Aug 2015 17:30:39 -0700
Message-ID: <20150829003039.GB8298@dtor-ws>
References: <1440613171-20549-1-git-send-email-bleung@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:32825 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047AbbH2Aam (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Aug 2015 20:30:42 -0400
Content-Disposition: inline
In-Reply-To: <1440613171-20549-1-git-send-email-bleung@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benson Leung <bleung@chromium.org>
Cc: dusonlin@emc.com.tw, michele.curti@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Aug 26, 2015 at 11:19:31AM -0700, Benson Leung wrote:
> Search for "vaildpage_count" and replace with "validpage_count".
> 
> Signed-off-by: Benson Leung <bleung@chromium.org>

Applied, thank you.

> ---
>  drivers/input/mouse/elan_i2c_core.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> index bbdaedc..d4a38ca 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -84,7 +84,7 @@ struct elan_tp_data {
>  	int			pressure_adjustment;
>  	u8			mode;
>  	u8			ic_type;
> -	u16			fw_vaildpage_count;
> +	u16			fw_validpage_count;
>  	u16			fw_signature_address;
>  
>  	bool			irq_wake;
> @@ -94,28 +94,28 @@ struct elan_tp_data {
>  	bool			baseline_ready;
>  };
>  
> -static int elan_get_fwinfo(u8 ic_type, u16 *vaildpage_count,
> +static int elan_get_fwinfo(u8 ic_type, u16 *validpage_count,
>  			   u16 *signature_address)
>  {
>  	switch(ic_type) {
>  	case 0x08:
> -		*vaildpage_count = 512;
> +		*validpage_count = 512;
>  		break;
>  	case 0x09:
> -		*vaildpage_count = 768;
> +		*validpage_count = 768;
>  		break;
>  	case 0x0D:
> -		*vaildpage_count = 896;
> +		*validpage_count = 896;
>  		break;
>  	default:
>  		/* unknown ic type clear value */
> -		*vaildpage_count = 0;
> +		*validpage_count = 0;
>  		*signature_address = 0;
>  		return -ENXIO;
>  	}
>  
>  	*signature_address =
> -		(*vaildpage_count * ETP_FW_PAGE_SIZE) - ETP_FW_SIGNATURE_SIZE;
> +		(*validpage_count * ETP_FW_PAGE_SIZE) - ETP_FW_SIGNATURE_SIZE;
>  
>  	return 0;
>  }
> @@ -264,7 +264,7 @@ static int elan_query_device_info(struct elan_tp_data *data)
>  	if (error)
>  		return error;
>  
> -	error = elan_get_fwinfo(data->ic_type, &data->fw_vaildpage_count,
> +	error = elan_get_fwinfo(data->ic_type, &data->fw_validpage_count,
>  				&data->fw_signature_address);
>  	if (error) {
>  		dev_err(&data->client->dev,
> @@ -356,7 +356,7 @@ static int __elan_update_firmware(struct elan_tp_data *data,
>  	iap_start_addr = get_unaligned_le16(&fw->data[ETP_IAP_START_ADDR * 2]);
>  
>  	boot_page_count = (iap_start_addr * 2) / ETP_FW_PAGE_SIZE;
> -	for (i = boot_page_count; i < data->fw_vaildpage_count; i++) {
> +	for (i = boot_page_count; i < data->fw_validpage_count; i++) {
>  		u16 checksum = 0;
>  		const u8 *page = &fw->data[i * ETP_FW_PAGE_SIZE];
>  
> -- 
> 2.5.0.457.gab17608
> 

-- 
Dmitry
