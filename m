From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 8/9 v2] Input: add BTN_TOOL_QUINTTAP for reporting 5
 fingers on touchpad
Date: Tue, 26 Jul 2011 10:18:02 +0800
Message-ID: <CAGS+omCAUAgK6thEPqkp0iSFbnzonw0jH77XToptTwTUz5BH7w@mail.gmail.com>
References: <1311169146-20066-1-git-send-email-djkurtz@chromium.org>
 <1311169146-20066-9-git-send-email-djkurtz@chromium.org> <20110725082918.GC22937@core.coreip.homeip.net>
 <CAGS+omAQmb-q6xC-Gh6z69iNNyr=rN-Khsq90aCHJwe-6F9ANw@mail.gmail.com> <20110725181645.GA6876@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110725181645.GA6876@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: rydberg@euromail.se, chase.douglas@canonical.com, rubini@cvml.unipv.it, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, derek.foreman@collabora.co.uk, daniel.stone@collabora.co.uk, olofj@chromium.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry, et al,

On Tue, Jul 26, 2011 at 2:16 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Mon, Jul 25, 2011 at 05:14:22PM +0800, Daniel Kurtz wrote:
> > On Mon, Jul 25, 2011 at 4:29 PM, Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > >
> > > On Wed, Jul 20, 2011 at 09:39:05PM +0800, djkurtz@chromium.org wr=
ote:
> > > > From: Daniel Kurtz <djkurtz@chromium.org>
> > > >
> > >
> > > Do we know what we want to do with this gesture? Because if not I=
'd
> > > rather not merge it for now, until there are real users.
> >
> > And do what instead?
> > Report 5 fingers with BTN_TOOL_QUADTAP?
> >
>
> That, or nothing... The fact that the device can report 5 finger touc=
h
> does not mean that anybody cares about this.
> --
> Dmitry

The only current use of this is to detect "resting thumb + 4-finger-scr=
oll".
"4-finger scroll" is a gesture supported by some applications and
operating systems.
"resting thumb" is when a clickpad user rests a finger (typically a
thumb), in the bottom left "click zone" in anticipation of
click+move=3Dselect gestures.
Thus, this 4-finger scroll is actually sometimes a 5-finger gesture.

Similarly, I work with many touchpads from different vendors, some of
which do actually provide 5 independent finger coordinates.  The
drivers for these touchpads truly send 5 MT-B slots when 5 fingers are
present.

Should these drivers perform=A0input_mt_report_pointer_emulation()?
If so, should we add BTN_TOOL_QUINTTAP to allow them to report 5
fingers in emulation mode?
Or is that ridiculous, since emulation is only for old userspace
programs which wouldn't know what to do with QUINTTAP, anyway?

-Dan
