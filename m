From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: DaVinci Keypad Driver
Date: Wed, 23 Sep 2009 11:07:45 -0700
Message-ID: <20090923180745.GE13435@core.coreip.homeip.net>
References: <1253654850-11983-1-git-send-email-miguel.aguilar@ridgerun.com> <4ABA3638.5070609@ridgerun.com> <20090923163546.GA13435@core.coreip.homeip.net> <200909231051.05714.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f194.google.com ([209.85.216.194]:35632 "EHLO
	mail-px0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753555AbZIWSHu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Sep 2009 14:07:50 -0400
Received: by pxi32 with SMTP id 32so785220pxi.4
        for <linux-input@vger.kernel.org>; Wed, 23 Sep 2009 11:07:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200909231051.05714.david-b@pacbell.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Miguel Aguilar <miguel.aguilar@ridgerun.com>, nsnehaprabha@ti.com, davinci-linux-open-source@linux.davincidsp.com, linux-input@vger.kernel.org, todd.fischer@ridgerun.com, diego.dompe@ridgerun.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com, Greg KH <gregkh@suse.de>

On Wed, Sep 23, 2009 at 10:51:05AM -0700, David Brownell wrote:
> On Wednesday 23 September 2009, Dmitry Torokhov wrote:
> > >> __devexit?
> > > [MA] According to comments from David Brownell to the first versi=
on of=20
> > > this patch the __exit should be used.
> > >
> > > " - Use platform_driver_probe() and __exit/__exit_p();
> > > =A0 =A0there's no point in keeping that code around in
> > > =A0 =A0typical configs, it'd just waste memory. "
> >=20
> > I am afraid David is wrong here.
>=20
> No, you're just pointing out a bug introduced in some
> unrelated code.

=46rom the very version of the patch platform_driver_probe() only ensur=
ed
that probe() would not be called after module inialization is done, it
never made any guarantees about removing devices. Hmm, let's add Greg a=
s
well here.

>  Such bugs happen when folk ignore the
> code bloat issues.  (And didn't Linus recently point
> out how such code bloat is becoming an issue?)
>=20
>=20
> > Even when we register driver with=20
> > platform_driver_probe() we still have "unbind" attribute in sysfs w=
hich
> > may be used to unbind the device from driver. If code is __exit the=
n
> > such attempts will cause oops.
>=20
> That would be a bug in the unbind() code, which doesn't
> currently recognize that not every driver or bus supports
> hotplugging.  It should probably check for a null release()
> pointer in the driver, and politely fail in that case.
>=20

NULL release (as well as NULL probe) don't mean what you think they do.

> That's just about the only place that a third party
> (neither the driver nor its hotplug-aware bus framework)
> will try to decouple device and driver ... and it's doing
> it wrong.  So it's unlikely such bugs will be elsewhere.
>=20

No, it does exactly what it is supposed to do. You may argue that such
facility is not needed but this is different. I'd argue that sometimes
you do need to shut off a device even if it is not normally
hot-pluggrable. Plus most of the blat is coming from probe() functions,
remove()s are fairly small.

> It's *ALWAYS* been legit to have a NULL pointer in the
> remove() methods.

Which means "device does not need any special actions for unbinding",
not that device can not be unbound. The same with probe(): NULL does no=
t
mean that device can not be bound but rather that it does not need any
specal processing during binding.

>  That's why the __exit_p() -- or for
> hotpluggable drivers, __devexit_p() -- macros exist:
> for that particular case.

Huh? They are here so that the linker/module loader can discard them if
they only referenced via driver pointers and we know they not going to
be called.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
