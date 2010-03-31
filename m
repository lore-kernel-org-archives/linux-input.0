From: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: Re: [RFC] What are the goals for the architecture of an in-kernel
 IR system?
Date: Wed, 31 Mar 2010 03:01:56 -0300
Message-ID: <4BB2E554.6030308@redhat.com>
References: <9e4733910912151229o371ee017tf3640d8f85728011@mail.gmail.com> <20091215203300.GL24406@elf.ucw.cz> <9e4733910912151245ne442a5dlcfee92609e364f70@mail.gmail.com> <9e4733910912151338n62b30af5i35f8d0963e6591c@mail.gmail.com> <4BAB7659.1040408@redhat.com> <20100326112755.GB5387@hardeman.nu> <4BACC769.6020906@redhat.com> <20100326160150.GA28804@core.coreip.homeip.net> <4BAFE4B7.2030204@redhat.com> <4BAFF985.3090703@redhat.com> <20100330110138.GA6164@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:17191 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932376Ab0CaGC6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 31 Mar 2010 02:02:58 -0400
In-Reply-To: <20100330110138.GA6164@hardeman.nu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jon Smirl <jonsmirl@gmail.com>, Pavel Machek <pavel@ucw.cz>, Krzysztof Halasa <khc@pm.waw.pl>

David H=E4rdeman wrote:
> On Sun, Mar 28, 2010 at 09:51:17PM -0300, Mauro Carvalho Chehab wrote=
:
>> I spoke too soon... removing the index causes a problem at the read =
ioctl: there's no way
>> to retrieve just the non-sparsed values.
>>
>> There's one solution that would allow both read/write and compat to =
work nicely,
>> but the API would become somewhat asymmetrical:
>>
>> At get (EVIOCGKEYCODEBIG):
>> 	use index/len as input and keycode/scancode as output;
>>
>> At set (EVIOCSKEYCODEBIG):
>> 	use scancode/keycode/len as input (and, optionally, index as output=
).
>>
>=20
> This was exactly the approach I had in mind when I suggested using=20
> indexes.

Doesn't work perfectly. The asymmetry has a side effect on the internal=
 logic:=20

EVIOCGKEYCODEBIG should be implemented with a pseudo-code like:
	kt_entry =3D getkeycodebig_from_index(index);

EVIOCSKEYCODEBIG should be implemented with a pseudo-code like:
	kt_entry =3D getkeycodebig_from_scan(scan, len);
	old_key =3D kt_entry->keycode;

	kt_entry->keycode =3D newkey;
	if (setkeycodebig(kt_entry) =3D=3D 0)
		keyup(old_key);

As you see, the input parameters for the getkeycodebig*() are different=
=2E

So, this approach requires 3 ops instead of 2. Yet, as scancode->keycod=
e is
needed anyway, this doesn't actually hurts.

I just added the patches that implement those two ioctls on my IR devel=
opment tree.
I tested only the original EVIOCGKEYCODE/EVIOSGKEYCODE and calling a cl=
ear_table
function using EVIOCSKEYCODEBIG via emulation.

My next step is to test the remaining ir-keytable functions via emulati=
on, and then
implement the *BIG ioctls at ir-core, for testing.

I haven't test yet the *keycode*default methods.=20

After having it fully tested, I'll submit the complete input ioctl patc=
h via ML.

--=20

Cheers,
Mauro
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
