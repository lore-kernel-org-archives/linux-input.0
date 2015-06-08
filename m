From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 0/5] HID: wacom: Support tablets with pen and touch on
 same interface
Date: Mon, 8 Jun 2015 11:46:33 -0400
Message-ID: <20150608154633.GC18162@mail.corp.redhat.com>
References: <1433380697-28612-1-git-send-email-killertofu@gmail.com>
 <20150604141846.GB2495@mail.corp.redhat.com>
 <55708C28.5020705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32844 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752988AbbFHPqg (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 8 Jun 2015 11:46:36 -0400
Content-Disposition: inline
In-Reply-To: <55708C28.5020705@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Jason Gerecke <jason.gerecke@wacom.com>

On Jun 04 2015 or thereabouts, Jason Gerecke wrote:
> On 6/4/2015 7:18 AM, Benjamin Tissoires wrote:
> > Hi Jason,
> >=20
> > On Jun 03 2015 or thereabouts, Jason Gerecke wrote:
> >> I've recently got my hands on a device which has an I2C sensor tha=
t sends
> >> both pen and touch reports from a single interface. To userspace, =
it shows
> >> up as a single input device which blends both the report types (e.=
g. it has
> >> ABS_PRESSURE for the pen, and ABS_MT_POSITION_X for the touch). Th=
is patch
> >> set modifies the driver to be able to handle devices which place b=
oth pen
> >> and touch on a the same interface. It does this by treating the pe=
n, touch,
> >> and pad (which was already special-cased) independently. If a devi=
ce has
> >> the appropriate device_type, one or more of pen/touch/pad input de=
vices
> >> will be created, initialized, and used to send data to userspace.
> >>
> >> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> >=20
> > This all seems sensible. I gave a quick look yesterday and could no=
t
> > found any obvious problem, but I'd like to review it more thoroughl=
y
> > before giving my rev-by (and do a little bit of testing too).
> >=20
> > I don't believe there will be any problems for the series, besides =
the
> > Bamboo PAD. Have you tested on this?
> >=20
> > Cheers,
> > Benjamin
> >=20
>=20
> I don't have a Bamboo PAD to test with, but carefully looking at each
> interface's HID descriptor makes me think you may be right. The debug
> interface in particular uses a WACOM_VENDORDEFINED_PEN application
> collection and will be marked as WACOM_DEVICETYPE_PEN instead of
> WACOM_DEVICETYPE_TOUCH.

Just a quick update (and I'll review the series, I promise!).
The Bamboo PAD still works with this series. The only difference from
the current code is that now, we have an extra "pen" input node (unused=
)
attached to the touch interface (it was maybe what you were saying, but
it was not entirely clear for me, sorry :-P ).

>=20
> The smallest fix that should do the trick would be to just swap the
> device_type in 'wacom_setup_device_quirks'. Alternatively, we could o=
nly

Yeah. That is pretty much what we currently have for handling the PAD.
When the parsing has been made, I just revert the tool.

> allow the debug interface to be probed, set the touch device type fla=
g
> (in addition to the automatically-set pen flag), and extend the IRQ
> function to explicitly handle pen events. The alternative is a bit mo=
re
> work (and we'd need somebody with a device to test it...) but I think
> might make the codepath for the Bamboo PAD a bit easier to follow.

It might be easier to follow, but that would mean to implement a n-th
protocol, while the descriptor already gives us the protocol. So not
sure what is simpler here.

Cheers,
Benjamin

>=20
> --=20
> Jason
> ---
> Now instead of four in the eights place /
> you=E2=80=99ve got three, =E2=80=98Cause you added one /
> (That is to say, eight) to the two, /
> But you can=E2=80=99t take seven from three, /
> So you look at the sixty-fours....
>=20
> >>
> >> Jason Gerecke (5):
> >>   HID: wacom: Simplify 'wacom_update_name'
> >>   HID: wacom: Treat features->device_type values as flags
> >>   HID: wacom: Introduce a new WACOM_DEVICETYPE_PAD device_type
> >>   HID: wacom: Split apart 'wacom_setup_pentouch_input_capabilites'
> >>   HID: wacom: Introduce new 'touch_input' device
> >>
> >>  drivers/hid/wacom.h     |   4 +-
> >>  drivers/hid/wacom_sys.c | 194 +++++++++++++++----------
> >>  drivers/hid/wacom_wac.c | 379 ++++++++++++++++++++++++++---------=
-------------
> >>  drivers/hid/wacom_wac.h |  15 +-
> >>  4 files changed, 332 insertions(+), 260 deletions(-)
> >>
> >> --=20
> >> 2.4.1
> >>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
