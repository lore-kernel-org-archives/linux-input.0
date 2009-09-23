From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/2] Input: DaVinci Keypad Driver
Date: Wed, 23 Sep 2009 12:29:07 -0700
Message-ID: <200909231229.07403.david-b@pacbell.net>
References: <1253654850-11983-1-git-send-email-miguel.aguilar@ridgerun.com> <200909231051.05714.david-b@pacbell.net> <20090923180745.GE13435@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:46992 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750769AbZIWTfo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Sep 2009 15:35:44 -0400
In-Reply-To: <20090923180745.GE13435@core.coreip.homeip.net>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Miguel Aguilar <miguel.aguilar@ridgerun.com>, nsnehaprabha@ti.com, davinci-linux-open-source@linux.davincidsp.com, linux-input@vger.kernel.org, todd.fischer@ridgerun.com, diego.dompe@ridgerun.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com, Greg KH <gregkh@suse.de>

On Wednesday 23 September 2009, Dmitry Torokhov wrote:
> On Wed, Sep 23, 2009 at 10:51:05AM -0700, David Brownell wrote:
> > On Wednesday 23 September 2009, Dmitry Torokhov wrote:
> > > >> __devexit?
> > > > [MA] According to comments from David Brownell to the first ver=
sion of=20
> > > > this patch the __exit should be used.
> > > >
> > > > " - Use platform_driver_probe() and __exit/__exit_p();
> > > > =A0 =A0there's no point in keeping that code around in
> > > > =A0 =A0typical configs, it'd just waste memory. "
> > >=20
> > > I am afraid David is wrong here.
> >=20
> > No, you're just pointing out a bug introduced in some
> > unrelated code.
>=20
> From the very version of the patch platform_driver_probe() only ensur=
ed
> that probe() would not be called after module inialization is done, i=
t
> never made any guarantees about removing devices. Hmm, let's add Greg=
 as
> well here.

I don't see your point.  If the driver doesn't support
any unbinding mechanism -- a remove() method, converse
of probe() -- then it can't safely be unbound.

And thus, if any code is presuming that *every* driver
can be unbound, it's wrong.

As I said:  bug in other code.

Looking at this a bit more, it seems like there will need
to be some "can this bus remove this driver" check, since
the struct device.remove method is now managed at the bus
level.  Easy enough to do instead of the null check that
I mentioned below.  Provide it for platform bus, and the
main potential trouble spots will be resolved.


> >  Such bugs happen when folk ignore the
> > code bloat issues.  (And didn't Linus recently point
> > out how such code bloat is becoming an issue?)

Though to be fair, it's *always* been an issue for anyone
working with embedded Linux systems.  And it's long been
a frustration that too few "mainline" developers didn't
accept such issues.

=20
> > > Even when we register driver with=20
> > > platform_driver_probe() we still have "unbind" attribute in sysfs=
 which
> > > may be used to unbind the device from driver. If code is __exit t=
hen
> > > such attempts will cause oops.
> >=20
> > That would be a bug in the unbind() code, which doesn't
> > currently recognize that not every driver or bus supports
> > hotplugging.  It should probably check for a null release()
> > pointer in the driver, and politely fail in that case.
> >=20
>=20
> NULL release (as well as NULL probe) don't mean what you think they d=
o.

I could say the same things about how you think, of course,
and probably with just as little accuracy.  Let's not be
needlessly confrontational.


> > That's just about the only place that a third party
> > (neither the driver nor its hotplug-aware bus framework)
> > will try to decouple device and driver ... and it's doing
> > it wrong.  So it's unlikely such bugs will be elsewhere.
> >=20
>=20
> No, it does exactly what it is supposed to do. You may argue that suc=
h
> facility is not needed but this is different. I'd argue that sometime=
s
> you do need to shut off a device even if it is not normally
> hot-pluggrable.=20

Erm, once a driver is freely poking around in the hardware,
and is managing IRQs and other asynch events ... exactly
how do you expect to decouple it from the hardware without
a remove()?  Drivers that *don't* respond asynchronously to
hardware events are an extreme minority; it's not worth
even considering them as the design center.

As a policy choice, there's only one sane one:  unbinding
the driver always requires an active ack from the driver.

Even if that's a trivial/NOP remove() function ... instead
of one which cleanly tears down the hardware event stream;
the driver's handling thereof; and whatever resources the
driver claimed, including links to upper level code in the
operating system (like char/block device nodes and many
other things).


> Plus most of the blat is coming from probe() functions,=20
> remove()s are fairly small.

Not always.  Of course, there's still that nasty issue
with code that probe() and remove() need to share ... for
now there's no clean way to have such code be removable.
(Like an "__init_or_exit" section annotation.)  Drivers
have been stuck putting such code in the .text segement,
and thus causing additional driver bloat.


> > It's *ALWAYS* been legit to have a NULL pointer in the
> > remove() methods.
>=20
> Which means "device does not need any special actions for unbinding",
> not that device can not be unbound. The same with probe(): NULL does =
not
> mean that device can not be bound but rather that it does not need an=
y
> specal processing during binding.

I don't know where such a model comes from.  I'll just
say that in quite a few years of driver development I
have *never* come across hardware where "doesn't need
any attention during driver unbind" makes sense.

Recall that any driver has both lower (to hardware) and
upper (to rest of OS) links, and maybe more (to other
drivers) ... and it's a design goal in Linux to have such
links be explicit, so the drivers are more reusable.  So
requiring some hook -- remove() -- before attempting
to break the links internal to the driver model seems
like a fairly obvious requirement.


> >  That's why the __exit_p() -- or for
> > hotpluggable drivers, __devexit_p() -- macros exist:
> > for that particular case.
>=20
> Huh? They are here so that the linker/module loader can discard them =
if
> they only referenced via driver pointers and we know they not going t=
o
> be called.

=46inish that thought.  What "exit" section code fits those
categories?  Driver remove() methods ... and not much else.
And for that matter, what else goes into exit sections,
other than such code and module hooks to call it?

That discarding of exit sections has been around in Linux
for an extremely long time, at least on architectures which
lean more towards embedded systems than bloat-is-OK servers.
It's applied to driver remove methods, and to the code which
invokes them via rmmod.

Note that your comments all seem to presume that such
discarding is either useless or should be phased out for
some reason ... but you're not quite making *that*
argument.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
