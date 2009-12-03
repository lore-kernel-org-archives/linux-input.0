From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH 1/2] =?iso-8859-1?Q?Input?=
	=?iso-8859-1?Q?=3A_add_msi-wmi_driver_to_support_hotkeys_in_MSI=A0Windto?=
	=?iso-8859-1?Q?p?= AE1900-WT
Date: Thu, 3 Dec 2009 01:34:48 -0800
Message-ID: <20091203093447.GA22196@core.coreip.homeip.net>
References: <20091202192603.3e1de98a@destiny.ordissimo> <20091203031128.GA9121@core.coreip.homeip.net> <20091203100812.73491fb1@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091203100812.73491fb1@destiny.ordissimo>
Sender: linux-acpi-owner@vger.kernel.org
To: Anisse Astier <anisse@astier.eu>
Cc: linux-input@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>
List-Id: linux-input@vger.kernel.org

On Thu, Dec 03, 2009 at 10:08:12AM +0100, Anisse Astier wrote:
> On Wed, 2 Dec 2009 19:11:28 -0800, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote :
>=20
> > Hi Anisse,
> >=20
> > On Wed, Dec 02, 2009 at 07:26:03PM +0100, Anisse Astier wrote:
> > > +
> > > +	if (jiffies_to_msecs(get_jiffies_64() -
> > > msi_wmi_time_last_press)
> > > +			> pression_timeout) {
> >=20
> > Why don't you use time_after() instead of manual computation?
> >=20
> > Also, what is the point of this? If you are trying to debounce the
> > buttons this will not quite work. To do debouncing properly you nee=
d
> > to store the value you just read and fire up a timer. When timer
> > fires - that's the stable value.
>=20
> Indeed, the point is to debounce the keys. I guess I=E2=80=99ll just =
use the=20
> debounce mecanism in use in the gpio_keys driver.
> But why use a timer instead of a delayed workqueue? Do we need the pr=
ecison
> of a timer for a simple debounce?

Unlike timer workqueue will not be rescheduled if it is already pending=
=2E
mod_timer() will chnage the firing time.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
