From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Input driver for Twinhan USB 6253:0100 remote control
Date: Sun, 12 Jul 2009 20:41:59 -0700
Message-ID: <20090713034159.GA10819@dtor-d630.eng.vmware.com>
References: <20090408072935.GA27920@dtor-d630.eng.vmware.com> <200904131931.24009.dmitry.torokhov@gmail.com> <49E4B678.9030508@rtr.ca> <200904140945.14652.dmitry.torokhov@gmail.com> <49E4C9CF.5060504@rtr.ca> <alpine.LNX.2.00.0904151022170.13028@wotan.suse.de> <49E5EAD7.7000309@rtr.ca> <alpine.LNX.2.00.0904161123180.13028@wotan.suse.de> <20090712182026.7a09c736@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752962AbZGMDmK@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090712182026.7a09c736@neptune.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Mark Lord <lkml@rtr.ca>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, Jul 12, 2009 at 06:20:26PM +0200, Bruno Pr=E9mont wrote:
> On Thu, 16 April 2009 Jiri Kosina <jkosina@suse.cz> wrote:
> > On Wed, 15 Apr 2009, Mark Lord wrote:
> > > > Yes, hid-belking is a good example of trivial driver that sits =
on
> > > > a HID bus for you, as it utilizes the ->input_mapping() callbac=
k,
> > > > which is probably the only callback from HID core you'd need.
> > > Actually, the input-mapping() alone won't do the job here.
> > > This Twinhan remote control sends single-byte codes for most
> > > buttons, but some buttons send multi-byte codes, and we have to
> > > discard the extraneous bytes somehow.
> >=20
> > If the usages make it through the generic HID layer (depends on the
> > report descriptor of the device), then just registering hid_driver
> > with ->event() set to your callback and fixing this on the fly coul=
d
> > be enough.
>=20
> I do have such a remote around.
>=20
> I wrote the below patch to adjust it's key mappings, though I'm not
> sure if/how I should deal with the number keys (0..9) with regard to
> keyboard layout and/or numlock key.
>=20
> I tried with KEY_0..KEY_9 (default) as well as KEY_KP0..KEY_KP9 but
> neither produces optimal results on my machine (laptop with numlock
> disabled and belgian keyboard layout, e.g. KEY_1 =3D> '&' unless shif=
t
> is down)
> i

That was the reason KEY_NUMERIC_* keycodes were intriduced - they
shuppsed to be unaffected by labuguage keymap or numlock state.

> KEY_NUMERIC_0..KEY_NUMERIC_9 are not recognized by Linux console (don=
't
> know if/how userspace understands them)
>=20

They just probably missing from the installed keymap, that's all.

--=20
Dmitry
