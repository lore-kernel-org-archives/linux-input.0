From: Anisse Astier <anisse@astier.eu>
Subject: Re: [PATCH 4/8] Input: hp-wmi - switch to using sparse keymap
 library
Date: Thu, 3 Dec 2009 10:58:11 +0100
Message-ID: <20091203105811.06571039@destiny.ordissimo>
References: <20091202091056.30409.50455.stgit@localhost.localdomain>
	<20091202092425.30409.85617.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:58191 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbZLCJ7g (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Dec 2009 04:59:36 -0500
In-Reply-To: <20091202092425.30409.85617.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Herton Ronaldo Krzesinski <herton@mandriva.com.br>, Harald Welte <laforge@gnumonks.org>, Corentin Chary <corentincj@iksaif.net>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Wu Zhangjin <wuzhangjin@gmail.com>

Hi Dmitry,

On Wed, 02 Dec 2009 01:24:25 -0800, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote :

> diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
> index c284217..8868610 100644
> --- a/drivers/platform/x86/hp-wmi.c
> +++ b/drivers/platform/x86/hp-wmi.c
> @@ -411,14 +342,29 @@ static int __init hp_wmi_input_setup(void)
>  			    hp_wmi_tablet_state());
>  	input_sync(hp_wmi_input_dev);
>  
> -	err = input_register_device(hp_wmi_input_dev);
> +	err = wmi_install_notify_handler(HPWMI_EVENT_GUID, hp_wmi_notify, NULL);
> +	if (err)
> +		goto err_free_keymap;
>  
> -	if (err) {
> -		input_free_device(hp_wmi_input_dev);
> -		return err;
> -	}
> +	err = input_register_device(hp_wmi_input_dev);
> +	if (err)
> +		goto err_uninstall_notifier;
>  
>  	return 0;
> +
> + err_uninstall_notifier:
> +	wmi_remove_notify_handler(HPWMI_EVENT_GUID);
> + err_free_keymap:
> +	(hp_wmi_input_dev);
> + err_free_dev:
> +	input_free_device(hp_wmi_input_dev);
> +	return err;
> +}
> +
> +static void __exit hp_wmi_input_destroy(void)
> +{
> +	wmi_remove_notify_handler(HPWMI_EVENT_GUID);
> +	input_unregister_device(hp_wmi_input_dev);
>  }
I'm not sure if you're calling sparse_keymap_free on the exit path.

>  
>  static void cleanup_sysfs(struct platform_device *device)
> @@ -564,10 +509,9 @@ static int __init hp_wmi_init(void)
>  
>  static void __exit hp_wmi_exit(void)
>  {
> -	if (wmi_has_guid(HPWMI_EVENT_GUID)) {
> -		wmi_remove_notify_handler(HPWMI_EVENT_GUID);
> -		input_unregister_device(hp_wmi_input_dev);
> -	}
> +	if (wmi_has_guid(HPWMI_EVENT_GUID))
> +		hp_wmi_input_destroy();
> +
>  	if (hp_wmi_platform_dev) {
>  		platform_device_del(hp_wmi_platform_dev);
>  		platform_driver_unregister(&hp_wmi_driver);
> 
OK, I'm guilty, I copied my sparse keymap adaptation for msi-wmi from this
patch :-)

--
Anisse
