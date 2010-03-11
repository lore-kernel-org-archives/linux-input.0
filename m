From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH] hid-ntrig.c Multitouch cleanup and fix
Date: Thu, 11 Mar 2010 16:25:07 +1000
Message-ID: <20100311062507.GE6040@barra.bne.redhat.com>
References: <4B760D60.6020907@seas.upenn.edu>
 <alpine.LNX.2.00.1002161349470.30967@pobox.suse.cz>
 <4B96B740.7020208@euromail.se>
 <4B96BAF1.5070209@seas.upenn.edu>
 <alpine.LNX.2.00.1003092218530.17799@pobox.suse.cz>
 <5423752A-3AE0-4848-9149-B0C01B0BCA39@enac.fr>
 <4B96CAD4.4010407@euromail.se>
 <45cc95261003091442t70d08311u13642aac7bc4f3f3@mail.gmail.com>
 <20100311043034.GA30166@barra.bne.redhat.com>
 <45cc95261003102136h3f034c58nedffac6f7a27018b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:28409 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368Ab0CKG2R (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Mar 2010 01:28:17 -0500
Content-Disposition: inline
In-Reply-To: <45cc95261003102136h3f034c58nedffac6f7a27018b@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mohamed Ikbel Boulabiar <boulabiar@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, =?iso-8859-1?Q?St=E9phane?= Chatty <chatty@enac.fr>, Jiri Kosina <jkosina@suse.cz>, Rafi Rubin <rafi@seas.upenn.edu>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Thu, Mar 11, 2010 at 06:36:26AM +0100, Mohamed Ikbel Boulabiar wrote=
:
> On Thu, Mar 11, 2010 at 5:30 AM, Peter Hutterer <peter.hutterer@who-t=
=2Enet>
> wrote:
> > On Tue, Mar 09, 2010 at 11:42:34PM +0100, Mohamed Ikbel Boulabiar w=
rote:
> >> > A hierarchy is imposing an unnecessary restriction on the graph =
of
> >> > possible relations between point devices. Consider for instance =
the
> >> > case of two people, each with one finger on the panel. The hiera=
rchy
> >> > says panel-person1-finger1 and panel-person2-finger1. Now have t=
hem
> >> > move close enough for the fingers to touch.  The hierarchy now s=
ays
> >> > panel-person-(finger1, finger2). Symmetry breaking once more.
> >> >
> >> > The main point here is that however the data reaches userland, i=
t
> >> > will have to be processed intelligibly and collectively. The poi=
nt of
> >> > processing could be an MT X Driver, it could be some other input
> >> > section, but it is has to be done somewhere.
> >> >
> >> > Henrik
> >>
> >>
> >> The hierarchy applied on multitouch isn't the best example to prov=
e
> >> benefits of it.  Hierarchy is useful with some complex input devic=
es
> >> that have many axes, many buttons some accelerometers, but that ar=
e
> >> hierarchical from the source (integrality/separability ?).  Then
> >> providing them as hierarchy can be useful.
> >
> > Are we talking about real input devices here or a hypothetical devi=
ce?
> > If the former, what are examples for such an input device?
>=20
> What's the meaning of a hypothetical device ?  Please note that here =
I
> speak about former input as to be handled by the kernel.  If there is=
 more
> complex handling it can be treated outside and virtual device files a=
re
> created (to handle these hierarchical concepts).  To eliminate
> misunderstanding, virtual device files represent what St=E9phane firs=
t
> suggested as moving multitouch input (as reported from the kernel) to=
 2
> mouse-like input reporting files.

Ah, I think I remember now. The use-case here is something like having =
to
physical devices but the buttons of the second device are to be used as
buttons on the first device instead and it should all be transparent. R=
ight?
I think we exchanged emails about this once.

> > Don't forget that X' main functionality aside from displaying wobbl=
y
> > windows is to be an input multiplexer. If some additional managemen=
t
> > layer is needed, why should it be another layer on top of or below =
X
> > instead of a part of X itself?
>=20
>=20
> Ok, I know you represent now all the input handling in X.  So I shoul=
d
> have predicted such questions. :)
>=20
> The X evidence that it works as input multiplexer can't stay until th=
e end
> of time.  The number of projects emerging and that only use the Linux
> kernel without X aren't few.  Why I should have access to advanced
> multi-touch handling ONLY in X meaning I should install also all the
> package ?  Meaning in another software that should take care "mainly"=
 of
> graphics.
>=20
> I will here cite some things about the past and what's is being done =
now :
> The graphics handling itself, wasn't done before in X ? And now isn't
> everybody tried to pull it out of it and putting it in the Linux kern=
el ?
> KMS: Kernel Mode Setting ? Isn't now better to have such handling don=
e in
> kernel and have early access to graphics card without having the scre=
en
> flashing many times disturbing users ? Isn't the switching to VT now
> better ?
>=20
> It's true that when X was first designed, its main functionalities we=
re
> handling input&graphics in 'all' unix systems (which by case still
> remembers me Multics cause of failure...).  Now the world changed and=
 we
> should think about what system would be at least in the next 5 years.
>=20
> Many projects tried to replace X, from Framebuffer to Wayland without
> forgetting all other dead projects.  Why ? ;-)

The same argument is true for input of course. Since switching to evdev
we've removed the actual hardware handling into the kernel and don't do=
 much
hardware-dependent stuff in the driver anymore. That didn't change the =
role
of the server as input multiplexer though, this is a different role. Le=
t me
explain: A main role of the server is still to handle keyboard focus,
deliver events to the windows, handle multiple clients in a reasonably =
sane
manner, etc.  It's still the role of the server that if you move the mo=
use
and then the touchpad, the same cursor moves on the screen. This is wha=
t I
mean by input multiplexer, it converts abstracted hardware-events into
information that represent the use of this hardware in a graphical
interface.

So I don't worry at all about the kernel multitouch drivers because I k=
now
I'll only ever see the event API and that's a good thing. We need to
consider that X still needs to manage your focus and other things - unl=
ess
you want to route around it completely (obviously, cases where X isn't =
in
use at all are different, they don't worry my too much though :)

So if you have a managing layer that couples devices together in a dyna=
mic
manner, you need it below X (above X is _really_ hard). Which means the
clients that configure things need to talk to it in some way. If that w=
ay is
through X, then X needs to know about it somehow. Otherwise, you need s=
ome
configuration channel that goes around X. That aside, you still need th=
e
drivers and the server be able to reconfigure themselves when this laye=
r
modifies input devices.

It's easy enough to slot something in underneath, but you're likely to =
have
to have some additional stuff in the server anyway to manage it
appropriately. And what's "appropriate" is likely defined by some
application that has the context. And often enough, getting the context
without having access to the window hierarchy can be tricky.

> Please don't see this as an attack to X.org, but otherwise a differen=
t
> point of view.

no worries, I neither meant it as an attack on your approach nor felt y=
ou
were attacking X (not that I'd really care much about the latter, I've
worked with it for too long :).

> When I've proposed, I have said that it can't be in X "by obligation"=
=2E
> I have thoughts that is may be an additional layer, until many people
> decide to include it in the kernel if things become working great.
> This can help much embedded application that use FB or a display
> server but needs multi-touch and advanced input handling.
> Specially when comparing the number of people developing X, to those
> developing the Kernel.
> In other non-Linux systems, multi-touch is handled by a completely ne=
w
> input server.
>=20
> Anyway, forget all what I have said.
> How do you want to deal with multitouch and new input handling in X a=
nd why ?

I don't know yet. as it turns out, real multi-touch is tricky. so far n=
one
of the approaches we've come up with survived the scrutiny. We're still
trying to find approaches that work for the generic case though.

Unfortunately, sidestepping the server by adding another communication
channel to the input layer would suffer from the same issues we've foun=
d so
far - usually the killer was the lack of context without active client
interaction.

Cheers,
  Peter

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
