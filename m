From: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: Re: [RFC] What are the goals for the architecture of an in-kernel
 IR 	system?
Date: Fri, 26 Mar 2010 11:40:41 -0300
Message-ID: <4BACC769.6020906@redhat.com>
References: <20091215115011.GB1385@ucw.cz> <4B279017.3080303@redhat.com> <20091215195859.GI24406@elf.ucw.cz> <9e4733910912151214n68161fc7tca0ffbf34c2c4e4@mail.gmail.com> <20091215201933.GK24406@elf.ucw.cz> <9e4733910912151229o371ee017tf3640d8f85728011@mail.gmail.com> <20091215203300.GL24406@elf.ucw.cz> <9e4733910912151245ne442a5dlcfee92609e364f70@mail.gmail.com> <9e4733910912151338n62b30af5i35f8d0963e6591c@mail.gmail.com> <4BAB7659.1040408@redhat.com> <20100326112755.GB5387@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36160 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751878Ab0CZOl0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Mar 2010 10:41:26 -0400
In-Reply-To: <20100326112755.GB5387@hardeman.nu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>, Jon Smirl <jonsmirl@gmail.com>, Pavel Machek <pavel@ucw.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Krzysztof Halasa <khc@pm.waw.pl>

David H=E4rdeman wrote:
> On Thu, Mar 25, 2010 at 11:42:33AM -0300, Mauro Carvalho Chehab wrote=
:
>>>        10) extend keycode table replacement to support big/variable=
=20
>>>        sized scancodes;
>> Pending.
>>
>> The current limit here is the scancode ioctl's are defined as:
>>
>> #define EVIOCGKEYCODE           _IOR('E', 0x04, int[2])             =
    /* get keycode */
>> #define EVIOCSKEYCODE           _IOW('E', 0x04, int[2])             =
    /* set keycode */
>>
>> As int size is 32 bits, and we must pass both 64 (or even bigger) sc=
ancodes, associated
>> with a keycode, there's not enough bits there for IR.
>>
>> The better approach seems to create an struct with an arbitrary long=
 size, like:
>>
>> struct keycode_table_entry {
>> 	unsigned keycode;
>> 	char scancode[32];	/* 32 is just an arbitrary long array - maybe sh=
orter */
>> 	int len;
>> }
>>
>> and re-define the ioctls. For example we might be doing:
>>
>> #define EVIOCGKEYCODEBIG           _IOR('E', 0x04, struct keycode_ta=
ble_entry)
>> #define EVIOCSKEYCODEBIG           _IOW('E', 0x04, struct keycode_ta=
ble_entry)
>> #define EVIOCLEARKEYCODEBIG        _IOR('E', 0x04, void)
>>
>> Provided that the size for struct keycode_table_entry is different, =
_IO will generate
>> a different magic number for those.
>>
>> Or, instead of using 0x04, just use another sequential number at the=
 'E' namespace.
>>
>> An specific function to clear the table is needed with big scancode =
space,
>> as already discussed.
>>
>=20
> I'd suggest:
>=20
> struct keycode_table_entry {
> 	unsigned keycode;
> 	unsigned index;
> 	unsigned len;
> 	char scancode[];
> };
>=20
> Use index in EVIOCGKEYCODEBIG to look up a keycode (all other fields =
are=20
> ignored), that way no special function to clear the table is necessar=
y,=20
> instead you do a loop with:
>=20
> EVIOCGKEYCODEBIG (with index 0)
> EVIOCSKEYCODEBIG (with the returned struct from EVIOCGKEYCODEBIG and
> 		  keycode =3D KEY_RESERVED)
>=20
> until EVIOCGKEYCODEBIG returns an error.

Makes sense.

> This also allows you to get all the current mappings from the kernel=20
> without having to blindly search through an arbitrarily large keyspac=
e.
>=20
> Also, EVIOCLEARKEYCODEBIG should be:
>=20
> #define EVIOCLEARKEYCODEBIG _IOR('E', 0x04, struct keycode_table_entr=
y)
>=20
> That way a user space application can simply call EVIOCLEARKEYCODEBIG=
,=20
> ask the user for an appropriate keycode, fill in the keycode member o=
f=20
> the struct returned from EVIOCLEARKEYCODEBIG and call EVIOCSKEYCODEBI=
G.

By using the index concept, I don't think we need another ioctl. Also,
there's no way for kernel to handle it, as it will be using the same
magic number of EVIOCGKEYCODEBIG.

> On a related note, I really think the interface would benefit from=20
> allowing more than one keytable per irrcv device with an input device=
=20
> created per keytable. That way you can have one input device per remo=
te=20
> control. This implies that EVIOCLEARKEYCODEBIG is a bit misplaced as =
an=20
> evdev IOCTL since there's an N-1 mapping between input devices and ir=
rcv=20
> devices.

I don't think that an ioctl over one /dev/input/event should be the pro=
per way
to ask kernel to create another filtered /dev/input/event. As it were c=
ommented
that the multimedia keys on some keyboards could benefit on having a fi=
lter
capability, maybe we may have a sysfs node at class input that would al=
low
the creation/removal of the filtered event interface.

>=20
> ioctl's to set/get keycodes for ir should also take a flag parameter =
in=20
> the struct to allow special properties to be set/returned for a given=
=20
> keycode mapping (I'm thinking of keycodes which powers on the compute=
r=20
> for instance, that should be exposed to userspace somehow).
>=20
> With all of that, the struct might need to be something like:
>=20
> struct keycode_table_entry {
> 	unsigned keycode; /* e.g. KEY_A */
> 	unsigned table;   /* Table index, for multiple keytables */
> 	unsigned index;   /* Index in the given keytable */
> 	unsigned flags;   /* For additional functionality */
> 	unsigned len;     /* Of the struct */
> 	char scancode[];  /* Per-protocol scancode data follows */
> };
>=20

I don't see the need for a table index. If we have 3 input event interf=
aces
for a given IR, each will have its own private keycode table.

> Finally, I think irrcv should create a chardev of its own with ioctl'=
s=20
> like EVIOCLEARKEYCODEBIG (and RX/TX parameter setting ioctl's).  The=20
> same chardev can be used for IR blasting (by writing data to it once =
TX=20
> parameters have been set).

There are several different things mixed above. It may be a good idea
to allow extending the ioctls from the input event device to other inpu=
t
classes. Yet, I'm currently not seeing any usage for it.

In the specific case of EVIOCGKEYCODEBIG/EVIOCSKEYCODEBIG, those are ne=
eded
for all input devices whose scancode is bigger than 32 bits. It is not
specific to IR.

I don't think we need to add ioctl's to change RX/TX parameters. The be=
tter
is to do it via sysfs. I've added yesterday one of such parameter for t=
he
nec IR decoder, allowing enabling/disabling the decoder, per irrcv:

http://git.linuxtv.org/mchehab/ir.git?a=3Dcommit;h=3Db763c070b038cfd7cc=
5f7f7109039f5d9f995c46

When porting the RC-5 decoder from saa7134, two additional parameters w=
ill be
needed, in order to preserve the current features.

The IR tx is a different thing. It should be implemented as a separate =
device.

--=20

Cheers,
Mauro
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
