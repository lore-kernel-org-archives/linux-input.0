From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH 1/4] hid-multitouch: support for PixCir-based panels
Date: Thu, 14 Oct 2010 12:28:20 +0200
Message-ID: <BA82E030-B041-4354-9715-02DF56510DA2@enac.fr>
References: <20101013223035.9B86E9522A@smtp.lii-enac.fr> <4CB6CF79.9040107@euromail.se>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:52913 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560Ab0JNK2c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Oct 2010 06:28:32 -0400
In-Reply-To: <4CB6CF79.9040107@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>


Le 14 oct. 10 =E0 11:38, Henrik Rydberg a =E9crit :
>>
>> +	bool valid;	/* did we just get valid contact data for this slot? *=
/
>> +	bool prev_valid;/* was this slot previously valid/active? */
>
>
> I do think these should be named "touch" or "prox" rather than =20
> "valid". The
> latter term is used in many drivers no represent "not null", and =20
> mixing the
> semantics with proximity is best avoided.
>

Actually, the mix of semantics exists because of the mismatch between =20
the (static) HID protocol and the (dynamic) data it transports. Most =20
of the time, TipSwitch=3D0 occurs when we get placeholder data: there =20
is nothing to report at all, but the message format imposes that =20
something is sent. And sometimes (rarely), we get TipSwitch=3D0 because=
 =20
a finger has been released. We are lucky that we can handle the two =20
situations in the same way.

See below for a discussion of how we can solve this.


>> +	bool curvalid; 		/* is the current contact valid? */
>> +	__u16 curcontactid; 	/* ContactID of the current contact */
>> +	__u16 curx, cury, curp;	/* other attributes of the current =20
>> contact */
>
>
> Could be a struct mt_slot instead.

Well, it's not *exactly* the same data. Especially if, as I'm =20
beginning to understand thanks to one of your later comments, there =20
is a difference in the semantics of 'valid' between slots and the =20
current contact as read in the HID message:
  - my above discussion applies to the current contact
  - and in slots, this information gets filtered to become actual =20
proximity information.

This would give:
  - curvalid in mt_data
  - touch in mt_slot (and not prox, because prox will mean something =20
else in devices that have hover detection)


>
>> +};
>> +
>> +struct mt_class {
>> +	int (*compute_slot)(struct mt_device *);
>> +	__u8 maxcontacts;
>> +	__s8 inputmode;	/* InputMode HID feature number, -1 if non-=20
>> existent */
>
>
> It would be nice to have additional information here, like signal-=20
> to-noise ratio.

I thought you would say that. My answer was ready: I left it to you =20
to add it afterwards :-)

>>
>> +/* contact data that only some devices report */
>> +#define PRESSURE 	(1 << 0)
>> +#define SIZE		(1 << 1)
>
>
> The names here are a bit too general, IMO.

I thought so too, but was too lazy to imagine something else and =20
decided that what the heck, these are private names. Any suggestion?

>
>> +
>> +/*
>> + * these device-dependent functions determine what slot corresponds
>> + * to a valid contact that was just read.
>> + */
>> +
>> +static int slot_from_contactid(struct mt_device *td)
>> +{
>> +	return td->curcontactid;
>> +}
>
>
> I suppose this one is meant to loop over available slots for some =20
> implementations.

See the following patches for examples. So far, looping was not =20
necessary.

>
>> +
>> +struct mt_class mt_classes[] =3D {
>> +	/* DUAL1 */		{ slot_from_contactid, 2, -1 },
>> +};
>
>
> Off placement of comment.
>>

Please, please don't force me to add a useless field to the struct so =20
as to make sure that the type is read before the data :-) Oh well...


>
> A helper function that simplifies the repeated usage of =20
> input_set_abs_params()
> would be nice.
>
> A local variable for hi->input would be nice.
>
> If we want to support fuzz, and do not want to add it to the hid =20
> structure
> (because it is not available in the reports), we should consider =20
> setting up the
> input_dev completely within this driver, as done in the 3M and =20
> egalax drivers.

Yes, my idea was that you'd like to take over and introduce the kind =20
of work you are doing for 3M and eGalax. As for the helper function =20
and hi->input, hey, I just copied your code :-)


>> +		if (slotnum >=3D 0 && slotnum <=3D td->mtclass->maxcontacts - 1) =
{
>
>
> The returned slotnum should always be valid, so this test is =20
> redundant.

Nope. See Cypress devices.

>
>> +			slot =3D td->slots + slotnum;
>> +
>> +			slot->valid =3D true;
>
>
> Rather that setting valid here, it should simply be the proximity =20
> (touch) state.
> All slot data in our buffer is actually valid at all times.
>
>> +			slot->x =3D td->curx;
>> +			slot->y =3D td->cury;
>> +			slot->p =3D td->curp;
>
>
> Using a temporary slot struct for curx etc would be nice.
>
>> +		}
>> +	}
>> +	td->curcontact++;

See my previous discussion on curvalid vs valid/prox/touch.

>
> I think it is unnecessary to have both a slot number and a =20
> curcontact value.
> Either the firmware reports the slot itself, or it reports a =20
> contact id that
> needs to be looked up from the list of slots. In neither case does =20
> anything but
> slot number and contact id enter the equation.

See the following patches for examples of this being wrong.


>>
>> +			if (s->prev_valid) {
>> +				input_mt_slot(input, i);=09
>
>
> The logic is a bit easier if input_mt_slot() appears once before =20
> all the
> branching. If nothing else is emitted, the input core does not emit =20
> the slot event.

I'm not a big fan of this kind of 'blind pass'. Jiri?


>
>
> How about touch_major, touch_minor and orientation here?

I have no device available to test this at the moment. What I had in =20
mind was to add them when we add support for a device that has them.

>
>> +		s->prev_valid =3D true;
>> +		s->valid =3D false;
>
>
> Changing the touch state to false here seems wrong.

But it's necessary, believe me. There are devices for which we don't =20
get a chance to change it to false when the finger is released. =20
Setting it to false every time and resetting it to true when we get =20
confirmation that the contact is still alive is the failsafe way of =20
doing things.


>> +		input_event(input, EV_KEY, BTN_TOUCH, 1);
>> +		input_event(input, EV_ABS, ABS_X, oldest->x);
>> +		input_event(input, EV_ABS, ABS_Y, oldest->y);
>
>
> Pressure here as well.

Oops.

>
>> +	} else {
>> +		input_event(input, EV_KEY, BTN_TOUCH, 0);
>> +	}
>> +
>> +	input_sync(input);
>> +	td->curcontact =3D 0;
>
>
> The curcontact semantics could be clearer, as noted elsewhere.

Another name, perhaps? The bottom line is that we need to keep trace =20
of the rank of the contact in the current message.

>
>> +}
>> +
>> +
>> +
>> +static int mt_event(struct hid_device *hid, struct hid_field *field=
,
>> +				struct hid_usage *usage, __s32 value)
>> +{
>> +	struct mt_device *td =3D hid_get_drvdata(hid);
>> +
>> +	if (hid->claimed & HID_CLAIMED_INPUT) {
>> +		struct input_dev *input =3D field->hidinput->input;
>> +		switch (usage->hid) {
>> +		case HID_DG_INRANGE:
>
>
> This one is used to report the validity of the current reported =20
> contact on many
> devices. Maybe all, even?

Actually, only on a minority of device last time I checked.


>> +		case HID_DG_TIPSWITCH:
>> +			td->curvalid =3D value;
>
>
> This is really the touch state, the proximity.

I wish.

>
>> +			break;
>> +		case HID_DG_CONFIDENCE:
>> +			break;
>> +		case HID_DG_CONTACTID:
>> +			td->curcontactid =3D value;
>
>
> Here is where I would but the conversion to slot id. And it should =20
> definitely be
> guarded so that it is always a valid index.

I'll pay you a beer if you find how to make this work for all =20
devices :-)

>
>> +		case HID_GD_Y:
>> +			td->cury =3D value;
>> +			/* works for devices where Y is last in a contact */
>> +			mt_complete_slot(td);
>
>
> Relying on a particular field to come last seems non-generic. Since =20
> there is
> already a bit field started for various features of the device, why =20
> not complete
> that list with all data reported per contact, and use it know when =20
> a contact is
> complete? Something like "recorded_mask =3D=3D expected_mask".

What I had in mind was that the information is available in lower =20
level code, and that we could handle this when switching to a raw hid =20
device. Otherwise, we'd just be reinventing the wheel, that is =20
rebuilding information that's already there. Same for =20
HID_CONTACTCOUNT below: I use it because it marks the end of messages =20
on most devices, but there should be a better way of knowing that we =20
are at the end of a message.


>
>> +			break;
>> +		case HID_DG_CONTACTCOUNT:
>> +			/*
>> +			 * works for devices where contact count is
>> +			 * the last field in a message
>> +			 */
>> +			if (value)
>> +				td->maxcontact =3D value - 1;
>
>
> The usage of maxcontact is a bit odd. Perhaps there should be a =20
> "maxslot" which
> never changes, and a "contactcount" which starts at zero.

maxcontact works with curcontact. I found the name 'contactcount' =20
confusing, because in HID it means something else. Still looking for =20
a better name for 'curcontact'.

>
>> +			if (td->curcontact > td->maxcontact)
>> +				mt_emit_event(td, input);
>
>
> So curcontact is here a counter, which implements the logic found =20
> in the 3M,
> with partial reports combining into a single one. Maybe we need a =20
> counter, or
> maybe we can get by using the CONTACTID field.
>
>>

Yes, curcontact is a counter. And we also need it for computing the =20
slot id sometimes.


>> +
>> +#if 0
>> +	/*
>> +         * todo: activate this as soon as the patch where the =20
>> quirk below
>> +         * is defined is commited. This will allow the driver to =20
>> correctly
>> +         * support devices that emit events over several HID =20
>> messages.
>> +         */
>> +	hdev->quirks |=3D HID_QUIRK_NO_INPUT_SYNC;
>> +#endif
>
>
> This code should be active.

Then it won't compile in 2.6.36-rc7.

>
>> +
>> +	td =3D kzalloc(sizeof(struct mt_device), GFP_KERNEL);
>> +	if (!td) {
>> +		dev_err(&hdev->dev, "cannot allocate multitouch data\n");
>> +		return -ENOMEM;
>> +	}
>> +	td->mtclass =3D mt_classes + id->driver_data;
>> +	td->slots =3D kzalloc(td->mtclass->maxcontacts * sizeof(struct =20
>> mt_slot),
>> +				GFP_KERNEL);
>
>
> Allocating slots in the same range as mt_device would be nice.

Agreed.

>
>> +		struct hid_report_enum *re =3D hdev->report_enum
>> +						+ HID_FEATURE_REPORT;
>
>
> &hdev->report_enum[HID_FEATURE_REPORT]

Won't fit on one line, then. Visually, it gets worse. Someone else, =20
an opinion?

>
>
> That's it for now :-)
>

Then, on to patches 2, 3 and 4 :-)

St.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
