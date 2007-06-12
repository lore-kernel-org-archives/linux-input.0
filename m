From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH] Input: Support for a less exclusive grab.
Date: Tue, 12 Jun 2007 01:07:13 -0400
Message-ID: <200706120107.13655.dtor@insightbb.com>
References: <20070609084800.GR6362@aehallh.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070609084800.GR6362@aehallh.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: "Zephaniah E. Hull" <warp@aehallh.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Zephaniah,

On Saturday 09 June 2007 04:48, Zephaniah E. Hull wrote:
> EVIOCGRAB is nice and very useful, however over time I've gotten
> multiple requests to make it possible for applications to get events
> straight from the event device while xf86-input-evdev is getting events
> from the same device.
>=20
> Here is the least invasive patch I could think of, it changes the
> behavior of EVIOCGRAB in some cases, specificly behavior is identical if
> the argument is 0 or 1, however if the argument is true and !=3D 1, then
> it does a 'non exclusive grab', a better name might be handy.
>=20
> What this does is allow the events to go to everything that's using
> evdev to get events, but grabs it from anything else. =C2=A0About as clos=
e to
> what people want as I can get, and fairly non-invasive.

Unfortunately this also robs non-legacy input handlers (such as
rfkill-input) of input events. Does xf86-input-evdev really needs to
grab devices exclusively? I guess we can't abandon the standard
keyboard driver until X supports hotplugging. How close is it to
support devices coming and going?
=20
If we can't remain as is until X hotplug is ready then I'd rather had
a separate ioctl that disables legacy input handlers (keyboard, mousedev)
for a given input device.

=2D-=20
Dmitry
