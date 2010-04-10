From: Andy Walls <awalls@radix.net>
Subject: Re: [PATCH 4/4] Add RC6 support to ir-core
Date: Fri, 09 Apr 2010 21:12:08 -0400
Message-ID: <1270861928.3038.153.camel@palomino.walls.org>
References: <20100408230246.14453.97377.stgit@localhost.localdomain>
	 <20100408230440.14453.36936.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20100408230440.14453.36936.stgit@localhost.localdomain>
Sender: linux-media-owner@vger.kernel.org
To: David =?ISO-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Cc: mchehab@redhat.com, linux-input@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 2010-04-09 at 01:04 +0200, David H=C3=A4rdeman wrote:
> This patch adds an RC6 decoder (modes 0 and 6A) to ir-core.
>
> Signed-off-by: David H=C3=A4rdeman <david@hardeman.nu>

David,

Overall, a nice job of implementing RC6 decoder logic.  I have a few
comments below (along with some of me reasoning to myself out loud).


> ---
>  drivers/media/IR/Kconfig          |    9 +
>  drivers/media/IR/Makefile         |    1=20
>  drivers/media/IR/ir-core-priv.h   |    7 +
>  drivers/media/IR/ir-raw-event.c   |    1=20
>  drivers/media/IR/ir-rc6-decoder.c |  412 +++++++++++++++++++++++++++=
++++++++++
>  drivers/media/IR/ir-sysfs.c       |    2=20
>  include/media/rc-map.h            |    1=20
>  7 files changed, 433 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/media/IR/ir-rc6-decoder.c
>=20
> diff --git a/drivers/media/IR/Kconfig b/drivers/media/IR/Kconfig
> index ba81bda..28d336d 100644
> --- a/drivers/media/IR/Kconfig
> +++ b/drivers/media/IR/Kconfig
> @@ -27,3 +27,12 @@ config IR_RC5_DECODER
>  	---help---
>  	   Enable this option if you have IR with RC-5 protocol, and
>  	   if the IR is decoded in software
> +
> +config IR_RC6_DECODER
> +	tristate "Enable IR raw decoder for the RC6 protocol"
> +	depends on IR_CORE
> +	default y
> +
> +	---help---
> +	   Enable this option if you have an infrared remote control which
> +	   uses the RC6 protocol, and you need software decoding support.
> diff --git a/drivers/media/IR/Makefile b/drivers/media/IR/Makefile
> index 62e12d5..792d9ca 100644
> --- a/drivers/media/IR/Makefile
> +++ b/drivers/media/IR/Makefile
> @@ -7,3 +7,4 @@ obj-$(CONFIG_IR_CORE) +=3D ir-core.o
>  obj-$(CONFIG_VIDEO_IR) +=3D ir-common.o
>  obj-$(CONFIG_IR_NEC_DECODER) +=3D ir-nec-decoder.o
>  obj-$(CONFIG_IR_RC5_DECODER) +=3D ir-rc5-decoder.o
> +obj-$(CONFIG_IR_RC6_DECODER) +=3D ir-rc6-decoder.o
> diff --git a/drivers/media/IR/ir-core-priv.h b/drivers/media/IR/ir-co=
re-priv.h
> index ab785bc..853ec80 100644
> --- a/drivers/media/IR/ir-core-priv.h
> +++ b/drivers/media/IR/ir-core-priv.h
> @@ -109,4 +109,11 @@ void ir_raw_init(void);
>  #define load_rc5_decode()	0
>  #endif
> =20
> +/* from ir-rc6-decoder.c */
> +#ifdef CONFIG_IR_RC5_DECODER_MODULE
> +#define load_rc6_decode()	request_module("ir-rc6-decoder")
> +#else
> +#define load_rc6_decode()	0
> +#endif
> +
>  #endif /* _IR_RAW_EVENT */
> diff --git a/drivers/media/IR/ir-raw-event.c b/drivers/media/IR/ir-ra=
w-event.c
> index 2efc051..ef0f231 100644
> --- a/drivers/media/IR/ir-raw-event.c
> +++ b/drivers/media/IR/ir-raw-event.c
> @@ -224,6 +224,7 @@ static void init_decoders(struct work_struct *wor=
k)
> =20
>  	load_nec_decode();
>  	load_rc5_decode();
> +	load_rc6_decode();
> =20
>  	/* If needed, we may later add some init code. In this case,
>  	   it is needed to change the CONFIG_MODULE test at ir-core.h
> diff --git a/drivers/media/IR/ir-rc6-decoder.c b/drivers/media/IR/ir-=
rc6-decoder.c
> new file mode 100644
> index 0000000..ccc5be2
> --- /dev/null
> +++ b/drivers/media/IR/ir-rc6-decoder.c
> @@ -0,0 +1,412 @@
> +/* ir-rc6-decoder.c - A decoder for the RC6 IR protocol
> + *
> + * Copyright (C) 2010 by David H=C3=A4rdeman <david@hardeman.nu>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License as published=
 by
> + * the Free Software Foundation version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include "ir-core-priv.h"
> +
> +/*
> + * This decoder currently supports:
> + * RC6-0-16	(standard toggle bit in header)
> + * RC6-6A-24	(no toggle bit)
> + * RC6-6A-32	(MCE version with toggle bit in body)
> + */

Just for reference for review:

http://slycontrol.ru/scr/kb/rc6.htm
http://www.picbasic.nl/info_rc6_uk.htm


RC6 Mode 0:

prefix mark:  111111
prefix space: 00
start bit:    10           (biphase encoding of '1')
mode bits:    010101       (biphase encoding of '000')
toggle bits:  0011 or 1100 (double duration biphase coding of '0' or '1=
')
system byte:  xxxxxxxxxxxxxxxx (biphase encoding of 8 bits)
command byte: yyyyyyyyyyyyyyyy (biphase encoding of 8 bits)

RC6 Mode 6A:

prefix mark:   111111
prefix space:  00
start bit:     10           (biphase encoding of '1')
mode bits:     101001       (biphase encoding of '110' for '6')=20
trailer bits:  0011         (double duration biphase encoding of '0' fo=
r 'A')
customer len:  01 or 10     (biphase encoding of '0' for 7 bits or '1' =
for 15 bits)
customer bits: xxxxxxxxxxxxxx (biphase encoding of 7 bits for a short c=
ustomer code)
		or
               xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx (biphase encoding of 15 b=
its for a long customer code)
system byte:   yyyyyyyyyyyyyyyy (biphase encoding of 8 bits)
command byte:  zzzzzzzzzzzzzzzz (biphase encoding of 8 bits)


> +#define RC6_UNIT		444444	/* us */
> +#define RC6_HEADER_NBITS	4	/* not including toggle bit */
> +#define RC6_0_NBITS		16
> +#define RC6_6A_SMALL_NBITS	24
> +#define RC6_6A_LARGE_NBITS	32

According to the slycontrol.ru website, the data length is, in theory
OEM dependent for Mode 6A, limited to a max of 24 bits (3 bytes) after =
a
short customer code and 128 bits (16 bytes) after a long customer code.

I don't know what the reality is for existing remotes.

Would it be better to look for the signal free time of 6 RC6_UNITs to
declare the end of reception, instead of a bit count?


> +#define RC6_PREFIX_PULSE	PULSE(6)
> +#define RC6_PREFIX_SPACE	SPACE(2)
> +#define RC6_MODE_MASK		0x07	/* for the header bits */
> +#define RC6_STARTBIT_MASK	0x08	/* for the header bits */
> +#define RC6_6A_MCE_TOGGLE_MASK	0x8000	/* for the body bits */

That's an OEM specific toggle bit.  It is likely more properly named
RC6_6A_MS_TOGGLE_MASK.  See slide 6 of:

http://download.microsoft.com/download/9/8/f/98f3fe47-dfc3-4e74-92a3-08=
8782200fe7/TWEN05007_WinHEC05.ppt

(Although in reality, every remote that wants to work with stock MS
drivers will use it.)

> +
> +/* Used to register rc6_decoder clients */
> +static LIST_HEAD(decoder_list);
> +static DEFINE_SPINLOCK(decoder_lock);
> +
> +enum rc6_mode {
> +	RC6_MODE_0,
> +	RC6_MODE_6A,
> +	RC6_MODE_UNKNOWN,
> +};
> +
> +enum rc6_state {
> +	STATE_INACTIVE,
> +	STATE_PREFIX_SPACE,
> +	STATE_HEADER_BIT_START,
> +	STATE_HEADER_BIT_END,
> +	STATE_TOGGLE_START,
> +	STATE_TOGGLE_END,
> +	STATE_BODY_BIT_START,
> +	STATE_BODY_BIT_END,
> +	STATE_FINISHED,
> +};
> +
> +struct decoder_data {
> +	struct list_head	list;
> +	struct ir_input_dev	*ir_dev;
> +	int			enabled:1;
> +
> +	/* State machine control */
> +	enum rc6_state		state;
> +	u8			header;
> +	u32			body;
> +	int			last_unit;
> +	bool			toggle;
> +	unsigned		count;
> +	unsigned		wanted_bits;
> +};
> +
> +
> +/**
> + * get_decoder_data()	- gets decoder data
> + * @input_dev:	input device
> + *
> + * Returns the struct decoder_data that corresponds to a device
> + */
> +static struct decoder_data *get_decoder_data(struct  ir_input_dev *i=
r_dev)
> +{
> +	struct decoder_data *data =3D NULL;
> +
> +	spin_lock(&decoder_lock);
> +	list_for_each_entry(data, &decoder_list, list) {
> +		if (data->ir_dev =3D=3D ir_dev)
> +			break;
> +	}
> +	spin_unlock(&decoder_lock);
> +	return data;
> +}
> +
> +static ssize_t store_enabled(struct device *d,
> +			     struct device_attribute *mattr,
> +			     const char *buf,
> +			     size_t len)
> +{
> +	unsigned long value;
> +	struct ir_input_dev *ir_dev =3D dev_get_drvdata(d);
> +	struct decoder_data *data =3D get_decoder_data(ir_dev);
> +
> +	if (!data)
> +		return -EINVAL;
> +
> +	if (strict_strtoul(buf, 10, &value) || value > 1)
> +		return -EINVAL;
> +
> +	data->enabled =3D value;
> +
> +	return len;
> +}
> +
> +static ssize_t show_enabled(struct device *d,
> +			     struct device_attribute *mattr, char *buf)
> +{
> +	struct ir_input_dev *ir_dev =3D dev_get_drvdata(d);
> +	struct decoder_data *data =3D get_decoder_data(ir_dev);
> +
> +	if (!data)
> +		return -EINVAL;
> +
> +	if (data->enabled)
> +		return sprintf(buf, "1\n");
> +	else
> +	return sprintf(buf, "0\n");
> +}
> +
> +static DEVICE_ATTR(enabled, S_IRUGO | S_IWUSR, show_enabled, store_e=
nabled);
> +
> +static struct attribute *decoder_attributes[] =3D {
> +	&dev_attr_enabled.attr,
> +	NULL
> +};
> +
> +static struct attribute_group decoder_attribute_group =3D {
> +	.name	=3D "rc6_decoder",
> +	.attrs	=3D decoder_attributes,
> +};
> +
> +static enum rc6_mode rc6_mode(struct decoder_data *data) {
> +	switch (data->header & RC6_MODE_MASK) {
> +	case 0:
> +		return RC6_MODE_0;
> +	case 6:
> +		if (!data->toggle)
> +			return RC6_MODE_6A;
> +		/* fall through */
> +	default:
> +		return RC6_MODE_UNKNOWN;
> +	}
> +}
> +
> +/**
> + * ir_rc6_decode() - Decode one RC6 pulse or space
> + * @input_dev:	the struct input_dev descriptor of the device
> + * @duration:	duration of pulse/space in ns
> + *
> + * This function returns -EINVAL if the pulse violates the state mac=
hine
> + */
> +static int ir_rc6_decode(struct input_dev *input_dev, s64 duration)
> +{
> +	struct decoder_data *data;
> +	struct ir_input_dev *ir_dev =3D input_get_drvdata(input_dev);
> +	u32 scancode;
> +	u8 toggle;
> +	int u;
> +
> +	data =3D get_decoder_data(ir_dev);
> +	if (!data)
> +		return -EINVAL;
> +
> +	if (!data->enabled)
> +		return 0;
> +
> +	if (IS_RESET(duration)) {
> +		data->state =3D STATE_INACTIVE;
> +		return 0;
> +	}
> +
> +	u =3D  TO_UNITS(duration, RC6_UNIT);
> +	if (DURATION(u) =3D=3D 0)
> +		goto out;
> +
> +again:
> +	IR_dprintk(2, "RC6 decode started at state %i (%i units, %ius)\n",
> +		   data->state, u, TO_US(duration));
> +
> +	if (DURATION(u) =3D=3D 0 && data->state !=3D STATE_FINISHED)
> +		return 0;

Isn't there a better way to structure the logic to break up two adjacen=
t
pulse units than with goto's out of the switch back up to here?

A do {} while() loop would have been much clearer.



> +	switch (data->state) {
> +
> +	case STATE_INACTIVE:
> +		if (u >=3D RC6_PREFIX_PULSE - 1 && u <=3D RC6_PREFIX_PULSE + 1) {
> +			data->state =3D STATE_PREFIX_SPACE;
> +			data->count =3D 0;
> +			return 0;
> +		}
> +		break;
> +
> +	case STATE_PREFIX_SPACE:
> +		if (u =3D=3D RC6_PREFIX_SPACE) {
> +			data->state =3D STATE_HEADER_BIT_START;
> +			return 0;
> +		}
> +		break;
> +
> +	case STATE_HEADER_BIT_START:
> +		if (DURATION(u) =3D=3D 1) {
> +			data->header <<=3D 1;
> +			if (IS_PULSE(u))
> +				data->header |=3D 1;
> +			data->count++;
> +			data->last_unit =3D u;
> +			data->state =3D STATE_HEADER_BIT_END;
> +			return 0;
> +		}
> +		break;
> +
> +	case STATE_HEADER_BIT_END:
> +		if (IS_TRANSITION(u, data->last_unit)) {
> +			if (data->count =3D=3D RC6_HEADER_NBITS)
> +				data->state =3D STATE_TOGGLE_START;
> +			else
> +				data->state =3D STATE_HEADER_BIT_START;
> +
> +			DECREASE_DURATION(u, 1);
> +			goto again;
> +		}
> +		break;
> +
> +	case STATE_TOGGLE_START:
> +		if (DURATION(u) =3D=3D 2) {
> +			data->toggle =3D IS_PULSE(u);
> +			data->last_unit =3D u;
> +			data->state =3D STATE_TOGGLE_END;
> +			return 0;
> +		}
> +		break;
> +
> +	case STATE_TOGGLE_END:
> +		if (IS_TRANSITION(u, data->last_unit) && DURATION(u) >=3D 2) {
> +			data->state =3D STATE_BODY_BIT_START;
> +			data->last_unit =3D u;
> +			DECREASE_DURATION(u, 2);
> +			data->count =3D 0;
> +
> +			if (!(data->header & RC6_STARTBIT_MASK)) {
> +				IR_dprintk(1, "RC6 invalid start bit\n");
> +				break;
> +			}
> +
> +			switch (rc6_mode(data)) {
> +			case RC6_MODE_0:
> +				data->wanted_bits =3D RC6_0_NBITS;
> +				break;
> +			case RC6_MODE_6A:
> +				/* This might look weird, but we basically
> +				   check the value of the first body bit to
> +				   determine the number of bits in mode 6A */

This bit basically only tells you the length of the customer code: 7 or
15 bits. =20


> +				if ((DURATION(u) =3D=3D 0 && IS_SPACE(data->last_unit)) || DURAT=
ION(u) > 0)
> +					data->wanted_bits =3D RC6_6A_LARGE_NBITS;
> +				else
> +					data->wanted_bits =3D RC6_6A_SMALL_NBITS;
> +				break;
> +			default:
> +				IR_dprintk(1, "RC6 unknown mode\n");
> +				goto out;
> +			}
> +			goto again;
> +		}
> +		break;
> +
> +	case STATE_BODY_BIT_START:
> +		if (DURATION(u) =3D=3D 1) {
> +			data->body <<=3D 1;
> +			if (IS_PULSE(u))
> +				data->body |=3D 1;
> +			data->count++;
> +			data->last_unit =3D u;
> +
> +			/*
> +			 * If the last bit is one, a space will merge
> +			 * with the silence after the command.
> +			 */
> +			if (IS_PULSE(u) && data->count =3D=3D data->wanted_bits) {
> +				data->state =3D STATE_FINISHED;
> +				goto again;
> +			}
> +
> +			data->state =3D STATE_BODY_BIT_END;
> +			return 0;
> +		}
> +		break;
> +
> +	case STATE_BODY_BIT_END:
> +		if (IS_TRANSITION(u, data->last_unit)) {
> +			if (data->count =3D=3D data->wanted_bits)
> +				data->state =3D STATE_FINISHED;
> +			else
> +				data->state =3D STATE_BODY_BIT_START;
> +
> +			DECREASE_DURATION(u, 1);
> +			goto again;
> +		}
> +		break;
> +
> +	case STATE_FINISHED:
> +		switch (rc6_mode(data)) {
> +		case RC6_MODE_0:
> +			scancode =3D data->body & 0xffff;
> +			toggle =3D data->toggle;
> +			IR_dprintk(1, "RC6(0) scancode 0x%04x (toggle: %u)\n",
> +				   scancode, toggle);
> +			break;
> +		case RC6_MODE_6A:
> +			if (data->wanted_bits =3D=3D RC6_6A_LARGE_NBITS) {
> +				toggle =3D data->body & RC6_6A_MCE_TOGGLE_MASK ? 1 : 0;
> +				scancode =3D data->body & ~RC6_6A_MCE_TOGGLE_MASK;

Technically this depends on the OEM.  In reality, every RC6 Mode 6A
remote that wants to work with Microsoft stock drivers will likely use
this bit as a toggle.

Regards,
Andy

> +			} else {
> +				toggle =3D 0;
> +				scancode =3D data->body & 0xffffff;
> +			}
> +
> +			IR_dprintk(1, "RC6(6A) scancode 0x%08x (toggle: %u)\n",
> +				   scancode, toggle);
> +			break;
> +		default:
> +			IR_dprintk(1, "RC6 unknown mode\n");
> +			goto out;
> +		}
> +
> +		ir_keydown(input_dev, scancode, toggle);
> +		data->state =3D STATE_INACTIVE;
> +		return 0;
> +	}
> +
> +out:
> +	IR_dprintk(1, "RC6 decode failed at state %i (%i units, %ius)\n",
> +		   data->state, u, TO_US(duration));
> +	data->state =3D STATE_INACTIVE;
> +	return -EINVAL;
> +}
> +
> +static int ir_rc6_register(struct input_dev *input_dev)
> +{
> +	struct ir_input_dev *ir_dev =3D input_get_drvdata(input_dev);
> +	struct decoder_data *data;
> +	int rc;
> +
> +	rc =3D sysfs_create_group(&ir_dev->dev.kobj, &decoder_attribute_gro=
up);
> +	if (rc < 0)
> +		return rc;
> +
> +	data =3D kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data) {
> +		sysfs_remove_group(&ir_dev->dev.kobj, &decoder_attribute_group);
> +		return -ENOMEM;
> +	}
> +
> +	data->ir_dev =3D ir_dev;
> +	data->enabled =3D 1;
> +
> +	spin_lock(&decoder_lock);
> +	list_add_tail(&data->list, &decoder_list);
> +	spin_unlock(&decoder_lock);
> +
> +	return 0;
> +}
> +
> +static int ir_rc6_unregister(struct input_dev *input_dev)
> +{
> +	struct ir_input_dev *ir_dev =3D input_get_drvdata(input_dev);
> +	static struct decoder_data *data;
> +
> +	data =3D get_decoder_data(ir_dev);
> +	if (!data)
> +		return 0;
> +
> +	sysfs_remove_group(&ir_dev->dev.kobj, &decoder_attribute_group);
> +
> +	spin_lock(&decoder_lock);
> +	list_del(&data->list);
> +	spin_unlock(&decoder_lock);
> +
> +	return 0;
> +}
> +
> +static struct ir_raw_handler rc6_handler =3D {
> +	.decode		=3D ir_rc6_decode,
> +	.raw_register	=3D ir_rc6_register,
> +	.raw_unregister	=3D ir_rc6_unregister,
> +};
> +
> +static int __init ir_rc6_decode_init(void)
> +{
> +	ir_raw_handler_register(&rc6_handler);
> +
> +	printk(KERN_INFO "IR RC6 protocol handler initialized\n");
> +	return 0;
> +}
> +
> +static void __exit ir_rc6_decode_exit(void)
> +{
> +	ir_raw_handler_unregister(&rc6_handler);
> +}
> +
> +module_init(ir_rc6_decode_init);
> +module_exit(ir_rc6_decode_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("David H=C3=A4rdeman <david@hardeman.nu>");
> +MODULE_DESCRIPTION("RC6 IR protocol decoder");
> diff --git a/drivers/media/IR/ir-sysfs.c b/drivers/media/IR/ir-sysfs.=
c
> index a222d4f..d7ec973 100644
> --- a/drivers/media/IR/ir-sysfs.c
> +++ b/drivers/media/IR/ir-sysfs.c
> @@ -60,6 +60,8 @@ static ssize_t show_protocol(struct device *d,
>  		s =3D "pulse-distance";
>  	else if (ir_type =3D=3D IR_TYPE_NEC)
>  		s =3D "nec";
> +	else if (ir_type =3D=3D IR_TYPE_RC6)
> +		s =3D "rc6";
>  	else
>  		s =3D "other";
> =20
> diff --git a/include/media/rc-map.h b/include/media/rc-map.h
> index 3b7fe5a..11f6618 100644
> --- a/include/media/rc-map.h
> +++ b/include/media/rc-map.h
> @@ -15,6 +15,7 @@
>  #define IR_TYPE_RC5	(1  << 0)	/* Philips RC5 protocol */
>  #define IR_TYPE_PD	(1  << 1)	/* Pulse distance encoded IR */
>  #define IR_TYPE_NEC	(1  << 2)
> +#define IR_TYPE_RC6	(1  << 3)	/* Philips RC6 protocol */
>  #define IR_TYPE_OTHER	(1u << 31)
> =20
>  struct ir_scancode {
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-media=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
