From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 1/4] hid-multitouch: support for PixCir-based panels
Date: Thu, 14 Oct 2010 20:10:29 +0200
Message-ID: <4CB74795.4010602@euromail.se>
References: <20101013223035.9B86E9522A@smtp.lii-enac.fr> <4CB6CF79.9040107@euromail.se> <BA82E030-B041-4354-9715-02DF56510DA2@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:45431 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755480Ab0JNSKu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Oct 2010 14:10:50 -0400
In-Reply-To: <BA82E030-B041-4354-9715-02DF56510DA2@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>

On 10/14/2010 12:28 PM, St=E9phane Chatty wrote:

>=20
> Le 14 oct. 10 =E0 11:38, Henrik Rydberg a =E9crit :
>>>
>>> +    bool valid;    /* did we just get valid contact data for this =
slot? */
>>> +    bool prev_valid;/* was this slot previously valid/active? */
>>
>>
>> I do think these should be named "touch" or "prox" rather than "vali=
d". The
>> latter term is used in many drivers no represent "not null", and mix=
ing the
>> semantics with proximity is best avoided.
>>
>=20
> Actually, the mix of semantics exists because of the mismatch between=
 the
> (static) HID protocol and the (dynamic) data it transports. Most of t=
he time,
> TipSwitch=3D0 occurs when we get placeholder data: there is nothing t=
o report at
> all, but the message format imposes that something is sent. And somet=
imes
> (rarely), we get TipSwitch=3D0 because a finger has been released. We=
 are lucky
> that we can handle the two situations in the same way.


It seems to me an individual packet from the device is either valid or =
invalid,
and there are a couple of different mechanisms used so far; HID_DG_INRA=
NGE
and/or HID_DG_CONTACTCOUNT seem to care of all but one (cypress) which =
also uses
HID_DG_CONTACTID.

In each valid packet, there is a notion of touch/enable/press/proximity=
, and it
seems to be either true for all valid packets, or goverened by HID_DG_T=
IPSWITCH.

>=20
> See below for a discussion of how we can solve this.
>=20
>=20
>>> +    bool curvalid;         /* is the current contact valid? */
>>> +    __u16 curcontactid;     /* ContactID of the current contact */
>>> +    __u16 curx, cury, curp;    /* other attributes of the current =
contact */
>>
>>
>> Could be a struct mt_slot instead.
>=20
> Well, it's not *exactly* the same data. Especially if, as I'm beginni=
ng to
> understand thanks to one of your later comments, there is a differenc=
e in the
> semantics of 'valid' between slots and the current contact as read in=
 the HID
> message:
>  - my above discussion applies to the current contact
>  - and in slots, this information gets filtered to become actual prox=
imity
> information.


In the recent egalax driver submission, the data collected during a hid=
 report
round is actually exactly the same as the data stored per slot.

> This would give:
>  - curvalid in mt_data
>  - touch in mt_slot (and not prox, because prox will mean something e=
lse in
> devices that have hover detection)


I do think it is fruitful to formulate this as mt_data holding both cur=
valid and
the touch state of the current slot.

>>
>>> +};
>>> +
>>> +struct mt_class {
>>> +    int (*compute_slot)(struct mt_device *);
>>> +    __u8 maxcontacts;
>>> +    __s8 inputmode;    /* InputMode HID feature number, -1 if non-=
existent */
>>
>>
>> It would be nice to have additional information here, like signal-to=
-noise ratio.
>=20
> I thought you would say that. My answer was ready: I left it to you t=
o add it
> afterwards :-)


Ok, no problem :-)

>=20
>>>
>>> +/* contact data that only some devices report */
>>> +#define PRESSURE     (1 << 0)
>>> +#define SIZE        (1 << 1)
>>
>>
>> The names here are a bit too general, IMO.
>=20
> I thought so too, but was too lazy to imagine something else and deci=
ded that
> what the heck, these are private names. Any suggestion?


True, private, but how about a HID_ or MT_ prefix, or something like th=
at.


>>> +
>>> +/*
>>> + * these device-dependent functions determine what slot correspond=
s
>>> + * to a valid contact that was just read.
>>> + */
>>> +
>>> +static int slot_from_contactid(struct mt_device *td)
>>> +{
>>> +    return td->curcontactid;
>>> +}
>>
>>
>> I suppose this one is meant to loop over available slots for some
>> implementations.
>=20
> See the following patches for examples. So far, looping was not neces=
sary.


Right, those devices are yet to come. As suggested in another patch as =
well,
perhaps we can get by without actually using different function pointer=
s here. A
switch statement does weigh fairly light in lieu of the processing done=
 per hid
report. :-)

>>> +
>>> +struct mt_class mt_classes[] =3D {
>>> +    /* DUAL1 */        { slot_from_contactid, 2, -1 },
>>> +};
>>
>>
>> Off placement of comment.
>>>
>=20
> Please, please don't force me to add a useless field to the struct so=
 as to make
> sure that the type is read before the data :-) Oh well...


I really don't care how the comments are placed, but somebody else migh=
t.
Standard is your friend. ;-)


>> A helper function that simplifies the repeated usage of input_set_ab=
s_params()
>> would be nice.
>>
>> A local variable for hi->input would be nice.
>>
>> If we want to support fuzz, and do not want to add it to the hid str=
ucture
>> (because it is not available in the reports), we should consider set=
ting up the
>> input_dev completely within this driver, as done in the 3M and egala=
x drivers.
>=20
> Yes, my idea was that you'd like to take over and introduce the kind =
of work you
> are doing for 3M and eGalax. As for the helper function and hi->input=
, hey, I
> just copied your code :-)


=46ine with me, although since we are introducing a new driver, it seem=
s slightly
backwards. Perhaps we can fold some patches jointly in the next round? =
And yes,
guilty, apparently my preferences regarding these drivers is changing w=
ith time,
too. :-)

>>> +        if (slotnum >=3D 0 && slotnum <=3D td->mtclass->maxcontact=
s - 1) {
>>
>>
>> The returned slotnum should always be valid, so this test is redunda=
nt.
>=20
> Nope. See Cypress devices.


I believe we have covered this in a separate thread now.


>>
>>> +            slot =3D td->slots + slotnum;
>>> +
>>> +            slot->valid =3D true;
>>
>>
>> Rather that setting valid here, it should simply be the proximity (t=
ouch) state.
>> All slot data in our buffer is actually valid at all times.
>>
>>> +            slot->x =3D td->curx;
>>> +            slot->y =3D td->cury;
>>> +            slot->p =3D td->curp;
>>
>>
>> Using a temporary slot struct for curx etc would be nice.
>>
>>> +        }
>>> +    }
>>> +    td->curcontact++;
>=20
> See my previous discussion on curvalid vs valid/prox/touch.


Ditto.


>> I think it is unnecessary to have both a slot number and a curcontac=
t value.
>> Either the firmware reports the slot itself, or it reports a contact=
 id that
>> needs to be looked up from the list of slots. In neither case does a=
nything but
>> slot number and contact id enter the equation.
>=20
> See the following patches for examples of this being wrong.


The enumeration used in some of the drivers makes sense, but I never go=
t around
to test on a broader basis whether HID_DG_CONTACTID would accomplish th=
e same
thing. I am fine with using a counter for some drivers.

>>>
>>> +            if (s->prev_valid) {
>>> +                input_mt_slot(input, i);  =20
>>
>>
>> The logic is a bit easier if input_mt_slot() appears once before all=
 the
>> branching. If nothing else is emitted, the input core does not emit =
the slot
>> event.
>=20
> I'm not a big fan of this kind of 'blind pass'. Jiri?


In this particular case, I think it makes the logic clearer.

>> How about touch_major, touch_minor and orientation here?
>=20
> I have no device available to test this at the moment. What I had in =
mind was to
> add them when we add support for a device that has them.


OK, in conjunction with the 3M adaption, then.

>>> +        s->prev_valid =3D true;
>>> +        s->valid =3D false;
>>
>>
>> Changing the touch state to false here seems wrong.
>=20
> But it's necessary, believe me. There are devices for which we don't =
get a
> chance to change it to false when the finger is released. Setting it =
to false
> every time and resetting it to true when we get confirmation that the=
 contact is
> still alive is the failsafe way of doing things.


Different assumptions here, I think. I am assuming that the set of kept=
 slots
are always valid, and contain a touch state. If a set of touches limite=
d by
HID_DG_CONTACTCOUNT comes in, one would reset the touch state of the re=
maining
touches. This would simplify adaption of the devices that send partial =
or
sequential states, IMO.

>=20
>>> +        input_event(input, EV_KEY, BTN_TOUCH, 1);
>>> +        input_event(input, EV_ABS, ABS_X, oldest->x);
>>> +        input_event(input, EV_ABS, ABS_Y, oldest->y);
>>
>>
>> Pressure here as well.
>=20
> Oops.
>=20
>>
>>> +    } else {
>>> +        input_event(input, EV_KEY, BTN_TOUCH, 0);
>>> +    }
>>> +
>>> +    input_sync(input);
>>> +    td->curcontact =3D 0;
>>
>>
>> The curcontact semantics could be clearer, as noted elsewhere.
>=20
> Another name, perhaps? The bottom line is that we need to keep trace =
of the rank
> of the contact in the current message.


Yeah, different name. And something that makes clear whether we are tal=
king
about an index (count - 1) or the count itself.

>>> +}
>>> +
>>> +
>>> +
>>> +static int mt_event(struct hid_device *hid, struct hid_field *fiel=
d,
>>> +                struct hid_usage *usage, __s32 value)
>>> +{
>>> +    struct mt_device *td =3D hid_get_drvdata(hid);
>>> +
>>> +    if (hid->claimed & HID_CLAIMED_INPUT) {
>>> +        struct input_dev *input =3D field->hidinput->input;
>>> +        switch (usage->hid) {
>>> +        case HID_DG_INRANGE:
>>
>>
>> This one is used to report the validity of the current reported cont=
act on many
>> devices. Maybe all, even?
>=20
> Actually, only on a minority of device last time I checked.


Adding "if sequence number less than number of sent contacts" to the li=
st, I
think we might cover all of them.


>=20
>>> +        case HID_DG_TIPSWITCH:
>>> +            td->curvalid =3D value;
>>
>>
>> This is really the touch state, the proximity.
>=20
> I wish.


Same comment as above. :-)

>=20
>>
>>> +            break;
>>> +        case HID_DG_CONFIDENCE:
>>> +            break;
>>> +        case HID_DG_CONTACTID:
>>> +            td->curcontactid =3D value;
>>
>>
>> Here is where I would but the conversion to slot id. And it should d=
efinitely be
>> guarded so that it is always a valid index.
>=20
> I'll pay you a beer if you find how to make this work for all devices=
 :-)


It will keep you to your promise - and vice versa if it does not work o=
ut. :-)

>>
>>> +        case HID_GD_Y:
>>> +            td->cury =3D value;
>>> +            /* works for devices where Y is last in a contact */
>>> +            mt_complete_slot(td);
>>
>>
>> Relying on a particular field to come last seems non-generic. Since =
there is
>> already a bit field started for various features of the device, why =
not complete
>> that list with all data reported per contact, and use it know when a=
 contact is
>> complete? Something like "recorded_mask =3D=3D expected_mask".
>=20
> What I had in mind was that the information is available in lower lev=
el code,
> and that we could handle this when switching to a raw hid device. Oth=
erwise,
> we'd just be reinventing the wheel, that is rebuilding information th=
at's
> already there. Same for HID_CONTACTCOUNT below: I use it because it m=
arks the
> end of messages on most devices, but there should be a better way of =
knowing
> that we are at the end of a message.


Yeah. I was looking for a means in the hid usage code. One option could=
 be to
add a "serve me all usages at once" method in the HID layer. Regardless=
, I doubt
the current code will actually work for all devices?

>>
>>> +            break;
>>> +        case HID_DG_CONTACTCOUNT:
>>> +            /*
>>> +             * works for devices where contact count is
>>> +             * the last field in a message
>>> +             */
>>> +            if (value)
>>> +                td->maxcontact =3D value - 1;
>>
>>
>> The usage of maxcontact is a bit odd. Perhaps there should be a "max=
slot" which
>> never changes, and a "contactcount" which starts at zero.
>=20
> maxcontact works with curcontact. I found the name 'contactcount' con=
fusing,
> because in HID it means something else. Still looking for a better na=
me for
> 'curcontact'.
>=20
>>
>>> +            if (td->curcontact > td->maxcontact)
>>> +                mt_emit_event(td, input);
>>
>>
>> So curcontact is here a counter, which implements the logic found in=
 the 3M,
>> with partial reports combining into a single one. Maybe we need a co=
unter, or
>> maybe we can get by using the CONTACTID field.
>>
>>>
>=20
> Yes, curcontact is a counter. And we also need it for computing the s=
lot id
> sometimes.


Ok. How about num_received?

>>> +
>>> +#if 0
>>> +    /*
>>> +         * todo: activate this as soon as the patch where the quir=
k below
>>> +         * is defined is commited. This will allow the driver to c=
orrectly
>>> +         * support devices that emit events over several HID messa=
ges.
>>> +         */
>>> +    hdev->quirks |=3D HID_QUIRK_NO_INPUT_SYNC;
>>> +#endif
>>
>>
>> This code should be active.
>=20
> Then it won't compile in 2.6.36-rc7.


But to test it, it will have to compile :-)

>>> +
>>> +    td =3D kzalloc(sizeof(struct mt_device), GFP_KERNEL);
>>> +    if (!td) {
>>> +        dev_err(&hdev->dev, "cannot allocate multitouch data\n");
>>> +        return -ENOMEM;
>>> +    }
>>> +    td->mtclass =3D mt_classes + id->driver_data;
>>> +    td->slots =3D kzalloc(td->mtclass->maxcontacts * sizeof(struct=
 mt_slot),
>>> +                GFP_KERNEL);
>>
>>
>> Allocating slots in the same range as mt_device would be nice.
>=20
> Agreed.
>=20
>>
>>> +        struct hid_report_enum *re =3D hdev->report_enum
>>> +                        + HID_FEATURE_REPORT;
>>
>>
>> &hdev->report_enum[HID_FEATURE_REPORT]
>=20
> Won't fit on one line, then. Visually, it gets worse. Someone else, a=
n opinion?
>=20
>>
>>
>> That's it for now :-)
>>
>=20
> Then, on to patches 2, 3 and 4 :-)


And the next round :-)

Cheers,
Henrik

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
