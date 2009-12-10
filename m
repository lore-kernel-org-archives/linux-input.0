From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH 2/2] Support for Stantum multitouch panel
Date: Thu, 10 Dec 2009 08:37:39 +0100
Message-ID: <25E41E82-8D85-43DB-A47C-4F7FBDA0293F@enac.fr>
References: <20091209214928.1E24D9520C@smtp.lii-enac.fr> <20091209231516.GF10138@core.coreip.homeip.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:55785 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760550AbZLJHhq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Dec 2009 02:37:46 -0500
In-Reply-To: <20091209231516.GF10138@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Rafi Rubin <rafi@seas.upenn.edu>, Benjamin Tissoires <tissoire@cena.fr>, Peter Hutterer <peter.hutterer@who-t.net>


Le 10 d=E9c. 09 =E0 00:15, Dmitry Torokhov a =E9crit :

> Hi Stephane,
>
> On Wed, Dec 09, 2009 at 10:49:28PM +0100, Stephane Chatty wrote:
>> +
>> +	if (emulate_touchscreen) {
>> +		if (sd->first) {
>> +			if (!sd->activity) {
>> +				input_event(input, EV_KEY, BTN_TOUCH, 1);
>> +				sd->activity =3D 1;
>> +			}
>> +			input_event(input, EV_ABS, ABS_X, sd->x);
>> +			input_event(input, EV_ABS, ABS_Y, sd->y);
>> +		}
>> +	}
>
> Why are you doing the above conditionally? Just report it always - =20
> less
> setup required for the user.

As regards setup, the emulate_touchscreen parameter is 1 by default =20
so that users don't have to care about it. But I felt compelled to =20
have this parameter because the ongoing work on X.org suggests that =20
there might be a problem in upper layers with having duplicate =20
information flows. For instant, if we associate a slave pointer (MPX =20
terminology) to every ABS_MT_X/ABS_MT_Y flow, the ABS_X/ABS_Y will =20
come as an additional flow and we'll need to do something to ignore =20
it. Benjamin, Peter, what do you think?

Also, some devices (especially the N-Trig) do not make it possible to =20
implement a single touch emulation because they have no finger =20
tracking (IDs change over time, you never know which finger to use =20
and the cursor would jump from one to the other randomly). Therefore, =20
I did not feel like creating a new "standard" behaviour that will be =20
broken by such devices.

Actually, Rafi Rubin and I have started to discuss the idea of =20
splitting this into two input nodes: a pure multitouch device and a =20
pure single touch emulation. I'd like to have feedback on this idea =20
too, even if I have no time to work on it yet.

St.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
