From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/7] HID: picoLCD updates
Date: Sun, 19 Aug 2012 15:56:24 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1208191545230.7627-100000@netrider.rowland.org>
References: <20120819182300.63665a0b@neptune.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120819182300.63665a0b@neptune.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, 19 Aug 2012, Bruno Pr=C3=A9mont wrote:

> > I don't know bout hid_hw_close().  Certainly no more reports should=
 be=20
> > submitted following usbhid_stop().
>=20
> Ok, I did just that, prevent new calls to usbhid_submit_report(), aft=
er
> calling hid_hw_close(), fixed one bug in my code that triggers the NU=
LL
> pointer dereference (calling hid_set_drvdata(hdev, NULL) too early).
>=20
> Now I'm still seeing the bad paging request in _mmx_memcpy(), though =
rather
> sporadically.
> The last ones I saw were during remove() around the time of calling h=
id_hw_close()
> and hid_hw_stop(). Adding a printk() between the two (at least while =
picoLCD
> is hosting fbcon) makes it very improbably for the bad page to happen=
=2E
>=20
> It looks like low-level driver did free memory in hid_hw_close() for =
some
> in-flight URB and thus things break in following USB interrupt.

No, memory is not freed in usbhid_close().  It is freed in=20
usbhid_stop().

> From mapping trace information to source it seems:
> usbhid/hid-core.c:
> static int hid_submit_out(struct hid_device *hid)
> {
>         struct hid_report *report;
>         char *raw_report;
>         struct usbhid_device *usbhid =3D hid->driver_data;
>         int r;
>=20
>         report =3D usbhid->out[usbhid->outtail].report;
>         raw_report =3D usbhid->out[usbhid->outtail].raw_report;
>=20
>         usbhid->urbout->transfer_buffer_length =3D ((report->size - 1=
) >> 3) +
>                                                  1 + (report->id > 0)=
;
>         usbhid->urbout->dev =3D hid_to_usb_dev(hid);
>         if (raw_report) {
>                 memcpy(usbhid->outbuf, raw_report,
>                                 usbhid->urbout->transfer_buffer_lengt=
h);
>                 ^^^^^^^^^^^^^^^_ this is exploding

Right.  Like I said, usbhid->outbuf is freed in hid_free_buffers(),=20
which is called from usbhid_stop().

=46orget about usbhid_close().  The race is between hid_submit_out() an=
d=20
usbhid_stop().

Alan Stern
