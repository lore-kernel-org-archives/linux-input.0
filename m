From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH] Input: Support for a less exclusive grab.
Date: Tue, 12 Jun 2007 01:19:59 -0400
Message-ID: <200706120120.00494.dtor@insightbb.com>
References: <20070609084800.GR6362@aehallh.com> <200706120107.13655.dtor@insightbb.com> <20070612051210.GW6362@aehallh.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070612051210.GW6362@aehallh.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: "Zephaniah E. Hull" <warp@aehallh.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tuesday 12 June 2007 01:12, Zephaniah E. Hull wrote:
> On Tue, Jun 12, 2007 at 01:07:13AM -0400, Dmitry Torokhov wrote:
> > Hi Zephaniah,
> >=20
> > On Saturday 09 June 2007 04:48, Zephaniah E. Hull wrote:
> > > EVIOCGRAB is nice and very useful, however over time I've gotten
> > > multiple requests to make it possible for applications to get events
> > > straight from the event device while xf86-input-evdev is getting even=
ts
> > > from the same device.
> > >=20
> > > Here is the least invasive patch I could think of, it changes the
> > > behavior of EVIOCGRAB in some cases, specificly behavior is identical=
 if
> > > the argument is 0 or 1, however if the argument is true and !=3D 1, t=
hen
> > > it does a 'non exclusive grab', a better name might be handy.
> > >=20
> > > What this does is allow the events to go to everything that's using
> > > evdev to get events, but grabs it from anything else. =C2=A0About as =
close to
> > > what people want as I can get, and fairly non-invasive.
> >=20
> > Unfortunately this also robs non-legacy input handlers (such as
> > rfkill-input) of input events. Does xf86-input-evdev really needs to
> > grab devices exclusively? I guess we can't abandon the standard
> > keyboard driver until X supports hotplugging. How close is it to
> > support devices coming and going?
>=20
> Er, to explain.
>=20
> The current EVIOCGRAB does an exclusive grab that prohibits rfkill-input
> and friends from working.
>=20

I understand that.

> As it is the only way to disable the legacy input handlers,
> xf86-input-evdev has been using it since we added it.
>

Like I said I would love if xf86-input-evdev did not grab the
device at all.
=20
> The patch is to let us cause only things that use /dev/input/event<n> to
> get events, thus, a non-exclusive grab.
>=20
> This basicly disables the legacy input handlers, and it's the least
> invasive patch I could think of.
>=20

But rfkill-input is not a legacy handler. My objection is that with your
solution you still will rob handlers such rfkill-input of events.

> Going for a separate ioctl would also work, but in some ways it would
> make supporting it more of a pain.
>=20
> I don't care _that_ much either way, as long as we can get a way to
> disable the legacy events while allowing other things to get the events
> too.
>=20
> Zephaniah E. Hull.
> > =20
> > If we can't remain as is until X hotplug is ready then I'd rather had
> > a separate ioctl that disables legacy input handlers (keyboard, mousede=
v)
> > for a given input device.
> >=20
> > --=20
> > Dmitry
> >=20
>=20

=2D-=20
Dmitry
