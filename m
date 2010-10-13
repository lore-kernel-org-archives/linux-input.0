From: "Joey Lee" <jlee@novell.com>
Subject: Re: Proposal for synaptics driver
Date: Tue, 12 Oct 2010 21:16:11 -0600
Message-ID: <4CB5BF2B0200002300021BC2@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: chase.douglas@canonical.com
Cc: rydberg@bitmath.org, chris@cnpbagwell.com, dmitry.torokhov@gmail.com, Michael Chang <MChang@novell.com>, tiwai@suse.de, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, peter.hutterer@who-t.net

Add CC. Michael Chang

=E6=96=BC =E4=BA=8C=EF=BC=8C2010-10-12 =E6=96=BC 16:11 -0400=EF=BC=8CCh=
ase Douglas =E6=8F=90=E5=88=B0=EF=BC=9A
> On Tue, 2010-10-12 at 13:41 -0500, Chris Bagwell wrote:
> > On Tue, Oct 12, 2010 at 11:23 AM, Chase Douglas
> > <chase.douglas@canonical.com> wrote:
> > > Hi all,
> > >
> > > There's been many patches and discussions on the synaptics MT wor=
k, so I
> > > wanted to gather thoughts into one thread to push things forward.
> > >
> > > First, I want to note something that I think has been overlooked.=
 We've
> > > been talking about "ClickPad" devices quite a bit. One can find t=
he
> > > product page for these devices at:
> > >
> > > http://www.synaptics.com/solutions/products/clickpad
> > >
> > > As a brief overview, ClickPads are an MT surface where the entire
> > > surface clicks. The click may be uniform over the touchpad, or it=
 may be
> > > hinged on one of the edges. It appears that Takashi has figured o=
ut the
> > > appropriate bits in the extended capabilities flags to recognized=
 a
> > > ClickPad. I can't confirm this, but it sounds like the device emi=
ts a
> > > middle mouse button click when the touchpad is depressed.
> > >
> > > Here's the confusing part: Synaptics has a different series of to=
uchpads
> > > where only certain regions of the touchpad click. This is the cas=
e on my
> > > Dell Mini 1012. Unfortunately, I can't find any documentation for=
 these
> > > touchpads on Synaptics' website. As another brief overview, my to=
uchpad
> > > has two buttons integrated into the bottom ~20% of the touchpad. =
The
> > > left half of the button area clicks separately from the right hal=
f, and
> > > the device emits left and right buttons as appropriate. The rest =
of the
> > > touchpad is stationary and does not click. If no one has a better=
 name
> > > for these touchpads, I'll refer to them as "integrated buttons"
> > > touchpads. Also unfortunately, I don't know which cap bits inform=
 us of
> > > an integrated buttons touchpad, though I have suspicions it's bit
> > > 0x200000 of the 0c extended caps mask.
> >=20
> > Ahh, that clears some things up to me.  Based on Takashi's
> > xf86-input-synaptic patches, it seems the click area is still in th=
is
> > ~20% range even for clickpads.
>=20
> Hmm, based on the synaptics product page I figured the click area of =
a
> ClickPad would be the entire surface. Takashi, do you have any input
> here? Maybe the ClickPad devices people have been using is of the hin=
ged
> type, where it's easier to click on the bottom of the pad instead of =
the
> top?
>=20
> > It sounds like the main difference
> > between clickpad's and "integrated button" touchpads is clickpads h=
ave
> > a way of reporting X/Y events in that click area *without* declarin=
g
> > button press.
>=20
> On my touchpad, the "embedded buttons" (what I'm calling "integrated
> buttons" now due to the name clash with the bcm5974 semantics) are to=
uch
> sensitive, so the device still reports X/Y events no matter whether t=
he
> button is depressed or not..
>=20
> > If one really wanted to, this same clickpad behavior
> > could be emulated based on pressure but thats probably best for
> > userspace.  BTW, is there any pressure thresholds for your touchpad=
?
>=20
> What do you mean by pressure thresholds? My device does report pressu=
re.
>=20
> > > Now onto implementation decisions. I feel that a kernel driver sh=
ould
> > > provide a usable mouse without needing an X input module. There a=
re
> > > projects like Wayland that don't use X, and I think people use gp=
m for
> > > consoles still. My definition of a usable mouse is single touch a=
nd left
> > > click support (including click and drag using a physical button).
> > >
> > > To answer another recurring question throughout the thread, other=
 MT
> > > drivers send both ABS_MT_* and regular ABS_* events. One of the M=
T
> > > touches is assigned for single touch emulation at any given time.=
 This
> > > supports legacy user space software that expects ST events while
> > > allowing for MT events to be used by more advanced software. I th=
ink we
> > > should do the sam> > > touch as Henrik suggested.
> >=20
> > I haven't had time to review the code Henrik pointed to and don't
> > think exact behavior was spelled out in thread.  Since it applies t=
o
> > my touchpad's, I'd like to state it briefly so we know how this rul=
e
> > will be bent in later part of email.
> >=20
> > I believe basic intent is to support ST emulation by continuing to
> > report the same touch for life of touch and if its released first t=
he
> > emulation will revert to remaining tracked touch and advertise this
> > transition using BTN_TOOL_DOUBLETAP going from 1->0.
>=20
> The way I implemented this in the hid-magicmouse driver for the Magic
> Trackpad is that the first finger touching the surface is the only ST
> emulated touch until all fingers are lifted off the device
> simultaneously. The following events illustrate the pattern:
>=20
> 1. First finger goes down, gets ST emulation
> 2. Second finger goes down
> 3. First finger goes up, no ST emulation
> 4. Third finger does down, still no ST emulation
> 5. All fingers go up
> 6. First finger goes down, gets ST emulation
> etc.
>=20
> I think this would work fine here as well, except for the scenario wh=
ere
> two fingers start in the non-button area, and one moves to a button a=
rea
> and presses. The second finger would not control ST emulation, so no
> drags would be performed. I don't see this as an often seen scenario
> though.
>=20
> More likely, a user would start with one finger over the button and t=
he
> other in the non-button area. No matter which order of touch is
> performed, the above algorithm would work fine because the touch over
> the button area isn't figured into the ST emulation.
>=20
> As for multifinger support (BTN_TOOL_DOUBLETAP, etc.), I was thinking
> that should be based on all touches whether they occur over a button
> area or not. However, if anyone has a convincing argument against thi=
s
> I'm happy to reconsider :).
>=20
> BTW, ST emulation algorithms haven't been standardized. Some drivers =
can
> begin ST emulation on new touches while other touches are still prese=
nt.
>=20
> > > For ClickPad devices, my feeling is that we should translate midd=
le
> > > button clicks to left button clicks in the kernel, and MT+ST emul=
ation
> > > should be performed. Middle and right click functionality may be
> > > provided for in userspace, like in xf86-input-synaptics or throug=
h a
> > > gesture stack. I think this level of support meets my personal cr=
iteria
> > > for kernel level functionality specified above.
> >=20
> > Agree.  I would consider click and drag as optional with ST emulati=
on
> > but hopefully we can get it working with some thought.
>=20
> What's the issue with ClickPad click and drag? I was thinking it shou=
ld
> just work. The user touches the pad with one finger, depressing the
> ClickPad button. Now the left button depress event is emitted, and th=
e
> user drags the finger.
>=20
> > > Integrated buttons devices pose more of a challenge due to the ne=
ed to
> > > properly support click and drag. Lets first assume that we can de=
tect
> > > such a touchpad and determine the button area (I'll revisit this =
later).
> > > I think we should disable single touch support over the buttons d=
ue to
> > > the following scenario:
> > >
> > > User positions cursor over button on screen, attempts to click ph=
ysical
> > > touchpad button, cursor moves because of motion on touchpad when =
user
> > > depresses button.
> >=20
> > I think for this exact scenario its probably not needed but your in
> > best position to say.  I can do a button press-like touch on my
> > touchpad today with no cursor movement though.
>=20
> Sadly I can't. I tried it for a few hours, but it just wasn't possibl=
e
> on my Dell Mini 1012 to click without moving while thinking about
> anything else at the same time :).
>=20
> > Here is a close version of filtering ST when in click area that may=
 or
> > may not be better option.  We could instead modify rule to track 1s=
t
> > touch to track 1st touch unless its in click area and then prefer
> > > Let me try to convince myself that we won't see cursor jumps in X=
=2E
> > 1st touch in click area:
> > BTN_LEFT=3D1/BTN_TOUCH=3D1/ABS_X=3D1st_finger/ABS_Y=3D1st_finger.  =
2nd touch
> > in drag area:  BTN_TOOL_DOUBLETAP=3D1/ABS_X=3D2nd_finger/ABS_Y=3D2n=
d_finger.
> >  Release 2nd finger:
> > BTN_TOOL_DOUBLETAP=3D0/ABS_X=3D1st_finger/ABS_Y=3D1st_finger.
> >=20
> > xf86-input-synaptics can handle those transitions without jumping.
> > Maybe not gpm or similar but should be small fixes to applications.
>=20
> I hadn't thought of using BTN_TOOL_* as barriers across which the ST
> emulated touch could change. I'm concerned about legacy applications,=
 as
> you noted, but if everyone feels this is a better resolution then I'm
> fine with it as well. I think it would allow for ST emulation across =
the
> entire touchpad surface of an "embedded buttons" device, until any
> buttons are depressed.
>=20
> As an alternative, we could generate a dummy sequence for the
> transition:
>=20
> First of two fingers goes to button area, then:
> BTN_TOUCH 0
> SYNC
> BTN_TOUCH 1
> ABS_X from second finger
> ABS_Y from second finger
> ABS_PRESSURE from second finger
> SYNC
>=20
> The wrinkle I can envision here is that a quick first finger move fro=
m
> the non-button area to the button area will look like a tap because t=
he
> BTN_TOUCH went down and up in a short period of time.
>=20
> > This approach should allow click and drag to work and also allow ST
> > only applications to convert BTN_LEFT into left/middle/right as lon=
g
> > as it knows its an "integrated button" or "clickpad" touchpad.
>=20
> "Embedded button" devices correctly report the appropriate button pre=
ss
> because they have physically distinct buttons. I think this is merely=
 an
> issue for ClickPads.
>=20
> > BTW, I think both mouse movement issue and click and drag issue
> > applies to clickpad as well and so can use same decisions for it.
>=20
> They might be. Once we play with it some we might find this to be the
> case.
>=20
> > > However, we should support MT over the entire touchpad surface. P=
erhaps
> > > proper filtering and such could make the above scenario work bett=
er, and
> > > an advanced user space software, like xf86-input-synaptics, could=
 listen
> > > to the MT events to get the data if it wants.
> > >
> > > Integrated buttons have ST emulation support, but only over the
> > > non-button area of the touchpad. If a touch moves over the button=
 area,
> > > it disappears as far as ST-only aware software is concerned. ST
> > > emulation does not switch to another touch because that would loo=
k like
> > > a dragged touch. Since a touch beginning over the button area is =
never
> > > sent through ST emulation, click and drag will always work no mat=
ter
> > > which touch goes down first.
> >=20
> > Do you know if hardware is doing any filtering?  For example, if yo=
u
> > move 1 finger from middle to click area does it do simple thing and
> > start reporting button press?  If it is filtering then that may cha=
nge
> > the story a little.
>=20
> I'm not sure I understand the question. On my laptop, it emits the
> appropriate button presses when the button is physically depressed. I=
t
> also emits X/Y values whether the button is depressed or not. I'm not
> sure what filtering you may be referring to.
>=20
> > I think both filtering approach and "prefer non-click touch" approa=
ch
> > allow click-and-drag.  If you do something like 2 finger touch in
> > center and move tracked finger into click area then it would need t=
o
> > start reporting other touch and turn into a click-and-drag operatio=
n.
> > This ST tracking switch shouldn't seem different to user space then
> > case of user releasing tracked finger and moving to click area I
> > think.  Since BTN_TOOL_DOUBLETAP will go from 1 to 0 in both these
> > cases, user space has something to understand tracking switch.
>=20
> I think we're in agreement on everything except for the possibility o=
f
> using BTN_TOOL_* to distinguish between ST emulation touch switches. =
The
> BTN_TOOL_* switch could allow full ST > an "embedded buttons" trackpa=
d until a button is pressed, but might
> slightly break legacy clients like gpm. Again, I'm open to both optio=
ns,
> so if anyone feels particularly strong about this please speak up :).
>=20
> Thanks for the feedback Chris!
>=20
> -- Chase
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
