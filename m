From: Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: [PATCH RESEND] USB HID: Add ID for eGalax Multitouch used in
 JooJoo tablet
Date: Tue, 17 Aug 2010 11:56:02 +0200
Message-ID: <4C6A5CB2.6000603@bitmath.org>
References: <4C695985.5080403@bitmath.org> <BFCA5963-D589-434B-B07B-6899A794F28F@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from csmtp3.one.com ([91.198.169.23]:39046 "EHLO csmtp3.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751566Ab0HQJ4H (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Aug 2010 05:56:07 -0400
In-Reply-To: <BFCA5963-D589-434B-B07B-6899A794F28F@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: linux-input <linux-input@vger.kernel.org>

On 08/17/2010 09:49 AM, St=E9phane Chatty wrote:

>=20
> Le 16 ao=FBt 10 =E0 17:30, Henrik Rydberg a =E9crit :
>=20
>> St=E9phane, Jiri,
>>
>> Regarding the several-hid-packets-per-actual-input-packet problem,
>> what do you
>> think about constructing a special MT HID device, using raw_event? I=
t
>> could
>> encapsulate the current protocol a bit better and use the full HID
>> extension.
>>
>=20
> Hi Henrik
>=20
> This sounds like as a interesting direction for building a generic
> driver for MT devices. However, there still are device specificities
> that we need to deal with:
>  - the serial/parallel/hybrid issue, for which we have ideas but stil=
l
> nothing firm;


Not quite firm, but not too far from it either, IMO. Given that the hid=
-mt
device and its drivers handle all input device interaction, the idea is=
 to
implement the details of the digitizer extension, such as hybrid mode, =
in the
hid-mt device.

>  - some devices need to be set in multitouch mode; we need some resea=
rch
> to find out if this can be determined automatically from the report
> descriptors;


We could start off assuming all devices are different in this regard, a=
nd slowly
work our way towards unification.

>  - the single touch emulation is highly device dependent. I was (and
> still am) pretty proud of my choice of tracking the 'oldest' finger o=
n
> the panel: this turns multitouch panels into single touch panels that
> are impervious to parasite touches. But the drawback is that currentl=
y
> there is no generic method for this tracking: I used whatever
> device-specific information I could use (order of fingers in a messag=
e,
> tracking id, etc).


Ah yes, the pointer emulation via ABS_X/Y. My personal view is that poi=
nter
emulation is a gesture, and thus best implemented in userspace. During
multi-finger gestures, the pointer should either not move, or be hidden=
=2E The
majority of kernel drivers emit a BTN_TOUCH=3D=3D1 when the first finge=
r lands on
the surface, and a BTN_TOUCH=3D=3D0 when the last finger leaves the sur=
face. In
userspace, for touchscreens, the BTN_TOUCH event is traditionally mappe=
d to a
button press, which is not what you want during a gesture. Thus, the po=
inter
emulation logic has to be remapped in userspace, anyways.

=46or new drivers, it would be best not to implement BTN_TOUCH/ABS_X/Y =
at all.
Since most MT devices support legacy mouse mode out-of-the-box via HID,=
 perhaps
one can even argue that hid-mt does not _have_ to support ABS_X/Y. Or, =
to keep
compatibility, we could provide emulation code in hid-mt.

> As long as these issues are here, we still need a system for
> implementing device-specific behaviour. I must admit I was tempted to
> keep benefitting from the blacklist in hid-core.c until they are reso=
lved.


I agree. The implementation details I have in mind are to take the extr=
a
complexity involved using raw_event _once_, implement it in hid-mt, and=
 then
pass the digested events on to the specialized drivers. If done careful=
ly, I
imagine the changes to each individual driver to be fairly simple.

> An additional question is: how do we decide that a device is a
> multitouch one? Do we keep a list of devices? Or do we rely on a patt=
ern
> found in the report descriptors? In my view it would be great to have=
 a
> pattern matching system for identifying classes of input devices from
> report descriptors, but then it would reacher farther than multitouch=
 only.


This sounds like an interesting idea for future development, but I woul=
d say we
can continue to rely on the device list for now.

Cheers,
Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
