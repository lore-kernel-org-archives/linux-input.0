From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/4] Detect the WiFi/Bluetooth/3G devices available
Date: Mon, 18 Oct 2010 08:55:47 -0700
Message-ID: <20101018155547.GA10559@core.coreip.homeip.net>
References: <1287414463-13973-1-git-send-email-jlee@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:44543 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755222Ab0JRP4B (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Oct 2010 11:56:01 -0400
Content-Disposition: inline
In-Reply-To: <1287414463-13973-1-git-send-email-jlee@novell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, mjg59@srcf.ucam.org, carlos@strangeworlds.co.uk, linux-input@vger.kernel.org, tiwai@novell.com, trenn@novell.com, jbenc@suse.cz, corentin.chary@gmail.com, GregKH@novell.com, "Lee, Chun-Yi" <jlee@novell.com>

Hi,

On Mon, Oct 18, 2010 at 11:07:43PM +0800, Lee, Chun-Yi wrote:
> +static void type_aa_dmi_decode(const struct dmi_header *header, void *dummy)
> +{
> +	/* We are looking for OEM-specific Type Aah */
> +	if (header->type != ACER_DMI_DEV_TYPE_AA)
> +		return;
> +
> +	type_aa = (struct hotkey_function_type_aa *) header;
> +
> +	printk(ACER_INFO "Function biti map for Communication Button: 0x%x\n",
> +		type_aa->commun_func_bitmap);
> +	if (!!(type_aa->commun_func_bitmap & ACER_WMID3_GDS_WIRELESS))
> +		interface->capability |= ACER_CAP_WIRELESS;
> +	if (!!(type_aa->commun_func_bitmap & ACER_WMID3_GDS_THREEG))
> +		interface->capability |= ACER_CAP_THREEG;
> +	if (!!(type_aa->commun_func_bitmap & ACER_WMID3_GDS_BLUETOOTH))
> +		interface->capability |= ACER_CAP_BLUETOOTH;

The "!!" is completely redundant here.

> +}
> +
>  static acpi_status WMID_set_capabilities(void)
>  {
>  	struct acpi_buffer out = {ACPI_ALLOCATE_BUFFER, NULL};
> @@ -844,16 +875,17 @@ static acpi_status WMID_set_capabilities(void)
>  		return AE_ERROR;
>  	}
>  
> -	/* Not sure on the meaning of the relevant bits yet to detect these */
> -	interface->capability |= ACER_CAP_WIRELESS;
> -	interface->capability |= ACER_CAP_THREEG;
> +	dmi_walk(type_aa_dmi_decode, NULL);
> +	if (!type_aa) {
> +		interface->capability |= ACER_CAP_WIRELESS;
> +		interface->capability |= ACER_CAP_THREEG;
> +		if (devices & 0x10)
> +			interface->capability |= ACER_CAP_BLUETOOTH;
> +	}

Since you are storing "type_aa" anyways it probably would be better to
set all capabilities here, in one place...

Thanks.

-- 
Dmitry
