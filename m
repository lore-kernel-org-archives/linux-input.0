From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [RFC v2 03/10] hid-multitouch: support for PixCir-based panels
Date: Fri, 7 Jan 2011 13:23:38 +0100
Message-ID: <20110107122338.GB2312@polaris.bitmath.org>
References: <1294248468-19979-1-git-send-email-benjamin.tissoires@enac.fr>
 <1294248468-19979-4-git-send-email-benjamin.tissoires@enac.fr>
 <20110106172528.GD1790@polaris.bitmath.org>
 <AANLkTimhk80b+jkqsNrxmFzSgmHX=_wdzbwE09NoFgV1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTimhk80b+jkqsNrxmFzSgmHX=_wdzbwE09NoFgV1@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Cc: Stephane Chatty <chatty@enac.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

> > Please provide a bit more information under this config option. The
> > usual "what should I do", and roughly what devices are supported.
>=20
> Will try, but don't hesitate to send one if you feel in a good mood f=
or writing.
>=20
> I can propose:
>=20
> +        ---help---
> +          Generic support for HID multitouch panels.
> +          Currently supported panels are:
> +          - PixCir touchscreen
> +          - Cypress TrueTouch
> +          - 'Sensing Win7-TwoFinger' panel by GeneralTouch

This is fine, but needs the "to compile as a module" etc, examples are
all around the Kconfig file.

> >> +struct mt_slot {
> >> + =A0 =A0 __s32 x, y, p;
> >> + =A0 =A0 __s32 contactid; =A0 =A0 =A0 =A0/* the device ContactID =
assigned to this slot */
> >> + =A0 =A0 __u16 trkid; =A0 =A0/* the tracking ID that was assigned=
 to this slot */
> >> + =A0 =A0 bool valid; =A0 =A0 /* did we just get valid contact dat=
a for this slot? */
> >> + =A0 =A0 bool prev_valid;/* was this slot previously valid/active=
? */
> >> +};
> >
> > The trkid and prev_valid are no longer needed. The touch state seem=
s to be missing.
>=20
> Concerning the trkid, agree.
> I can assure you that prev_valid is needed by at least the Cypress
> device. In a sense, it has the same problem than mt protocol A: it
> does not send the release information except when the last finger has
> been released. This gymnastic is thus required.

Perhaps I did not explain properly. What is needed is a way to clear
the touch state of the active slots not yet seen in a touch
frame. Because of the mixup of semantics around "valid" and "touch",
it looks more complicated than it really is. My point is that the
previous frame has nothing to do with it.

>=20
> I think that the misunderstanding comes from the name. We have this 2
> flags (valid and prev_valid) to tell whether the device sent data
> during this report or the previous one. It's not the same meaning tha=
t
> the touch you're talking about. For Cypress device, those 2 flags are
> mandatory.

The names are indeed confusing. A valid packet means the incoming
packet contains information about a slot, and brings updates to the
touch state and the touch properties. The touch state just needs to be
set, it is the same logic everytime.

>=20
> Maybe introducing data + prev_data + touch (3 flags instead of 2->
> touch can go into mt_buffer, and data and prev_data only in mt_slot a=
s
> they are not given by the device) is clearer.

This would be unnecessarily complicated. Either (touch_state,
seen_in_this_frame), or (touch_state,
last_frame_revision_of_this_slot) would be enough.

>=20
> >
> >> +
> >> +struct mt_buffer {
> >> + =A0 =A0 __s32 x, y, p;
> >> + =A0 =A0 __s32 contactid; =A0 =A0 =A0 =A0/* the device ContactID =
assigned to this slot */
> >> +};
> >
> > The only different to mt_slot are the valid and touch field, which =
is
> > also needed for incoming data. I'd say those should be merged.
> >
>=20
> Well, the point is that the buffer and the slot have 2 different mean=
ings:
> one is the incoming data, the other is the processed data. It strikes
> us to have only one struct as the slot contains extra information for
> it to be processed.

This is not true. The data that comes via a valid packet is the touch
state and the property updates, the rest is about handling the
validity. But let's say you use (touch, revision, props), for
instance.  The incoming valid packet would update curdata.touch and
curdata.props. When the slot is finished, curdata is copied to the
right place. At the end of the frame, a device with the
slots-not-send-in-this-frame-are-considered-unused quirk would reset
the touch of the slots with slot[i].revision !=3D
curdata.revision. Finally, curdata.revision would be incremented.

> >
> >> + =A0 =A0 __s8 inputmode; =A0 =A0 =A0 =A0 /* InputMode HID feature=
, -1 if non-existent */
> >> + =A0 =A0 __u8 num_received; =A0 =A0 =A0/* how many contacts we re=
ceived */
> >> + =A0 =A0 __u8 maxcontact; =A0 =A0 =A0 =A0/* expected last contact=
 index */
> >> + =A0 =A0 bool curvalid; =A0 =A0 =A0 =A0 =A0/* is the current cont=
act valid? */
> >
> > This value should probably be a mt_slot struct as well.
>=20
> I was bothering too. Renaming the field (see above) may solve the
> problem: we have curvalid (or curdata with the name I propose) which
> is only needed for algorithm reasons, and touch that goes into
> mt_buffer as it comes from the device.

Looking again, it seems to me that curvalid should really be where it
is now.

> >
> >> + =A0 =A0 struct mt_slot slots[0]; =A0 =A0 =A0 =A0/* first slot */
> >> +};
> >> +
> >> +struct mt_class {
> >> + =A0 =A0 int (*compute_slot)(struct mt_device *);
> >> + =A0 =A0 __u8 maxcontacts;
> >> +};
> >
> > I imagine maxcontacts could be variable for devices within the same
> > class. Perhaps it should be a member of the device instead? The
> > resolution and fuzz could be added here as well.
>=20
> resolution and fuzz: I let you implement it (when adding egalax or
> 3m). But isn't it something we can't get from the report descriptors?

Resolution, yes, but defaults might still be needed. And maybe
compute_slot should be a bitmask of quirks instead. So far we would
have MT_QUIRK_SLOT_IS_CONTACTID and MT_QUIRK_NOT_SEEN_MEANS_UP.

> concerning the device vs. class, currently, we have only seen classes
> (one or more device sharing the same behavior), but we didn't bother
> about resolution and fuzz.
> It would be a shame to have to duplicate the mt_class (or mt_device),
> one by vendorID/deviceID, as many devices may share the same
> properties (at least those that have been manufactured by the same
> company and that behave the same way: cando, stantum, etc...).
> I also like the concept of default class as it will help people easil=
y
> adding devices.

The statement comes from observing what seems to happen over time with
device lists, but sure, it won't really hurt to have the classes.

> >
> >> +
> >> +/* classes of device behavior */
> >> +#define MT_CLS_DEFAULT 0
> >> +#define MT_CLS_DUAL1 1
> >> +
> >> +/*
> >> + * these device-dependent functions determine what slot correspon=
ds
> >> + * to a valid contact that was just read.
> >> + */
> >> +
> >> +static int slot_is_contactid(struct mt_device *td)
> >> +{
> >> + =A0 =A0 return td->curdata.contactid;
> >> +}
> >> +
> >> +static int find_slot_from_contactid(struct mt_device *td)
> >> +{
> >> + =A0 =A0 int i;
> >> + =A0 =A0 for (i =3D 0; i < td->mtclass->maxcontacts; ++i) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (td->slots[i].prev_valid &&
> >
> > Why prev_valid? Ought to be valid, right?
>=20
> Because the code resets valid after each sending -> implementation de=
pendent.

The prev_valid and valid are only different because prev_valid is used
with touch semantics, whereas valid is not and is reset at each frame
emission. Once we stop mixing fruits, it will all become clear and
simple.

> > Nice solution to the end-of-data issue. It would be good if the inp=
ut
> > setup was abstracted into a function like in hid-egalax, to simplif=
y
> > further additions.
>=20
> thanks.
> I was not very happy in making this abstraction for just one line of
> code. I thought you could do it when adding the additions.

Or you could do it right away - it will simplify the existing
patch, and make subsequent patches simpler as well.

> >
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt=
_init_slots(hi->input,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 td->mtclass->maxcontacts);
> >
> > Maxcontacts should probably take the hid description into account a=
s well.
>=20
> I don't understand your point here

Take 3M as an example. The controller supports up to 60 contacts, but
different devices may not be needing that many. Having a way to trim
the number of allocated slots to just the right size for the current
devices seems like a good idea.

> >
> > And ABS_PRESSURE.
>=20
> I thought that the mouse emulation was restricted to X and Y.

Look at the psmouse, wacom and generic MT emulation code for counter ex=
amples.

> > There are some hid drivers that need to setup fuzz in order to work
> > properly. We should either add it to hid core or use the same bypas=
s as
> > in hid-egalax and hid-3m-pct.
>=20
> Can I let you do this in further updates? (for the new devices and
> those I sent, this works out of the box)

Why not do it right away? It is quite simple, and mostly copy and
paste from those drivers.

> >> +/*
> >> + * this function is called when a whole packet has been received =
and processed,
> >> + * so that it can decide what to send to the input layer.
> >> + */
> >> +static void mt_emit_event(struct mt_device *td, struct input_dev =
*input)
> >> +{
> >> + =A0 =A0 int i;
> >> +
> >> + =A0 =A0 for (i =3D 0; i < td->mtclass->maxcontacts; ++i) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 struct mt_slot *s =3D &(td->slots[i]);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (!s->valid) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* this slot does not =
contain useful data,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* notify its closure =
if necessary
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (s->prev_valid) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt=
_slot(input, i);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt=
_report_slot_state(input,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 MT_TOOL_FINGER, false);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->prev_=
valid =3D false;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }

This code will have exactly the same result without the "if
(s->prev_valid)", since prev_valid is a copy of the last touch
state. The input core will filter away any duplicate calls. Thus, it
can all be replaced by

input_mt_slot(input, i);
input_mt_report_slot_state(input, MT_TOOL_FINGER, s->valid);

=46urther assuming that valid will change to touch, it is all starting
to look conceptually correct. We could then prepend this line

if ((device_quirks & MT_QUIRK_NOT_SEEN_MEANS_UP) && s->revision !=3D cu=
rdata.revision)
    s->state =3D false;

and we would have support for the devices you mention.

> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 }
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (!s->prev_valid)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->trkid =3D td->lasttrk=
id++;
> >
> > Most of the above can be removed.
>=20
> Cypress device does not sends touch information when a touch is
> released. This piece of code is required for devices that behave the
> same way.

See the above example.

> >
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 input_mt_slot(input, i);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 input_mt_report_slot_state(input, MT_TOO=
L_FINGER, true);
> >
> > "true" here should simply be slot->touch state.
> >
> >> + =A0 =A0 =A0 =A0 =A0 =A0 input_event(input, EV_ABS, ABS_MT_POSITI=
ON_X, s->x);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 input_event(input, EV_ABS, ABS_MT_POSITI=
ON_Y, s->y);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 input_event(input, EV_ABS, ABS_MT_PRESSU=
RE, s->p);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 s->prev_valid =3D true;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 s->valid =3D false;
> >
> > Invalidating the data of a tracked slots seems wrong. If the device
> > sends tracked data properly, no special consideration is needed - i=
t
> > will get cleared when appropriate. Other cases could be dealt with
> > separately.
>=20
> already discussed (pb in naming the fields I think)

The egalax driver has a different behavior, for instance.

> >> + =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_TIPSWITCH:
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->curvalid =3D value;
> >
> > Most drivers seem to use this as touch state.
>=20
> agree and that is how it is used in the current implementation. We
> really should change the name.

I believe the curvalid is fine, but it should be updated differently.
The INRANGE and CONFIDENCE fields seem to do that for some devices,
yet others rely on the contactcount. The TIPSWITCH field should rather
update curdata.touch.

> >> + =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_CONTACTCOUNT:
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* We must not overwri=
te the previous value (some
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* devices send one se=
quence splitted over several
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* messages)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (value)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->maxc=
ontact =3D value - 1;
> >
> > Is td->maxcontact ever reset? And why not num_expected or something
> > instead of maxcontact - odd semantics.
>=20
> maxcontact is not reset (not needed as it is sent in each report).
> Concerning the name, agree.

You are right, this will work, too.

Thanks,
Henrik
