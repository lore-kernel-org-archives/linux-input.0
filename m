From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH, RFC] HP WMI hotkey driver
Date: Thu, 3 Jan 2008 11:58:02 -0500
Message-ID: <d120d5000801030858o7a1f5112g1041186636852ab7@mail.gmail.com>
References: <20071218235137.12838.75397.stgit@localhost>
	 <20071226224812.GA32652@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:32490 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666AbYACQ6F (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Jan 2008 11:58:05 -0500
Received: by nf-out-0910.google.com with SMTP id g13so408020nfb.21
        for <linux-input@vger.kernel.org>; Thu, 03 Jan 2008 08:58:03 -0800 (PST)
In-Reply-To: <20071226224812.GA32652@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Alexey Starikovskiy <aystarik@gmail.com>, linux-input@vger.kernel.org

Hi Matthew,

On Dec 26, 2007 5:48 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> +       } else
> +               printk (KERN_INFO "HP WMI: Unknown response received\n");
> +
> +       return;

No need for empty returns.

> +}
> +
> +static int __init hp_wmi_init(void)
> +{
> +       int err;
> +       const struct key_entry *key;
> +
> +       if (!wmi_has_guid(HPWMI_GUID)) {
> +               printk ("Unable to locate guid\n");
> +               return -ENODEV;
> +       }
> +
> +       err = wmi_install_notify_handler (hp_wmi_notify, NULL);
> +       if (err)
> +               return err;
> +
> +       hp_wmi_input_dev = input_allocate_device();
> +
> +       hp_wmi_input_dev->name = "HP WMI hotkeys";
> +       hp_wmi_input_dev->phys = "wmi/input0";
> +       hp_wmi_input_dev->id.bustype = BUS_HOST;
> +       hp_wmi_input_dev->getkeycode = hp_wmi_getkeycode;
> +       hp_wmi_input_dev->setkeycode = hp_wmi_setkeycode;
> +

There is no sysfs device to attach the input device to, by any chance?

> +       for (key = hp_wmi_keymap; key->type != KE_END; key++) {
> +               set_bit(EV_KEY, hp_wmi_input_dev->evbit);
> +               set_bit(key->keycode, hp_wmi_input_dev->keybit);
> +       }
> +
> +       err = input_register_device (hp_wmi_input_dev);
> +
> +       if (err) {
> +               input_free_device (hp_wmi_input_dev);
> +               return err;
> +       }
> +
> +       return 0;
> +}
> +
> +static void __exit hp_wmi_exit(void)
> +{
> +       wmi_remove_notify_handler();
> +       input_unregister_device (hp_wmi_input_dev);
> +       input_free_device (hp_wmi_input_dev);

Do not call input_free_device after input_unregister_device, it may
cause freeing already freed memory.

-- 
Dmitry
