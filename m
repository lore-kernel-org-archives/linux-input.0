From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Support for Stantum multitouch panel
Date: Thu, 10 Dec 2009 10:28:44 -0800
Message-ID: <20091210182844.GC23717@core.coreip.homeip.net>
References: <20091209214928.1E24D9520C@smtp.lii-enac.fr> <20091209231516.GF10138@core.coreip.homeip.net> <25E41E82-8D85-43DB-A47C-4F7FBDA0293F@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:37251 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760874AbZLJS2t (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Dec 2009 13:28:49 -0500
Received: by pxi27 with SMTP id 27so98095pxi.4
        for <linux-input@vger.kernel.org>; Thu, 10 Dec 2009 10:28:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <25E41E82-8D85-43DB-A47C-4F7FBDA0293F@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?St=E9phane?= Chatty <chatty@enac.fr>
Cc: linux-input@vger.kernel.org, Rafi Rubin <rafi@seas.upenn.edu>, Benjamin Tissoires <tissoire@cena.fr>, Peter Hutterer <peter.hutterer@who-t.net>

On Thu, Dec 10, 2009 at 08:37:39AM +0100, St=E9phane Chatty wrote:
>
> Le 10 d=E9c. 09 =E0 00:15, Dmitry Torokhov a =E9crit :
>
>> Hi Stephane,
>>
>> On Wed, Dec 09, 2009 at 10:49:28PM +0100, Stephane Chatty wrote:
>>> +
>>> +	if (emulate_touchscreen) {
>>> +		if (sd->first) {
>>> +			if (!sd->activity) {
>>> +				input_event(input, EV_KEY, BTN_TOUCH, 1);
>>> +				sd->activity =3D 1;
>>> +			}
>>> +			input_event(input, EV_ABS, ABS_X, sd->x);
>>> +			input_event(input, EV_ABS, ABS_Y, sd->y);
>>> +		}
>>> +	}
>>
>> Why are you doing the above conditionally? Just report it always - =20
>> less
>> setup required for the user.
>
> As regards setup, the emulate_touchscreen parameter is 1 by default s=
o=20
> that users don't have to care about it. But I felt compelled to have =
this=20
> parameter because the ongoing work on X.org suggests that there might=
 be=20
> a problem in upper layers with having duplicate information flows. Fo=
r=20
> instant, if we associate a slave pointer (MPX terminology) to every=20
> ABS_MT_X/ABS_MT_Y flow, the ABS_X/ABS_Y will come as an additional fl=
ow=20
> and we'll need to do something to ignore it. Benjamin, Peter, what do=
 you=20
> think?

I thought Henrik's idea was that driver should use either classic or
multitouch events from the data stream but not both. This way users
could either use old, non-multitouch-aware drivers or newer ones withou=
t
issues.



>
> Also, some devices (especially the N-Trig) do not make it possible to=
 =20
> implement a single touch emulation because they have no finger tracki=
ng=20
> (IDs change over time, you never know which finger to use and the cur=
sor=20
> would jump from one to the other randomly). Therefore, I did not feel=
=20
> like creating a new "standard" behaviour that will be broken by such=20
> devices.

If driver can't support something then it smply won't provide such
events at all and users that require certain capability will simply
ignore devices that don't provide it.

>
> Actually, Rafi Rubin and I have started to discuss the idea of splitt=
ing=20
> this into two input nodes: a pure multitouch device and a pure single=
=20
> touch emulation. I'd like to have feedback on this idea too, even if =
I=20
> have no time to work on it yet.

If you create 2 devices basically supplying the same data then it will
be harder for consumers to select between them and drivers. I.e. if
single device transmits entire state then it is easy to write hotplug
policy for say X server (using udev/hal) such as:

	- this box always uses evdev for everything, or
	- devices with nultitouch capabilities use new multitouch
	  X driver, the rest use evdev.

This will be harder if there were 2 "copies" of multitouch devices
because we'd have to be able to recognize "siblings" and ignore one or
the other.

Does this make sense?

If there is a concern about too many unused events reaching userspace -
then we need to implement subscription model in evdev where consumer ca=
n
specify list of events it is interested in and have input core deliver
only those. I'll take patches ;)

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
