From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: lockdep report at resume
Date: Wed, 11 Feb 2009 15:33:22 +0100
Message-ID: <1234362802.4016.4.camel@johannes.local>
References: <1234022517.4175.107.camel@johannes.local>
	 <alpine.LRH.1.10.0902111246040.22097@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-nJ/wbU880bup7Pj3oNiv"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:36753 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559AbZBKOeA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Feb 2009 09:34:00 -0500
In-Reply-To: <alpine.LRH.1.10.0902111246040.22097@twin.jikos.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>


--=-nJ/wbU880bup7Pj3oNiv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-02-11 at 13:03 +0100, Jiri Kosina wrote:

> > [20920.459736] events/0/9 is trying to acquire lock:
> > [20920.459951]  (&dev->mutex){--..}, at: [<ffffffff804be0ac>] input_dis=
connect_device+0x2c/0xf0
> > [20920.460369]=20
> > [20920.460370] but task is already holding lock:
> > [20920.460637]  (&usbhid->reset_work){--..}, at: [<ffffffff8025a933>] r=
un_workqueue+0xb3/0x250
> > [20920.461049]=20
> > [20920.461050] which lock already depends on the new lock.
> > [20920.461051]=20
> > [20920.461425]=20
> > [20920.461425] the existing dependency chain (in reverse order) is:
> > [20920.461767]=20
> > [20920.461767] -> #4 (&usbhid->reset_work){--..}:
> > [20920.464572]=20
> > [20920.464572] -> #3 (events){--..}:
> > [20920.468134]=20
> > [20920.468134] -> #2 (cpu_add_remove_lock){--..}:
> > [20920.468134]=20
> > [20920.468134] -> #1 (polldev_mutex){--..}:
> > [20920.468134]=20
> > [20920.468134] -> #0 (&dev->mutex){--..}:

> OK, so we are calling usb_reset_device() from hid_reset() workqueue. You=20
> have a composite device, mouse interface being handled by bcm5974 driver,=
=20
> and keyboard interface being handled by usbhid driver.

Right.

> bcm5974 driver doesn't have _pre_reset() and _post_reset() callbacks, so=20
> full unbind/bind cycle is performed by USB core. bcm5974_disconnect()=20
> calls input_unregister_device(), which creates reset_work ->=20
> input_dev->mutex dependency.

Yup

> Unfortunately I don't seem to see from the lockdep dumps where does the=20
> input_dev->mutex -> reset_work dependency come from, am I just completely=
=20
> blind?

Well, there's the entire chain of dependencies, so it's via polldev, and
polldev depends on cpu_add_remove_lock, etc. So it's across a whole lot
of different subsystems... the dependency is quite complex here! There's
probably no direct dependency of input_dev->mutex -> reset_work, but
reset_work is on the global workqueue ("events") which has the
dependency via some _other_ work that some _other_ subsystem is also
giving to schedule_work()!

> I will look into this.

Thanks.

johannes

--=-nJ/wbU880bup7Pj3oNiv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJkuGvAAoJEKVg1VMiehFYVp0QAKpHy1fhZzV6uGKaXr0hn2hC
x7bdu9OBSiD9w8aUUTuI1Eh27DP7DjnKr9NYfRb/oQmDq0Sk+mtGrADv2tD6boAS
tJ3eGIhQRI/1sVBSi6Rbuh28SATU7w7Gfl3uUwmuqqWnOPTfAOeqKzw1k/5W2oYS
bTvKFQQ00e+teJ16BuS0Lml9FvTu5LnUJhvvCF3SPqCRvdZo9uqxMw6X8W0xLB5H
rFeKV+Z7eh/Nmf+M+1r7e0hibk1LIjO7zHQ0fnHQjRRd+tL+PJ55fVG7D7EcnDLk
Ijd8aaRkpIZYPfdymsm6bvoDInrUJ+Wpsfs2xSxxXjpnY7TQAiGW32w2D0tzvq6a
iSvkeUE73VlIgIsV2zAU6pL8VjBNuzdhvZ7yLXpuA8IipGAhcycoDP4fcQ634j9G
3HailehEliv2gWa61RPMn/0VB5t0J/4EeFysSD2Ozl7jOD/gfqqjo5TlVmf7rdKO
pGUhl0lt4G7WhCIYngARFUblsJpOQ+OLwvf3siuxSiP3+jMUKaEVlZCn61L/qK/6
T0LYUAbVJR5M+1Q1MZ7Am4QNSQ3fuNq0WJtkBj9QiNa5Fa/Ux7o3gkP7c4kPZhC/
e58tIxIftfszAItLbw93ZPQryi5Y9DxEThTpCNYtj8TRBKKfA29kmlb7VdpmXOFL
NXSHlV4kM+b6O9jkML5l
=zNLf
-----END PGP SIGNATURE-----

--=-nJ/wbU880bup7Pj3oNiv--

