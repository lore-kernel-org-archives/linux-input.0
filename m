From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] Add acer wmi hotkey events support
Date: Wed, 13 Oct 2010 11:24:26 -0700
Message-ID: <20101013182426.GB13094@core.coreip.homeip.net>
References: <1286941662-9774-1-git-send-email-jlee@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1286941662-9774-1-git-send-email-jlee@novell.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, mjg59@srcf.ucam.org, carlos@strangeworlds.co.uk, linux-input@vger.kernel.org, tiwai@novell.com, trenn@novell.com, jbenc@suse.cz, corentin.chary@gmail.com, "Lee, Chun-Yi" <jlee@novell.com>
List-Id: linux-input@vger.kernel.org

Hi Joey,

On Wed, Oct 13, 2010 at 11:47:40AM +0800, Lee, Chun-Yi wrote:
 +
> +	status = wmi_install_notify_handler(ACERWMID_EVENT_GUID,
> +						acer_wmi_notify, NULL);
> +	if (ACPI_FAILURE(status)) {
> +		err = -EIO;
> +		goto err_unregister_input;
> +	}
> +
> +	return 0;
> +
> +err_unregister_input:
> +	input_unregister_device(acer_wmi_input_dev);
> +err_free_keymap:
> +	sparse_keymap_free(acer_wmi_input_dev);
> +err_free_dev:
> +	input_free_device(acer_wmi_input_dev);

If wmi_install_notify_handler() fails you'll end up doing
input_unregister_device() + input_free_device() which is forbidden. To
avoid this issue register the device after installing the handler. As
long as input device is properly allocated (by calling
input_allocate_device) it is safe to use it to send events (although
they will not go anywhere).

BTW, I think it is high time we allocate a dedicated key for touchpad
on/off....

Thanks.

-- 
Dmitry
