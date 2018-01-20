From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: Re: [PATCH v3] input: pxrc: new driver for PhoenixRC Flight
 Controller Adapter
Date: Sat, 20 Jan 2018 22:07:45 +0100
Message-ID: <20180120205554.GA12580@gmail.com>
References: <20180113201532.26016-1-marcus.folkesson@gmail.com>
 <20180116231625.e3sgum667xfuumx4@dtor-ws>
 <20180117135840.GA10949@gmail.com>
 <20180119232432.xygulmwpkw3vogls@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180119232432.xygulmwpkw3vogls@dtor-ws>
Sender: linux-doc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Tomohiro Yoshidomi <sylph23k@gmail.com>, David Herrmann <dh.herrmann@gmail.com>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Dmitry,

On Fri, Jan 19, 2018 at 03:24:32PM -0800, Dmitry Torokhov wrote:
> On Wed, Jan 17, 2018 at 02:58:40PM +0100, Marcus Folkesson wrote:
> > Hello Dmitry,
> >=20
> > On Tue, Jan 16, 2018 at 03:16:25PM -0800, Dmitry Torokhov wrote:
> > > Hi Marcus,
> > >=20
> > > On Sat, Jan 13, 2018 at 09:15:32PM +0100, Marcus Folkesson wrote:
> > > > This driver let you plug in your RC controller to the adapter and
> > > > use it as input device in various RC simulators.
> > > >=20
> > > > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > > > ---
> > > > v3:
> > > > 	- Use RUDDER and MISC instead of TILT_X and TILT_Y
> > > > 	- Drop kref and anchor
> > > > 	- Rework URB handling
> > > > 	- Add PM support
> > >=20
> > > How did you test the PM support? By default the autopm is disabled on
> > > USB devices; you need to enable it by writing to sysfs (I believe you
> > > need to 'echo "auto" > /sys/bus/usb/<device>/power/control) and see if
> > > it gets autosuspended when not in use and resumed after you start
> > > interacting with it.
> >=20
> > The test I've done is simply reading from the input device and then call
> > `pm-suspend`.
> > It works, suspend is called and reset_resume() will submit the URB
> > again. Without the PM code, the application did not read any events upon
> > resume.
>=20
> We are talking about different things. You are testing system suspend,
> whereas I was talking about runtime suspend (that's what
> usb_autopm_get_interface() and friends does). It is disabled by default
> and you need to enable it by writing into sysfs as I mentioned above.
> Then, after a few seconds of not touching the device you should see the
> USB interface going into low power state and the device shoudl correctly
> implement remote wakeup signal to wake up the host controller/port when
> user touches it. If the device does not implement this correctly, then
> after suspending it will "die".
>=20


Ok, I have read more about the autosuspend feature and I will drop
the support as the device does not seems to support remote wakeup
signals.

> >=20
> > However, I found another tricky part.
> > If I enable autosuspend (as you suggest) it will suspend when noone is
> > using the device. Good.
> >=20
> > But when someone is opening the device, input_dev->users is counted up
> > to 1 before resume() is called.=20
> > Is this intended?
> >=20
> > This code (from resume()) will therefor allways submit the URB:
> >=20
> > if (input_dev->users && usb_submit_urb(pxrc->urb, GFP_NOIO) < 0)
> >=20
> >=20
> > Then open() is called and fails because the urb is allready submitted.
> >=20
> > input_dev->users is only incremented in input.c:input_open_device() what
> > I can tell?
>=20
> It is intended, but I guess we should not be using input_dev->users in
> resume(), but rather have a local flag in your driver structure trhat
> you update at the right time (i.e. after you submit USB in pxrc_open()).
>=20
> I suppose we need the same fix in synaptics_usb.c...
>=20

Will do.
I fix the synaptics_usb driver as well.

Also, I think we have a deadlock in the synaptics_usb driver.

When the device is suspended and someone is open the device, the input
subsystem will call input_open_device() which takes the
input_dev->mutex and then call input_dev->open().

synusb_open() has a call to usb_autopm_get_interface() which will
result in a call to the registered resume-function if the device is
suspended. (see Documentation/driver-api/usb/power-manaement.rst).

In the case of snaptics_usb, it will take the input_dev->mutex in the
resume function.

I have no synaptic mouse, but tested to put the same code into my
driver just to confirm, and got the following dump:

[ 9215.626476] INFO: task input-events:8590 blocked for more than 120 secon=
ds.
[ 9215.626495]       Not tainted 4.15.0-rc8-ARCH+ #6
[ 9215.626500] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this message.
[ 9215.626507] input-events    D    0  8590   4394 0x00000004
[ 9215.626520] Call Trace:
[ 9215.626546]  ? __schedule+0x236/0x850
[ 9215.626559]  schedule+0x2f/0x90
[ 9215.626569]  schedule_preempt_disabled+0x11/0x20
[ 9215.626579]  __mutex_lock.isra.0+0x1aa/0x520
[ 9215.626609]  ? usb_runtime_suspend+0x70/0x70 [usbcore]
[ 9215.626622]  ? pxrc_resume+0x37/0x70 [pxrc]
[ 9215.626632]  pxrc_resume+0x37/0x70 [pxrc]
[ 9215.626655]  usb_resume_interface.isra.2+0x39/0xe0 [usbcore]
[ 9215.626676]  usb_resume_both+0xd2/0x120 [usbcore]
[ 9215.626688]  __rpm_callback+0xb6/0x1f0
[ 9215.626699]  rpm_callback+0x1f/0x70
[ 9215.626718]  ? usb_runtime_suspend+0x70/0x70 [usbcore]
[ 9215.626726]  rpm_resume+0x4e2/0x7f0
[ 9215.626737]  rpm_resume+0x582/0x7f0
[ 9215.626749]  __pm_runtime_resume+0x3a/0x50
[ 9215.626767]  usb_autopm_get_interface+0x1d/0x50 [usbcore]
[ 9215.626780]  pxrc_open+0x17/0x8d [pxrc]
[ 9215.626791]  input_open_device+0x70/0xa0
[ 9215.626804]  evdev_open+0x183/0x1c0 [evdev]
[ 9215.626819]  chrdev_open+0xa0/0x1b0
[ 9215.626830]  ? cdev_put.part.1+0x20/0x20
[ 9215.626840]  do_dentry_open+0x1ad/0x2c0
[ 9215.626855]  path_openat+0x576/0x1300
[ 9215.626868]  ? alloc_set_pte+0x22c/0x520
[ 9215.626883]  ? filemap_map_pages+0x19b/0x340
[ 9215.626893]  do_filp_open+0x9b/0x110
[ 9215.626908]  ? __check_object_size+0x9d/0x190
[ 9215.626920]  ? __alloc_fd+0xaf/0x160
[ 9215.626931]  ? do_sys_open+0x1bd/0x250
[ 9215.626942]  do_sys_open+0x1bd/0x250
[ 9215.626956]  entry_SYSCALL_64_fastpath+0x20/0x83
[ 9215.626967] RIP: 0033:0x7fbf6358f7ae


tablet/pegasus_notetaker.c and touchscreen/usbtouchscreen.c has the same
construction (taking input_dev->mutex in resume/suspend and call
usb_autopm_get_interface() in open()).

I will create a separate "pm_mutex" to use instead of input_dev->mutex
to get rid of the lockups in those drivers=20


> >=20
> > I will move the submitting code to reset_resume() instead.
>=20
> You need both resume() and reset_resume(), they are called in different
> cases and you need to restart IO in both cases.
>=20
> Thanks.
>=20
> --=20
> Dmitry



Best regards
Marcus Folkesson

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlpjr5sACgkQiIBOb1ld
UjL59BAAqMCuvkN/859MnHkCrBHVPDq2uDjn5ACqIxhm79RXzqHSz+Cdc/GYYD7X
E3zF9tTmlmt3VQCq9wraqzydf5PcKg6N0iu+ICVgHGS5oCSR0gvMG9xqHGoHAlkZ
HGgrJZ1llKdbFNJRBYP0g8tZV3WZ27JG9GBbhB/jW1Tee4Bc0fXHMgGGMtxdrQaq
y3x+Jwf42BGYcy+J5kQ7tXHt7pAQKe3RDqJjDG5w+ymDGHW6/e2Drt2zm/OHrIkX
HEJvZsQbl1/G+cpZU03U78qxxy63wh3l4vIUD4SkVaQc+qZHM50CW8pqZwqqrkWY
IJnMOqU+IGTB9awkrxWzbF2xPpiGVYX3VLUItvP+fR72Sziy7xMiTFJ5COLrOat2
dwp7y2E4huQbVB0BFC4qSS2x4Cg1Eml3/qjhM7LCTHvgzlJ+2GcYyuq36zTqXyUc
PQpJh4H/zrMkgnXZ3U16J113Ed9d8yMayv06juvVZvvI06yoCEJks0KO6bLa521H
1VocBxh9c+bOn8ETnpmN7UmE2Gf51fKWXxDG27jZVCZe/XjTIoJKOZT6cmKF/7ke
rXP0uNiwax/G49npORUbqJfQ3homoQtIxyIwGPJ55v5Kr6CI7OXyqrT4ti6bEZcX
/0z3Pm5CTSQMXlzvUEcjTjS0229qVP913Qi4OlG+iaJBDIKJHuA=
=Kd7M
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--
