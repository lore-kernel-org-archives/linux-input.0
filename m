From: legolas558 <legolas558@email.it>
Subject: Re: [PATCH] Make Dell keyboard repeat quirk apply to a wider range
 of hardware
Date: Thu, 14 Aug 2008 06:50:30 +0200
Message-ID: <48A3B996.3080409@email.it>
References: <20080814033255.GA21721@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from m-04.th.seeweb.it ([217.64.195.227]:45164 "EHLO
	m-04.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194AbYHNFA2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Aug 2008 01:00:28 -0400
In-Reply-To: <20080814033255.GA21721@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Matthew Garrett <mjg59@srcf.ucam.org>

Hello there.

In this kernel bug http://bugzilla.kernel.org/show_bug.cgi?id=9147 we 
are experiencing a problem with Fn keys when ACPI is active.
Maybe this patch will fix bug 9147 as side-effect?

Thank you,
--
  Daniele C.

Matthew Garrett ha scritto:
> Dell laptops fail to send key up events for several of their special 
> keys. There's an existing quirk in the kernel to handle this, but it's 
> limited to the Latitude range. This patch extends it to cover all 
> portable Dells.
>
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
>
> ---
> diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
> index b1ce10f..e32c24d 100644
> --- a/drivers/input/keyboard/atkbd.c
> +++ b/drivers/input/keyboard/atkbd.c
> @@ -834,10 +834,10 @@ static void atkbd_disconnect(struct serio *serio)
>  }
>  
>  /*
> - * Most special keys (Fn+F?) on Dell Latitudes do not generate release
> + * Most special keys (Fn+F?) on Dell laptops do not generate release
>   * events so we have to do it ourselves.
>   */
> -static void atkbd_latitude_keymap_fixup(struct atkbd *atkbd)
> +static void atkbd_dell_laptop_keymap_fixup(struct atkbd *atkbd)
>  {
>  	const unsigned int forced_release_keys[] = {
>  		0x85, 0x86, 0x87, 0x88, 0x89, 0x8a, 0x8b, 0x8f, 0x93,
> @@ -1461,13 +1461,13 @@ static int __init atkbd_setup_fixup(const struct dmi_system_id *id)
>  
>  static struct dmi_system_id atkbd_dmi_quirk_table[] __initdata = {
>  	{
> -		.ident = "Dell Latitude series",
> +		.ident = "Dell Laptop",
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Latitude"),
> +			DMI_MATCH(DMI_CHASSIS_TYPE, "8"), /* Portable */
>  		},
>  		.callback = atkbd_setup_fixup,
> -		.driver_data = atkbd_latitude_keymap_fixup,
> +		.driver_data = atkbd_dell_laptop_keymap_fixup,
>  	},
>  	{
>  		.ident = "HP 2133",
>
>   

