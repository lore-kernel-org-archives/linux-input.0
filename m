From: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: Re: [RFC] What are the goals for the architecture of an in-kernel
 IR system?
Date: Fri, 26 Mar 2010 14:22:51 -0300
Message-ID: <4BACED6B.9030409@redhat.com>
References: <20091215195859.GI24406@elf.ucw.cz> <9e4733910912151214n68161fc7tca0ffbf34c2c4e4@mail.gmail.com> <20091215201933.GK24406@elf.ucw.cz> <9e4733910912151229o371ee017tf3640d8f85728011@mail.gmail.com> <20091215203300.GL24406@elf.ucw.cz> <9e4733910912151245ne442a5dlcfee92609e364f70@mail.gmail.com> <9e4733910912151338n62b30af5i35f8d0963e6591c@mail.gmail.com> <4BAB7659.1040408@redhat.com> <20100326112755.GB5387@hardeman.nu> <4BACC769.6020906@redhat.com> <20100326160150.GA28804@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20100326160150.GA28804@core.coreip.homeip.net>
Sender: linux-media-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jon Smirl <jonsmirl@gmail.com>, Pavel Machek <pavel@ucw.cz>, Krzysztof Halasa <khc@pm.waw.pl>, hermann pitton <hermann-pitton@arcor.de>, Christoph Bartelmus <lirc@bartelmus.de>, awalls@radix.net, j@jannau.net, jarod@redhat.com, jarod@wilsonet.com, kraxel@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, superm1@ubuntu.com
List-Id: linux-input@vger.kernel.org

Dmitry Torokhov wrote:
> On Fri, Mar 26, 2010 at 11:40:41AM -0300, Mauro Carvalho Chehab wrote=
:
>> David H=E4rdeman wrote:
>>> On Thu, Mar 25, 2010 at 11:42:33AM -0300, Mauro Carvalho Chehab wro=
te:
>>>>>        10) extend keycode table replacement to support big/variab=
le=20
>>>>>        sized scancodes;
>>>> Pending.
>>>>
>>>> The current limit here is the scancode ioctl's are defined as:
>>>>
>>>> #define EVIOCGKEYCODE           _IOR('E', 0x04, int[2])           =
      /* get keycode */
>>>> #define EVIOCSKEYCODE           _IOW('E', 0x04, int[2])           =
      /* set keycode */
>>>>
>>>> As int size is 32 bits, and we must pass both 64 (or even bigger) =
scancodes, associated
>>>> with a keycode, there's not enough bits there for IR.
>>>>
>>>> The better approach seems to create an struct with an arbitrary lo=
ng size, like:
>>>>
>>>> struct keycode_table_entry {
>>>> 	unsigned keycode;
>>>> 	char scancode[32];	/* 32 is just an arbitrary long array - maybe =
shorter */
>>>> 	int len;
>>>> }
>>>>
>>>> and re-define the ioctls. For example we might be doing:
>>>>
>>>> #define EVIOCGKEYCODEBIG           _IOR('E', 0x04, struct keycode_=
table_entry)
>>>> #define EVIOCSKEYCODEBIG           _IOW('E', 0x04, struct keycode_=
table_entry)
>>>> #define EVIOCLEARKEYCODEBIG        _IOR('E', 0x04, void)
>>>>
>>>> Provided that the size for struct keycode_table_entry is different=
, _IO will generate
>>>> a different magic number for those.
>>>>
>>>> Or, instead of using 0x04, just use another sequential number at t=
he 'E' namespace.
>>>>
>>>> An specific function to clear the table is needed with big scancod=
e space,
>>>> as already discussed.
>>>>
>>> I'd suggest:
>>>
>>> struct keycode_table_entry {
>>> 	unsigned keycode;
>>> 	unsigned index;
>>> 	unsigned len;
>>> 	char scancode[];
>>> };
>>>
>>> Use index in EVIOCGKEYCODEBIG to look up a keycode (all other field=
s are=20
>>> ignored), that way no special function to clear the table is necess=
ary,=20
>>> instead you do a loop with:
>>>
>>> EVIOCGKEYCODEBIG (with index 0)
>>> EVIOCSKEYCODEBIG (with the returned struct from EVIOCGKEYCODEBIG an=
d
>>> 		  keycode =3D KEY_RESERVED)
>>>
>>> until EVIOCGKEYCODEBIG returns an error.
>> Makes sense.
>=20
> Yes, I think so too. Just need a nice way to handle transition, I'd
> like in the end to have drivers implement only the improved methods a=
nd
> map legacy methods in evdev.

Ok. I'll prepare the patches for adding the new ioctl, in a way that it=
 will
also handle the legacy methods, and post for review.

>>> On a related note, I really think the interface would benefit from=20
>>> allowing more than one keytable per irrcv device with an input devi=
ce=20
>>> created per keytable. That way you can have one input device per re=
mote=20
>>> control. This implies that EVIOCLEARKEYCODEBIG is a bit misplaced a=
s an=20
>>> evdev IOCTL since there's an N-1 mapping between input devices and =
irrcv=20
>>> devices.
>> I don't think that an ioctl over one /dev/input/event should be the =
proper way
>> to ask kernel to create another filtered /dev/input/event. As it wer=
e commented
>> that the multimedia keys on some keyboards could benefit on having a=
 filter
>> capability, maybe we may have a sysfs node at class input that would=
 allow
>> the creation/removal of the filtered event interface.
>=20
> No, if you want separate event devices just create a new instance of
> input device for every keymap and have driver/irrcv class route event=
s
> to proper input device.

This don't solve the issue about how to signalize to kernel that more t=
han one
input device is needed.=20

As the userspace will request the creation of those keymaps, we need so=
me way
to receive such requests from userspace.=20

I can see a few ways for doing it:

1) create a control device for the irrcv device as a hole,
that would handle such requests via ioctl (/dev/irctl[0-9]* ?)

2) create a read/write sysfs node that would indicate the number of eve=
nt/keymaps
associated with a given IR. By writing a bigger number, it would create=
 new devices.
By writing a smaller number, it will delete some maps. There's an issue=
 though:=20
what criteria would be used to delete? The newly created ones?

3) create a fixed number of event devices, and add a sysfs attribute to=
 enable
or disable it;

4) create a fixed number of sysfs attributes to represent the keymaps. =
=46or example:
/sys/class/irrcv/irrcv0/keymap0/enabled
	...
/sys/class/irrcv/irrcv0/keymap7/enabled

The input/event node will be created only when the enabled=3D1.

I don't like (2) or (3), because removing a table with (2) may end by r=
emoving the wrong
table, and (3) will create more event interfaces than probably needed b=
y the majority
of IR users.

maybe (4) is the better one.

--=20

Cheers,
Mauro
