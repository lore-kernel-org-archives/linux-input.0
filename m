From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Add acer wmi hotkey events support
Date: Fri, 1 Oct 2010 09:58:34 -0700
Message-ID: <20101001165833.GA15390@core.coreip.homeip.net>
References: <1285941088-31196-1-git-send-email-jlee@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1285941088-31196-1-git-send-email-jlee@novell.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, mjg59@srcf.ucam.org, carlos@strangeworlds.co.uk, linux-input@vger.kernel.org, tiwai@novell.com, trenn@novell.com, jbenc@suse.cz, "Lee, Chun-Yi" <jlee@novell.com>
List-Id: linux-input@vger.kernel.org

Hi Lee,

On Fri, Oct 01, 2010 at 09:51:27PM +0800, Lee, Chun-Yi wrote:
> +
> +struct key_entry {
> +	char type;	/* See KE_* below */
> +	u16 code;
> +	u16 keycode;
> +};
> +
> +enum { KE_KEY, KE_END };
> +

Like Corentin said, please use sparse_keymap, it will cut the code in
half.

> +
> +	set_bit(EV_SW, acer_wmi_input_dev->evbit);
> +

I do not see you sending SW_* events...

> +	err = input_register_device(acer_wmi_input_dev);
> +
> +	if (err) {
> +		input_free_device(acer_wmi_input_dev);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * debugfs functions
>   */
> @@ -1327,6 +1518,18 @@ static int __init acer_wmi_init(void)
>  		       "generic video driver\n");
>  	}
>  
> +	if (wmi_has_guid(ACERWMID_EVENT_GUID)) {
> +		err = wmi_install_notify_handler(ACERWMID_EVENT_GUID,
> +						acer_wmi_notify, NULL);
> +		if (ACPI_FAILURE(err))
> +			return -EINVAL;
> +		err = acer_wmi_input_setup();

You really want to set up the device first and install notify handler
later. What will happen if event will fire up while input device has not
been created yet?

> +		if (err) {
> +			wmi_remove_notify_handler(ACERWMID_EVENT_GUID);
> +			return err;
> +		}
> +	}
> +
>  	err = platform_driver_register(&acer_platform_driver);
>  	if (err) {
>  		printk(ACER_ERR "Unable to register platform driver.\n");
> @@ -1368,11 +1571,21 @@ error_device_add:
>  error_device_alloc:
>  	platform_driver_unregister(&acer_platform_driver);
>  error_platform_register:
> +	if (wmi_has_guid(ACERWMID_EVENT_GUID)) {
> +		input_unregister_device(acer_wmi_input_dev);
> +		wmi_remove_notify_handler(ACERWMID_EVENT_GUID);

Same here, first shut off notified, then remove the device.

> +	}
> +
>  	return err;
>  }
>  
>  static void __exit acer_wmi_exit(void)
>  {
> +	if (wmi_has_guid(ACERWMID_EVENT_GUID)) {
> +		wmi_remove_notify_handler(ACERWMID_EVENT_GUID);
> +		input_unregister_device(acer_wmi_input_dev);

Same here.

Thanks.

-- 
Dmitry
