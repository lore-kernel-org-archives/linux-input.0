From: Anisse Astier <anisse@astier.eu>
Subject: Re: [RFC PATCH 1/2] Input: add msi-wmi driver to support hotkeys in
 =?UTF-8?B?TVNJwqBXaW5kdG9w?= AE1900-WT
Date: Thu, 3 Dec 2009 10:08:12 +0100
Message-ID: <20091203100812.73491fb1@destiny.ordissimo>
References: <20091202192603.3e1de98a@destiny.ordissimo>
	<20091203031128.GA9121@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20091203031128.GA9121@core.coreip.homeip.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>
List-Id: linux-input@vger.kernel.org

On Wed, 2 Dec 2009 19:11:28 -0800, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote :

> Hi Anisse,
>=20
> On Wed, Dec 02, 2009 at 07:26:03PM +0100, Anisse Astier wrote:
> > +
> > +	if (jiffies_to_msecs(get_jiffies_64() -
> > msi_wmi_time_last_press)
> > +			> pression_timeout) {
>=20
> Why don't you use time_after() instead of manual computation?
>=20
> Also, what is the point of this? If you are trying to debounce the
> buttons this will not quite work. To do debouncing properly you need
> to store the value you just read and fire up a timer. When timer
> fires - that's the stable value.

Indeed, the point is to debounce the keys. I guess I=E2=80=99ll just us=
e the=20
debounce mecanism in use in the gpio_keys driver.
But why use a timer instead of a delayed workqueue? Do we need the prec=
ison
of a timer for a simple debounce?

> > +		printk(KERN_DEBUG
> > +				"MSI WMI: event correctly
> > received: %llu\n",
> > +				obj->integer.value);
>=20
> This is way too noisy for the mainline kernel, pr_debug() perhaps?
Sure.

> > +	msi_wmi_input_setup();
>=20
>=20
> You need to handle errors returned by msi_wmi_input_setup() as well.

Yes, I reworked the init in the second patch, I'll put the clean init i=
n
the first one for v2.

> > +MODULE_PARM_DESC(pression_timeout,
> > +		 "How much time interrupts are ignored between
> > each pression");
>=20
> This is not the best option name:
>=20
> MODULE_PARM_DESC(debounce_interval,
> 		 "Controls how long driver will wait for button to
> debounce");
>=20

Thanks a lot for your comments.

Regards,

Anisse
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
