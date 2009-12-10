From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH 2/2] Support for Stantum multitouch panel
Date: Thu, 10 Dec 2009 14:28:10 -0500
Message-ID: <4B214BCA.5080403@seas.upenn.edu>
References: <20091209214928.1E24D9520C@smtp.lii-enac.fr> <20091209231516.GF10138@core.coreip.homeip.net> <25E41E82-8D85-43DB-A47C-4F7FBDA0293F@enac.fr> <20091210182844.GC23717@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stag.seas.upenn.edu ([158.130.70.79]:60784 "EHLO
	stag.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761435AbZLJTmc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Dec 2009 14:42:32 -0500
In-Reply-To: <20091210182844.GC23717@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>, linux-input@vger.kernel.org, Benjamin Tissoires <tissoire@cena.fr>, Peter Hutterer <peter.hutterer@who-t.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/10/09 13:28, Dmitry Torokhov wrote:
> On Thu, Dec 10, 2009 at 08:37:39AM +0100, St=E9phane Chatty wrote:
>>
>> Le 10 d=E9c. 09 =E0 00:15, Dmitry Torokhov a =E9crit :
>>
>>> Hi Stephane,
>>>
>>> On Wed, Dec 09, 2009 at 10:49:28PM +0100, Stephane Chatty wrote:
>>>> +
>>>> +	if (emulate_touchscreen) {
>>>> +		if (sd->first) {
>>>> +			if (!sd->activity) {
>>>> +				input_event(input, EV_KEY, BTN_TOUCH, 1);
>>>> +				sd->activity =3D 1;
>>>> +			}
>>>> +			input_event(input, EV_ABS, ABS_X, sd->x);
>>>> +			input_event(input, EV_ABS, ABS_Y, sd->y);
>>>> +		}
>>>> +	}
>>>
>>> Why are you doing the above conditionally? Just report it always - =
=20
>>> less
>>> setup required for the user.
>>
>> As regards setup, the emulate_touchscreen parameter is 1 by default =
so=20
>> that users don't have to care about it. But I felt compelled to have=
 this=20
>> parameter because the ongoing work on X.org suggests that there migh=
t be=20
>> a problem in upper layers with having duplicate information flows. F=
or=20
>> instant, if we associate a slave pointer (MPX terminology) to every=20
>> ABS_MT_X/ABS_MT_Y flow, the ABS_X/ABS_Y will come as an additional f=
low=20
>> and we'll need to do something to ignore it. Benjamin, Peter, what d=
o you=20
>> think?
>=20
> I thought Henrik's idea was that driver should use either classic or
> multitouch events from the data stream but not both. This way users
> could either use old, non-multitouch-aware drivers or newer ones with=
out
> issues.

How far are we from decent user-space support for multi-touch devices? =
 If we can expect that to solidify in the near future,
perhaps we'd be better off migrating away from conventional touchscreen=
/single point digitizer behavior.

>>
>> Also, some devices (especially the N-Trig) do not make it possible t=
o =20
>> implement a single touch emulation because they have no finger track=
ing=20
>> (IDs change over time, you never know which finger to use and the cu=
rsor=20
>> would jump from one to the other randomly). Therefore, I did not fee=
l=20
>> like creating a new "standard" behaviour that will be broken by such=
=20
>> devices.
>=20
> If driver can't support something then it smply won't provide such
> events at all and users that require certain capability will simply
> ignore devices that don't provide it.

In the case of the n-trig digitizer (with the latest firmware), single =
touch emulation can be reproduced by a relatively simple
tracking mechanism.  If we're talking about supporting dual mode driver=
s, would there be much objection to the cost of computation
in the kernel driver?

>>
>> Actually, Rafi Rubin and I have started to discuss the idea of split=
ting=20
>> this into two input nodes: a pure multitouch device and a pure singl=
e=20
>> touch emulation. I'd like to have feedback on this idea too, even if=
 I=20
>> have no time to work on it yet.
>=20
> If you create 2 devices basically supplying the same data then it wil=
l
> be harder for consumers to select between them and drivers. I.e. if
> single device transmits entire state then it is easy to write hotplug
> policy for say X server (using udev/hal) such as:
>=20
> 	- this box always uses evdev for everything, or
> 	- devices with nultitouch capabilities use new multitouch
> 	  X driver, the rest use evdev.
>=20
> This will be harder if there were 2 "copies" of multitouch devices
> because we'd have to be able to recognize "siblings" and ignore one o=
r
> the other.
>=20
> Does this make sense?

At the moment, the evdev and wacom drivers (the only two that I've used=
 for a digitizer), require specifying which device to use.  I
also have the memory (and I might just be miss-remembering) that the sy=
naptics driver finds an event dev on its own.  So as far as I
see it a single driver should be smart enough to select the device that=
 it prefers.

If we're worried about a discovery tool identifying both devs and assig=
ning appropriate drivers to each, could we not just export
names that indicate they are in fact the same device and let the tools =
select which to prefer?  It should be trivial for such tools
to select sanely.


That being said, I did at some point have a touchpad that was configure=
d such that I got events from both mice and an event dev, and
it was really annoying.

> If there is a concern about too many unused events reaching userspace=
 -
> then we need to implement subscription model in evdev where consumer =
can
> specify list of events it is interested in and have input core delive=
r
> only those. I'll take patches ;)

While that sounds tempting, it also could introduce a bit of a hazard. =
 Programmer A masks out events he doesn't need, then
programmer B starts coding up support for more features and is confound=
ed by the lack of response, and yet a hexdump of the dev
indicates the events are streaming.


On that note, how does one convince the input or hid core to emit an ev=
ent when the state hasn't actually changed?  I ran into that
when I was trying to inject device swaps for interleaved streams of tou=
ch and pen events.  Clearly I was attacking a symptom and
ignoring the real problem, but I'm still curious.

Rafi
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkshS8kACgkQwuRiAT9o60/G1ACgjYOiBoO4G/7aQqGM5I242+qL
nqEAmQHITeJrjaWPNZltwh/pQZV5IjEj
=3DX3Jl
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
