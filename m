From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH 1/2] =?iso-8859-1?Q?Input?=
	=?iso-8859-1?Q?=3A_add_msi-wmi_driver_to_support_hotkeys_in_MSI=A0Windto?=
	=?iso-8859-1?Q?p?= AE1900-WT
Date: Wed, 2 Dec 2009 19:11:28 -0800
Message-ID: <20091203031128.GA9121@core.coreip.homeip.net>
References: <20091202192603.3e1de98a@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091202192603.3e1de98a@destiny.ordissimo>
Sender: linux-acpi-owner@vger.kernel.org
To: Anisse Astier <anisse@astier.eu>
Cc: linux-input@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>
List-Id: linux-input@vger.kernel.org

Hi Anisse,

On Wed, Dec 02, 2009 at 07:26:03PM +0100, Anisse Astier wrote:
> +
> +	if (jiffies_to_msecs(get_jiffies_64() - msi_wmi_time_last_press)
> +			> pression_timeout) {

Why don't you use time_after() instead of manual computation?

Also, what is the point of this? If you are trying to debounce the
buttons this will not quite work. To do debouncing properly you need to
store the value you just read and fire up a timer. When timer fires -
that's the stable value.

> +		printk(KERN_DEBUG
> +				"MSI WMI: event correctly received: %llu\n",
> +				obj->integer.value);

This is way too noisy for the mainline kernel, pr_debug() perhaps?

> +		msi_wmi_time_last_press =3D get_jiffies_64();
> +		key =3D msi_wmi_get_entry_by_scancode(obj->integer.value);
> +		input_report_key(msi_wmi_input_dev, key->keycode, 1);
> +		input_sync(msi_wmi_input_dev);
> +		input_report_key(msi_wmi_input_dev, key->keycode, 0);
> +		input_sync(msi_wmi_input_dev);
> +	}
> +}
> +
> +static int msi_wmi_getkeycode(struct input_dev *dev, int scancode, i=
nt *keycode)
> +{
> +	struct key_entry *key =3D msi_wmi_get_entry_by_scancode(scancode);
> +
> +	if (key && key->code) {
> +		*keycode =3D key->keycode;
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int msi_wmi_setkeycode(struct input_dev *dev, int scancode, i=
nt keycode)
> +{
> +	struct key_entry *key;
> +	int old_keycode;
> +
> +	if (keycode < 0 || keycode > KEY_MAX)
> +		return -EINVAL;
> +
> +	key =3D msi_wmi_get_entry_by_scancode(scancode);
> +	if (key && key->code) {
> +		old_keycode =3D key->keycode;
> +		key->keycode =3D keycode;
> +		set_bit(keycode, dev->keybit);
> +		if (!msi_wmi_get_entry_by_keycode(old_keycode))
> +			clear_bit(old_keycode, dev->keybit);
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int __init msi_wmi_input_setup(void)
> +{
> +	struct key_entry *key;
> +	int err;
> +
> +	msi_wmi_input_dev =3D input_allocate_device();
> +
> +	msi_wmi_input_dev->name =3D "MSI WMI hotkeys";
> +	msi_wmi_input_dev->phys =3D "wmi/input0";
> +	msi_wmi_input_dev->id.bustype =3D BUS_HOST;
> +	msi_wmi_input_dev->getkeycode =3D msi_wmi_getkeycode;
> +	msi_wmi_input_dev->setkeycode =3D msi_wmi_setkeycode;
> +
> +	for (key =3D msi_wmi_keymap; key->code; key++) {
> +		set_bit(EV_KEY, msi_wmi_input_dev->evbit);
> +		set_bit(key->keycode, msi_wmi_input_dev->keybit);
> +	}
> +
> +	err =3D input_register_device(msi_wmi_input_dev);
> +
> +	if (err)
> +		input_free_device(msi_wmi_input_dev);
> +
> +	return err;
> +}
> +
> +static int __init msi_wmi_init(void)
> +{
> +	int err;
> +
> +	msi_wmi_time_last_press =3D get_jiffies_64();
> +	if (!wmi_has_guid(MSIWMI_EVENT_GUID)) {
> +		printk(KERN_ERR
> +		       "This machine doesn't have MSI-hotkeys through WMI\n");
> +		goto load_error;
> +	}
> +	err =3D wmi_install_notify_handler(MSIWMI_EVENT_GUID,
> +					 msi_wmi_notify, NULL);
> +	if (err) {
> +		printk(KERN_ERR
> +		       "MSI WMI: Error while installing notify handler\n");
> +		goto load_error;
> +	}
> +
> +	msi_wmi_input_setup();


You need to handle errors returned by msi_wmi_input_setup() as well.

> +
> +	return 0;
> +load_error:
> +	return -ENODEV;
> +}
> +
> +static void __exit msi_wmi_exit(void)
> +{
> +	if (wmi_has_guid(MSIWMI_EVENT_GUID)) {
> +		wmi_remove_notify_handler(MSIWMI_EVENT_GUID);
> +		input_unregister_device(msi_wmi_input_dev);
> +	}
> +}
> +
> +module_init(msi_wmi_init);
> +module_exit(msi_wmi_exit);
> +module_param(pression_timeout, uint, 0);
> +
> +MODULE_AUTHOR("J=E9r=F4me Pouiller <jezz@sysmic.org>");
> +MODULE_AUTHOR("Michael Bouchaud <michael@substantiel.fr");
> +MODULE_AUTHOR("Anisse Astier <anisse@astier.eu");
> +MODULE_DESCRIPTION("MSI all-in-one WMI hotkeys driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("wmi:" MSIWMI_EVENT_GUID);
> +/*This one is useless if there is wmi-autoloading*/
> +MODULE_ALIAS("dmi:bvnMICRO-STARINTERNATIONALCO.,LTD:*:svnMICRO-STARI=
NTERNATIO"
> +	     "NALCO.,LTD:pnMS-6638:*:rnMS-7438:*:cvnMICRO-STARINTERNATIONAL=
CO."
> +	     ",LTD:*");
> +MODULE_PARM_DESC(pression_timeout,
> +		 "How much time interrupts are ignored between each pression");

This is not the best option name:

MODULE_PARM_DESC(debounce_interval,
		 "Controls how long driver will wait for button to debounce");

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
