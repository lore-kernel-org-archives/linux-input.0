From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Re: [PATCH 4/4] Add RC6 support to ir-core
Date: Sat, 10 Apr 2010 21:52:07 +0200
Message-ID: <20100410195207.GA3676@hardeman.nu>
References: <20100408230246.14453.97377.stgit@localhost.localdomain>
 <20100408230440.14453.36936.stgit@localhost.localdomain>
 <1270861928.3038.153.camel@palomino.walls.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1270861928.3038.153.camel@palomino.walls.org>
Sender: linux-media-owner@vger.kernel.org
To: Andy Walls <awalls@radix.net>
Cc: mchehab@redhat.com, linux-input@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Apr 09, 2010 at 09:12:08PM -0400, Andy Walls wrote:
> On Fri, 2010-04-09 at 01:04 +0200, David H=E4rdeman wrote:
> > diff --git a/drivers/media/IR/ir-rc6-decoder.c=20
> > b/drivers/media/IR/ir-rc6-decoder.c
> > new file mode 100644
> > index 0000000..ccc5be2
> > --- /dev/null
> > +++ b/drivers/media/IR/ir-rc6-decoder.c
> > @@ -0,0 +1,412 @@
> > +/* ir-rc6-decoder.c - A decoder for the RC6 IR protocol
> > + *
> > + * Copyright (C) 2010 by David H=E4rdeman <david@hardeman.nu>
> > + *
> > + * This program is free software; you can redistribute it and/or m=
odify
> > + * it under the terms of the GNU General Public License as publish=
ed by
> > + * the Free Software Foundation version 2 of the License.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include "ir-core-priv.h"
> > +
> > +/*
> > + * This decoder currently supports:
> > + * RC6-0-16	(standard toggle bit in header)
> > + * RC6-6A-24	(no toggle bit)
> > + * RC6-6A-32	(MCE version with toggle bit in body)
> > + */
>=20
> Just for reference for review:
>=20
> http://slycontrol.ru/scr/kb/rc6.htm
> http://www.picbasic.nl/info_rc6_uk.htm
>=20
>=20
> RC6 Mode 0:
>=20
> prefix mark:  111111
> prefix space: 00
> start bit:    10           (biphase encoding of '1')
> mode bits:    010101       (biphase encoding of '000')
> toggle bits:  0011 or 1100 (double duration biphase coding of '0' or =
'1')
> system byte:  xxxxxxxxxxxxxxxx (biphase encoding of 8 bits)
> command byte: yyyyyyyyyyyyyyyy (biphase encoding of 8 bits)
>=20
> RC6 Mode 6A:
>=20
> prefix mark:   111111
> prefix space:  00
> start bit:     10           (biphase encoding of '1')
> mode bits:     101001       (biphase encoding of '110' for '6')=20
> trailer bits:  0011         (double duration biphase encoding of '0' =
for 'A')
> customer len:  01 or 10     (biphase encoding of '0' for 7 bits or '1=
' for 15 bits)
> customer bits: xxxxxxxxxxxxxx (biphase encoding of 7 bits for a short=
 customer code)
> 		or
>                xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx (biphase encoding of 15=
 bits for a long customer code)
> system byte:   yyyyyyyyyyyyyyyy (biphase encoding of 8 bits)
> command byte:  zzzzzzzzzzzzzzzz (biphase encoding of 8 bits)
>=20
>=20
> > +#define RC6_UNIT		444444	/* us */
> > +#define RC6_HEADER_NBITS	4	/* not including toggle bit */
> > +#define RC6_0_NBITS		16
> > +#define RC6_6A_SMALL_NBITS	24
> > +#define RC6_6A_LARGE_NBITS	32
>=20
> According to the slycontrol.ru website, the data length is, in theory
> OEM dependent for Mode 6A, limited to a max of 24 bits (3 bytes) afte=
r a
> short customer code and 128 bits (16 bytes) after a long customer cod=
e.
>=20
> I don't know what the reality is for existing remotes.
>=20
> Would it be better to look for the signal free time of 6 RC6_UNITs to
> declare the end of reception, instead of a bit count?

Yes, it might be better from a correctness point of view, and I think i=
t=20
might be a worthwhile change if we want to support a few more odd=20
remotes (although the only one I'm aware of - even after trawling=20
through lots of lirc configs, decodeir.dll configs and remotecentral=20
configs - is the "Sky" remote which seems to use a short customer code=20
and a 12 bit body).

The thing is though, that with the different 32 bit scancodes, we can't=
=20
anyway represent anything beyond a 32 bit message body (including the=20
customer code, which should be included in the scancode). I have a=20
proposal on changing the scancodes used in ir-code, but I haven't=20
written up the details yet.

It's also interesting to note that the ProntoEdit NG program, which is=20
written by Philips, only allows a 24/32 bit body (including the custome=
r=20
bits).

> > +#define RC6_PREFIX_PULSE	PULSE(6)
> > +#define RC6_PREFIX_SPACE	SPACE(2)
> > +#define RC6_MODE_MASK		0x07	/* for the header bits */
> > +#define RC6_STARTBIT_MASK	0x08	/* for the header bits */
> > +#define RC6_6A_MCE_TOGGLE_MASK	0x8000	/* for the body bits */
>=20
> That's an OEM specific toggle bit.

Umm, yes I know? That's why the define includes the "_MCE_" part and=20
also what the comment in the beginning of the decoder says:

	* RC6-6A-32	(MCE version with toggle bit in body)

>  It is likely more properly named
> RC6_6A_MS_TOGGLE_MASK.  See slide 6 of:
>=20
> http://download.microsoft.com/download/9/8/f/98f3fe47-dfc3-4e74-92a3-=
088782200fe7/TWEN05007_WinHEC05.ppt
>=20
> (Although in reality, every remote that wants to work with stock MS
> drivers will use it.)

I'm not sure what your point is...it's already called=20
RC6_6A_MCE_TOGGLE_MASK, as in "RC6 6A Windows Media Center Edition=20
Toggle Mask".
=20
> > +
> > +/* Used to register rc6_decoder clients */
> > +static LIST_HEAD(decoder_list);
> > +static DEFINE_SPINLOCK(decoder_lock);
> > +
> > +enum rc6_mode {
> > +	RC6_MODE_0,
> > +	RC6_MODE_6A,
> > +	RC6_MODE_UNKNOWN,
> > +};
> > +
> > +enum rc6_state {
> > +	STATE_INACTIVE,
> > +	STATE_PREFIX_SPACE,
> > +	STATE_HEADER_BIT_START,
> > +	STATE_HEADER_BIT_END,
> > +	STATE_TOGGLE_START,
> > +	STATE_TOGGLE_END,
> > +	STATE_BODY_BIT_START,
> > +	STATE_BODY_BIT_END,
> > +	STATE_FINISHED,
> > +};
> > +
> > +struct decoder_data {
> > +	struct list_head	list;
> > +	struct ir_input_dev	*ir_dev;
> > +	int			enabled:1;
> > +
> > +	/* State machine control */
> > +	enum rc6_state		state;
> > +	u8			header;
> > +	u32			body;
> > +	int			last_unit;
> > +	bool			toggle;
> > +	unsigned		count;
> > +	unsigned		wanted_bits;
> > +};
> > +
> > +
> > +/**
> > + * get_decoder_data()	- gets decoder data
> > + * @input_dev:	input device
> > + *
> > + * Returns the struct decoder_data that corresponds to a device
> > + */
> > +static struct decoder_data *get_decoder_data(struct  ir_input_dev =
*ir_dev)
> > +{
> > +	struct decoder_data *data =3D NULL;
> > +
> > +	spin_lock(&decoder_lock);
> > +	list_for_each_entry(data, &decoder_list, list) {
> > +		if (data->ir_dev =3D=3D ir_dev)
> > +			break;
> > +	}
> > +	spin_unlock(&decoder_lock);
> > +	return data;
> > +}
> > +
> > +static ssize_t store_enabled(struct device *d,
> > +			     struct device_attribute *mattr,
> > +			     const char *buf,
> > +			     size_t len)
> > +{
> > +	unsigned long value;
> > +	struct ir_input_dev *ir_dev =3D dev_get_drvdata(d);
> > +	struct decoder_data *data =3D get_decoder_data(ir_dev);
> > +
> > +	if (!data)
> > +		return -EINVAL;
> > +
> > +	if (strict_strtoul(buf, 10, &value) || value > 1)
> > +		return -EINVAL;
> > +
> > +	data->enabled =3D value;
> > +
> > +	return len;
> > +}
> > +
> > +static ssize_t show_enabled(struct device *d,
> > +			     struct device_attribute *mattr, char *buf)
> > +{
> > +	struct ir_input_dev *ir_dev =3D dev_get_drvdata(d);
> > +	struct decoder_data *data =3D get_decoder_data(ir_dev);
> > +
> > +	if (!data)
> > +		return -EINVAL;
> > +
> > +	if (data->enabled)
> > +		return sprintf(buf, "1\n");
> > +	else
> > +	return sprintf(buf, "0\n");
> > +}
> > +
> > +static DEVICE_ATTR(enabled, S_IRUGO | S_IWUSR, show_enabled, store=
_enabled);
> > +
> > +static struct attribute *decoder_attributes[] =3D {
> > +	&dev_attr_enabled.attr,
> > +	NULL
> > +};
> > +
> > +static struct attribute_group decoder_attribute_group =3D {
> > +	.name	=3D "rc6_decoder",
> > +	.attrs	=3D decoder_attributes,
> > +};
> > +
> > +static enum rc6_mode rc6_mode(struct decoder_data *data) {
> > +	switch (data->header & RC6_MODE_MASK) {
> > +	case 0:
> > +		return RC6_MODE_0;
> > +	case 6:
> > +		if (!data->toggle)
> > +			return RC6_MODE_6A;
> > +		/* fall through */
> > +	default:
> > +		return RC6_MODE_UNKNOWN;
> > +	}
> > +}
> > +
> > +/**
> > + * ir_rc6_decode() - Decode one RC6 pulse or space
> > + * @input_dev:	the struct input_dev descriptor of the device
> > + * @duration:	duration of pulse/space in ns
> > + *
> > + * This function returns -EINVAL if the pulse violates the state m=
achine
> > + */
> > +static int ir_rc6_decode(struct input_dev *input_dev, s64 duration=
)
> > +{
> > +	struct decoder_data *data;
> > +	struct ir_input_dev *ir_dev =3D input_get_drvdata(input_dev);
> > +	u32 scancode;
> > +	u8 toggle;
> > +	int u;
> > +
> > +	data =3D get_decoder_data(ir_dev);
> > +	if (!data)
> > +		return -EINVAL;
> > +
> > +	if (!data->enabled)
> > +		return 0;
> > +
> > +	if (IS_RESET(duration)) {
> > +		data->state =3D STATE_INACTIVE;
> > +		return 0;
> > +	}
> > +
> > +	u =3D  TO_UNITS(duration, RC6_UNIT);
> > +	if (DURATION(u) =3D=3D 0)
> > +		goto out;
> > +
> > +again:
> > +	IR_dprintk(2, "RC6 decode started at state %i (%i units, %ius)\n"=
,
> > +		   data->state, u, TO_US(duration));
> > +
> > +	if (DURATION(u) =3D=3D 0 && data->state !=3D STATE_FINISHED)
> > +		return 0;
>=20
> Isn't there a better way to structure the logic to break up two adjac=
ent
> pulse units than with goto's out of the switch back up to here?
>=20
> A do {} while() loop would have been much clearer.
>=20
>=20
> > +	switch (data->state) {
> > +
> > +	case STATE_INACTIVE:
> > +		if (u >=3D RC6_PREFIX_PULSE - 1 && u <=3D RC6_PREFIX_PULSE + 1) =
{
> > +			data->state =3D STATE_PREFIX_SPACE;
> > +			data->count =3D 0;
> > +			return 0;
> > +		}
> > +		break;
> > +
> > +	case STATE_PREFIX_SPACE:
> > +		if (u =3D=3D RC6_PREFIX_SPACE) {
> > +			data->state =3D STATE_HEADER_BIT_START;
> > +			return 0;
> > +		}
> > +		break;
> > +
> > +	case STATE_HEADER_BIT_START:
> > +		if (DURATION(u) =3D=3D 1) {
> > +			data->header <<=3D 1;
> > +			if (IS_PULSE(u))
> > +				data->header |=3D 1;
> > +			data->count++;
> > +			data->last_unit =3D u;
> > +			data->state =3D STATE_HEADER_BIT_END;
> > +			return 0;
> > +		}
> > +		break;
> > +
> > +	case STATE_HEADER_BIT_END:
> > +		if (IS_TRANSITION(u, data->last_unit)) {
> > +			if (data->count =3D=3D RC6_HEADER_NBITS)
> > +				data->state =3D STATE_TOGGLE_START;
> > +			else
> > +				data->state =3D STATE_HEADER_BIT_START;
> > +
> > +			DECREASE_DURATION(u, 1);
> > +			goto again;
> > +		}
> > +		break;
> > +
> > +	case STATE_TOGGLE_START:
> > +		if (DURATION(u) =3D=3D 2) {
> > +			data->toggle =3D IS_PULSE(u);
> > +			data->last_unit =3D u;
> > +			data->state =3D STATE_TOGGLE_END;
> > +			return 0;
> > +		}
> > +		break;
> > +
> > +	case STATE_TOGGLE_END:
> > +		if (IS_TRANSITION(u, data->last_unit) && DURATION(u) >=3D 2) {
> > +			data->state =3D STATE_BODY_BIT_START;
> > +			data->last_unit =3D u;
> > +			DECREASE_DURATION(u, 2);
> > +			data->count =3D 0;
> > +
> > +			if (!(data->header & RC6_STARTBIT_MASK)) {
> > +				IR_dprintk(1, "RC6 invalid start bit\n");
> > +				break;
> > +			}
> > +
> > +			switch (rc6_mode(data)) {
> > +			case RC6_MODE_0:
> > +				data->wanted_bits =3D RC6_0_NBITS;
> > +				break;
> > +			case RC6_MODE_6A:
> > +				/* This might look weird, but we basically
> > +				   check the value of the first body bit to
> > +				   determine the number of bits in mode 6A */
>=20
> This bit basically only tells you the length of the customer code: 7 =
or
> 15 bits. =20

I know.

> > +				if ((DURATION(u) =3D=3D 0 && IS_SPACE(data->last_unit)) || DUR=
ATION(u) > 0)
> > +					data->wanted_bits =3D RC6_6A_LARGE_NBITS;
> > +				else
> > +					data->wanted_bits =3D RC6_6A_SMALL_NBITS;
> > +				break;
> > +			default:
> > +				IR_dprintk(1, "RC6 unknown mode\n");
> > +				goto out;
> > +			}
> > +			goto again;
> > +		}
> > +		break;
> > +
> > +	case STATE_BODY_BIT_START:
> > +		if (DURATION(u) =3D=3D 1) {
> > +			data->body <<=3D 1;
> > +			if (IS_PULSE(u))
> > +				data->body |=3D 1;
> > +			data->count++;
> > +			data->last_unit =3D u;
> > +
> > +			/*
> > +			 * If the last bit is one, a space will merge
> > +			 * with the silence after the command.
> > +			 */
> > +			if (IS_PULSE(u) && data->count =3D=3D data->wanted_bits) {
> > +				data->state =3D STATE_FINISHED;
> > +				goto again;
> > +			}
> > +
> > +			data->state =3D STATE_BODY_BIT_END;
> > +			return 0;
> > +		}
> > +		break;
> > +
> > +	case STATE_BODY_BIT_END:
> > +		if (IS_TRANSITION(u, data->last_unit)) {
> > +			if (data->count =3D=3D data->wanted_bits)
> > +				data->state =3D STATE_FINISHED;
> > +			else
> > +				data->state =3D STATE_BODY_BIT_START;
> > +
> > +			DECREASE_DURATION(u, 1);
> > +			goto again;
> > +		}
> > +		break;
> > +
> > +	case STATE_FINISHED:
> > +		switch (rc6_mode(data)) {
> > +		case RC6_MODE_0:
> > +			scancode =3D data->body & 0xffff;
> > +			toggle =3D data->toggle;
> > +			IR_dprintk(1, "RC6(0) scancode 0x%04x (toggle: %u)\n",
> > +				   scancode, toggle);
> > +			break;
> > +		case RC6_MODE_6A:
> > +			if (data->wanted_bits =3D=3D RC6_6A_LARGE_NBITS) {
> > +				toggle =3D data->body & RC6_6A_MCE_TOGGLE_MASK ? 1 : 0;
> > +				scancode =3D data->body & ~RC6_6A_MCE_TOGGLE_MASK;
>=20
> Technically this depends on the OEM. =20

I know, again it's mentioned in one of the first comments of the code.

> In reality, every RC6 Mode 6A
> remote that wants to work with Microsoft stock drivers will likely us=
e
> this bit as a toggle.

We might want to check if the (long) customer code matches 0x800F (if I=
=20
remember correctly) and apply the MCE behaviour only then, but it might=
=20
also come back to bite us in the ass if, for example, different=20
customers have implemented the same definition of the body.

Then again, as far as I can remeber, the Philips Pronto raw code for MC=
E=20
commands doesn't include the customer code, which would indicate that=20
it's fixed.

Another question is: if the customer code doesn't match, what do we do?=
 =20
The body could be defined as any random gibberish by vendor XYZ,=20
including toggles and checksums which means that the scancode would=20
change for each keypress if we blindly report the entire body as a 32=20
bit scancode.

--=20
David H=E4rdeman
