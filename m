From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [RFC2] Teach drivers/media/IR/ir-raw-event.c to use durations
Date: Thu, 08 Apr 2010 10:07:18 -0300
Message-ID: <4BBDD506.1000202@infradead.org>
References: <20100407201835.GA8438@hardeman.nu> <4BBD6550.6030000@infradead.org> <20100408112305.GA2803@hardeman.nu> <4BBDC318.4040709@infradead.org> <20100408124315.GA21540@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20100408124315.GA21540@hardeman.nu>
Sender: linux-media-owner@vger.kernel.org
To: =?ISO-8859-1?Q?David_H=E4rdeman?= <david@hardeman.nu>
Cc: linux-input@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

David H=E4rdeman wrote:
> On Thu, Apr 08, 2010 at 08:50:48AM -0300, Mauro Carvalho Chehab wrote=
:
>>> -	size =3D sizeof(struct ir_raw_event) * MAX_IR_EVENT_SIZE * 2;
>>> -	size =3D roundup_pow_of_two(size);
>>> +	ir->raw->input_dev =3D input_dev;
>>> +	INIT_WORK(&ir->raw->rx_work, ir_raw_event_work);
>>>
>>> -	rc =3D kfifo_alloc(&ir->raw->kfifo, size, GFP_KERNEL);
>>> +	rc =3D kfifo_alloc(&ir->raw->kfifo, sizeof(int) * MAX_IR_EVENT_SI=
ZE,
>>> +			 GFP_KERNEL);
>> kfifo logic requires a power of two buffer to work, so, please keep =
the
>> original roundup_pow_of_two() logic, or add a comment before MAX_IR_=
EVENT_SIZE.
>=20
> No, kfifo_alloc() takes care of the rounding up. See the code for=20
> kfifo_alloc() in kernel/kfifo.c.
>=20
Ok.

--=20

Cheers,
Mauro
