From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch 2/2] Add a driver for the Winbond WPCD376I Consumer IR
	hardware
Date: Thu, 13 Aug 2009 08:56:37 -0700
Message-ID: <20090813162726.DBD9A526EC9@mailhub.coreip.homeip.net>
References: <20090809095645.198777507@hardeman.nu> <20090809095744.090206173@hardeman.nu> <20090813072905.56FB4526EC9@mailhub.coreip.homeip.net> <d92044dd553973571c2dd5cb18a925f9.squirrel@www.hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:29030 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737AbZHMP4q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Aug 2009 11:56:46 -0400
Content-Disposition: inline
In-Reply-To: <d92044dd553973571c2dd5cb18a925f9.squirrel@www.hardeman.nu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, jbarnes@virtuousgeek.org, akpm@linux-foundation.org, bjorn.helgaas@hp.com, randy.dunlap@oracle.com

On Thu, Aug 13, 2009 at 11:34:44AM +0200, David H=E4rdeman wrote:
> On Thu, August 13, 2009 08:58, Dmitry Torokhov wrote:
> > Hi David,
>=20
> Hi,
>=20
> > Please keep Makefile sorted alphabetically.
>=20
> Ok
>=20
> >> +static struct wbcir_key rc6_def_keymap[] =3D {
> >> +	{ 0x800F0400, KEY_0			},
> >> +	{ 0x800F0401, KEY_1			},
> >> +	{ 0x800F0402, KEY_2			},
> >> +	{ 0x800F0403, KEY_3			},
> >> +	{ 0x800F0404, KEY_4			},
> >> +	{ 0x800F0405, KEY_5			},
> >> +	{ 0x800F0406, KEY_6			},
> >> +	{ 0x800F0407, KEY_7			},
> >> +	{ 0x800F0408, KEY_8			},
> >> +	{ 0x800F0409, KEY_9			},
> >
> > Make these ones KEY_NUMERIC_* as well, this should help users whose
> > keymaps have numbers in upper register normally.
>=20
> Ok
>=20
> >> +	{ 0x800F041D, KEY_NUMERIC_STAR		},
> >> +	{ 0x800F041C, KEY_NUMERIC_POUND		},
> >> +	{ 0x800F0410, KEY_VOLUMEUP		},
> >> +	{ 0x800F0411, KEY_VOLUMEDOWN		},
> >> +	{ 0x800F0412, KEY_CHANNELUP		},
> >> +	{ 0x800F0413, KEY_CHANNELDOWN		},
> >> +	{ 0x800F040E, KEY_MUTE			},
> >> +	{ 0x800F040D, KEY_VENDOR		}, /* Vista Logo Key */
> >> +	{ 0x800F041E, KEY_UP			},
> >> +	{ 0x800F041F, KEY_DOWN			},
> >> +	{ 0x800F0420, KEY_LEFT			},
> >> +	{ 0x800F0421, KEY_RIGHT			},
> >> +	{ 0x800F0422, KEY_OK			},
> >> +	{ 0x800F0423, KEY_ESC			},
> >> +	{ 0x800F040F, KEY_INFO			},
> >> +	{ 0x800F040A, KEY_CLEAR			},
> >> +	{ 0x800F040B, KEY_ENTER			},
> >> +	{ 0x800F045B, KEY_RED			},
> >> +	{ 0x800F045C, KEY_GREEN			},
> >> +	{ 0x800F045D, KEY_YELLOW		},
> >> +	{ 0x800F045E, KEY_BLUE			},
> >> +	{ 0x800F045A, KEY_TEXT			},
> >> +	{ 0x800F0427, KEY_SWITCHVIDEOMODE	},
> >> +	{ 0x800F040C, KEY_POWER			},
> >> +	{ 0x800F0450, KEY_RADIO			},
> >> +	{ 0x800F0448, KEY_PVR			},
> >> +	{ 0x800F0447, KEY_AUDIO			},
> >> +	{ 0x800F0426, KEY_EPG			},
> >> +	{ 0x800F0449, KEY_CAMERA		},
> >> +	{ 0x800F0425, KEY_TV			},
> >> +	{ 0x800F044A, KEY_VIDEO			},
> >> +	{ 0x800F0424, KEY_DVD			},
> >> +	{ 0x800F0416, KEY_PLAY			},
> >> +	{ 0x800F0418, KEY_PAUSE			},
> >> +	{ 0x800F0419, KEY_STOP			},
> >> +	{ 0x800F0414, KEY_FASTFORWARD		},
> >> +	{ 0x800F041A, KEY_NEXT			},
> >> +	{ 0x800F041B, KEY_PREVIOUS		},
> >> +	{ 0x800F0415, KEY_REWIND		},
> >> +	{ 0x800F0417, KEY_RECORD		},
> >
> > Umm, it looks like if you do (code & 0x800F0400) you can switch to
> > standard array-based keymap and won't even need list manipulation.
>=20
> I didn't want to do that since it would potentially tie the driver to=
 one
> particular remote (the one I used for testing while writing the drive=
r).
> The hardware isn't shipped with any specific remote so that wouldn't =
be
> very user friendly.
>=20
> This was the best solution I could come up with without adding some r=
eal
> limitations to the functionality of the driver.

I see.

>=20
> The main problem right now is that getkeycode is practically useless =
since
> you can't blindly guess at a full range of 2^32 different scancodes t=
o get
> the complete keymap. Perhaps a index-based getkeycode would make sens=
e...

The drivers that have such sparce keymaps are expected to issue
EV_MSC/MSC_SCAN events to aid userspace in identifying the "scancodes"
that are emitted by the device.

>=20
> Anyway, I hope that I can make this a moot point in the future by add=
ing
> more IR-specific functionality to the input system. I've been thinkin=
g
> along the lines of IR-specific get/set-keycode ioctl's which would ta=
ke a
> struct which defines the IR command to map to a key.
>=20
> >> +};
> >> +
> >> +/* Registers and other state is protected by wbcir_lock */
> >> +struct wbcir_data {
> >> +	unsigned long wbase;        /* Wake-Up Baseaddr		*/
> >> +	unsigned long ebase;        /* Enhanced Func. Baseaddr	*/
> >> +	unsigned long sbase;        /* Serial Port Baseaddr	*/
> >> +	unsigned int  irq;          /* Serial Port IRQ		*/
> >> +
> >> +	struct input_dev *input_dev;
> >> +	struct timer_list timer_keyup;
> >> +	struct led_trigger *rxtrigger;
> >> +	struct led_trigger *txtrigger;
> >> +	struct led_classdev led;
> >> +
> >> +	u32 last_scancode;
> >> +	unsigned int last_keycode;
> >> +	u8 last_toggle;
> >> +	u8 keypressed;
> >> +	unsigned long keyup_jiffies;
> >> +	unsigned int idle_count;
> >> +
> >> +	/* RX irdata and parsing state */
> >> +	unsigned long irdata[30];
> >> +	unsigned int irdata_count;
> >> +	unsigned int irdata_idle;
> >> +	unsigned int irdata_off;
> >> +	unsigned int irdata_error;
> >> +
> >> +	/* Protected by keytable_lock */
> >> +	struct list_head keytable;
> >
> > I think this has a potential to deadlock... Set and get keycodes ar=
e
> > called with event lock taken, and then your implementations acquire
> > keytable lock. When you emit input events the opposite happens - yo=
u
> > take the keytable lock and then input core takes event lock.
>=20
> Good catch, I'll have to look into that...
>=20
> >> +static struct device_attribute dev_attr_last_scancode =3D {
> >> +	.attr =3D {
> >> +		.name =3D "last_scancode",
> >> +		.mode =3D 0444,
> >> +	},
> >> +	.show =3D wbcir_show_last_scancode,
> >> +	.store =3D NULL,
> >> +
> >> +};
> >
> > Why is this needed? And if this is needed we have a nice macro
> > for that.
>=20
> I hope I've explained it wrt. EV_IR in my other mail. It's for buildi=
ng
> keymaps of unknown remotes. And it'll go away once EV_IR is supported=
 so I
> don't think there's much point in fiddling with it now?
>=20

Because once the driver is in mainline it becomes part of userspace ABI
and has to stay for a looong time.

> >> +static int
> >> +wbcir_probe(struct pnp_dev *device, const struct pnp_device_id *d=
ev_id)
> >
> > __devinit
> >
> ...
> >> +	dev_info(&device->dev, "Found device "
> >> +		 "(w: 0x%lX, e: 0x%lX, s: 0x%lX, i: %u)\n",
> >> +		 data->wbase, data->ebase, data->sbase, data->irq);
> >> +
> >
> > dev_dbg() I think.
>=20
> Ok
>=20
> >> +static void
> >> +wbcir_remove(struct pnp_dev *device)
> >
> > __devexit
>=20
> Ok
>=20
> >> +static struct pnp_driver wbcir_driver =3D {
> >> +	.name     =3D WBCIR_ACPI_NAME,
> >> +	.id_table =3D wbcir_ids,
> >> +	.probe    =3D wbcir_probe,
> >> +	.remove   =3D wbcir_remove,
> >
> > __devexit_p()
>=20
> Ok
>=20
> >> +	.suspend  =3D wbcir_suspend,
> >> +	.resume   =3D wbcir_resume,
> >
> > Switch to dev_pm_ops?
>=20
> Don't want to do that just yet. dev_pm_ops wasn't even on my radar un=
til
> yesterday when I stumbled upon the documentation (in a header file ra=
ther
> than in Documentation/...eh?). I'll certainly look into it when the
> suspend/resume functionality has seen more testing and bug fixing.
>=20
> Thanks for the review. Are you willing to push the driver upstream th=
rough
> the input tree once I've implemented your suggested fixes?
>

I'd need to take a look at your EV_IR patyches and see how they will
affect this driver. I do nt want to merge something that will stay one
way for half a release and then will switch to completely new interface=
=2E

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
