From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Re: [RFC] What are the goals for the architecture of an in-kernel
 IR 	system?
Date: Fri, 26 Mar 2010 12:27:55 +0100
Message-ID: <20100326112755.GB5387@hardeman.nu>
References: <20091215115011.GB1385@ucw.cz>
 <4B279017.3080303@redhat.com>
 <20091215195859.GI24406@elf.ucw.cz>
 <9e4733910912151214n68161fc7tca0ffbf34c2c4e4@mail.gmail.com>
 <20091215201933.GK24406@elf.ucw.cz>
 <9e4733910912151229o371ee017tf3640d8f85728011@mail.gmail.com>
 <20091215203300.GL24406@elf.ucw.cz>
 <9e4733910912151245ne442a5dlcfee92609e364f70@mail.gmail.com>
 <9e4733910912151338n62b30af5i35f8d0963e6591c@mail.gmail.com>
 <4BAB7659.1040408@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:33280 "EHLO
	palpatine.hardeman.nu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090Ab0CZNXK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Mar 2010 09:23:10 -0400
Content-Disposition: inline
In-Reply-To: <4BAB7659.1040408@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: Jon Smirl <jonsmirl@gmail.com>, Pavel Machek <pavel@ucw.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Krzysztof Halasa <khc@pm.waw.pl>, hermann pitton <hermann-pitton@arcor.de>, Christoph Bartelmus <lirc@bartelmus.de>, awalls@radix.net, j@jannau.net, jarod@redhat.com, jarod@wilsonet.com, kraxel@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, superm1@ubuntu.com

On Thu, Mar 25, 2010 at 11:42:33AM -0300, Mauro Carvalho Chehab wrote:
> >        10) extend keycode table replacement to support big/variable=
=20
> >        sized scancodes;
>=20
> Pending.
>=20
> The current limit here is the scancode ioctl's are defined as:
>=20
> #define EVIOCGKEYCODE           _IOR('E', 0x04, int[2])              =
   /* get keycode */
> #define EVIOCSKEYCODE           _IOW('E', 0x04, int[2])              =
   /* set keycode */
>=20
> As int size is 32 bits, and we must pass both 64 (or even bigger) sca=
ncodes, associated
> with a keycode, there's not enough bits there for IR.
>=20
> The better approach seems to create an struct with an arbitrary long =
size, like:
>=20
> struct keycode_table_entry {
> 	unsigned keycode;
> 	char scancode[32];	/* 32 is just an arbitrary long array - maybe sho=
rter */
> 	int len;
> }
>
> and re-define the ioctls. For example we might be doing:
>=20
> #define EVIOCGKEYCODEBIG           _IOR('E', 0x04, struct keycode_tab=
le_entry)
> #define EVIOCSKEYCODEBIG           _IOW('E', 0x04, struct keycode_tab=
le_entry)
> #define EVIOCLEARKEYCODEBIG        _IOR('E', 0x04, void)
>=20
> Provided that the size for struct keycode_table_entry is different, _=
IO will generate
> a different magic number for those.
>=20
> Or, instead of using 0x04, just use another sequential number at the =
'E' namespace.
>=20
> An specific function to clear the table is needed with big scancode s=
pace,
> as already discussed.
>=20

I'd suggest:

struct keycode_table_entry {
	unsigned keycode;
	unsigned index;
	unsigned len;
	char scancode[];
};

Use index in EVIOCGKEYCODEBIG to look up a keycode (all other fields ar=
e=20
ignored), that way no special function to clear the table is necessary,=
=20
instead you do a loop with:

EVIOCGKEYCODEBIG (with index 0)
EVIOCSKEYCODEBIG (with the returned struct from EVIOCGKEYCODEBIG and
		  keycode =3D KEY_RESERVED)

until EVIOCGKEYCODEBIG returns an error.

This also allows you to get all the current mappings from the kernel=20
without having to blindly search through an arbitrarily large keyspace.

Also, EVIOCLEARKEYCODEBIG should be:

#define EVIOCLEARKEYCODEBIG _IOR('E', 0x04, struct keycode_table_entry)

That way a user space application can simply call EVIOCLEARKEYCODEBIG,=20
ask the user for an appropriate keycode, fill in the keycode member of=20
the struct returned from EVIOCLEARKEYCODEBIG and call EVIOCSKEYCODEBIG.

On a related note, I really think the interface would benefit from=20
allowing more than one keytable per irrcv device with an input device=20
created per keytable. That way you can have one input device per remote=
=20
control. This implies that EVIOCLEARKEYCODEBIG is a bit misplaced as an=
=20
evdev IOCTL since there's an N-1 mapping between input devices and irrc=
v=20
devices.

ioctl's to set/get keycodes for ir should also take a flag parameter in=
=20
the struct to allow special properties to be set/returned for a given=20
keycode mapping (I'm thinking of keycodes which powers on the computer=20
for instance, that should be exposed to userspace somehow).

With all of that, the struct might need to be something like:

struct keycode_table_entry {
	unsigned keycode; /* e.g. KEY_A */
	unsigned table;   /* Table index, for multiple keytables */
	unsigned index;   /* Index in the given keytable */
	unsigned flags;   /* For additional functionality */
	unsigned len;     /* Of the struct */
	char scancode[];  /* Per-protocol scancode data follows */
};

=46inally, I think irrcv should create a chardev of its own with ioctl'=
s=20
like EVIOCLEARKEYCODEBIG (and RX/TX parameter setting ioctl's).  The=20
same chardev can be used for IR blasting (by writing data to it once TX=
=20
parameters have been set).


--=20
David H=E4rdeman
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
