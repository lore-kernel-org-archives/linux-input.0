From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
Subject: Re: [PATCH v2 6/6] hid: add experimental access to PicoLCD device's
 EEPROM and FLASH
Date: Sun, 21 Mar 2010 11:29:22 +0100
Message-ID: <20100321112922.53bb8c6e@neptune.home>
References: <20100320170014.440959a8@neptune.home>
	<20100320171119.193c5615@neptune.home>
	<20100321030802.GB29360@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100321030802.GB29360-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rick L. Vinyard Jr." <rvinyard-qcTL/1vZYtiVc3sceRu5cw@public.gmane.org>, Nicu Pavel <npavel-VxACSXvuqMTQT0dZR+AlfA@public.gmane.org>, Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, Jaya Kumar <jayakumar.lkml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Sat, 20 March 2010 Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote=
:
> On Sat, Mar 20, 2010 at 05:11:19PM +0100, Bruno Pr=C3=A9mont wrote:
> > The PicoLCD device has a small amount of EEPROM and also provides
> > access to its FLASH where firmware and splash image are saved.
> > In flasher mode FLASH access is the only active feature.
> >=20
> > Give read/write access to both via debugfs files.
> >=20
>=20
> It looks you are allowing multiple users access to these files. What
> will happen if 2 processes try to write EEPROM at the same time?

Writes will be serialized by the wait for response from device with
picolcd_send_and_wait() and it's up to userspace to repeat the
reads/writes in order to get all the data they need if they requested
more that the 20 bytes that can be transferred in a single HID report.

=46or flash access a concurrent write to same area can cause one of the
writers to conflict with the other one as a write there is a sequence
of operations which can interleave (e.g. A erases, A writes 1/2,
B erases, B writes 1/2, A writes 2nd 1/2, B writes 2nd 1/2 which would
fail).
A single-user open would be a nice work-around for this.
I would prefer to make erase operation explicitly visible to user so
I don't have to do the erase behind the scenes.
I've not yet looked in the area of mtd/nand support if I can use their
interface.

This is the big reason I did put both to debugfs, they (especially
flash access) need to be made visible in a better way.

> > +
> > +static inline int picolcd_init_devfs(struct picolcd_data *data,
> > +		struct hid_report *eeprom_r, struct hid_report *eeprom_w,
> > +		struct hid_report *flash_r, struct hid_report *flash_w,
> > +		struct hid_report *reset)
> > +{
>=20
> I don't think this should be forced inline.

Ok, will drop most of the 'inline' keywords as you suggested already
on one of the other patches.

Thanks for the review,
Bruno
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
