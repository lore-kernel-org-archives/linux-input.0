From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: hid-pidff bug: fails to find all required reports of saitek
 gamepad
Date: Fri, 13 Feb 2009 21:43:00 +0200
Message-ID: <4995CD44.5000808@gmail.com>
References: <78f5d6bf0901301145g591a713agc8aafa66fe27b19f@mail.gmail.com>	 <49871663.4060605@gmail.com>	 <78f5d6bf0902021029g7e53f16ble27500b52f9498ba@mail.gmail.com>	 <498D7E81.4060007@gmail.com>	 <78f5d6bf0902092146x2abaf45an79e4546e75a80356@mail.gmail.com>	 <4991A622.7020101@gmail.com>	 <78f5d6bf0902110112o434d43d3ycd473c7b803e8297@mail.gmail.com>	 <4992FC79.80106@gmail.com>	 <78f5d6bf0902121006r460ba8d6m61126af161358c19@mail.gmail.com>	 <49946D7A.408@gmail.com> <78f5d6bf0902130033k7d0089cfo857bb48a19da1630@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mta-out.inet.fi ([195.156.147.13]:47976 "EHLO kirsi1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752182AbZBMTnF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Feb 2009 14:43:05 -0500
In-Reply-To: <78f5d6bf0902130033k7d0089cfo857bb48a19da1630@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitriy Geels <dmitriy.geels@gmail.com>
Cc: linux-input@vger.kernel.org

Dmitriy Geels wrote:
> 2009/2/12 Anssi Hannula <anssi.hannula@gmail.com>:
>>> Just rumble. There is only one motor inside. For constant effect motor
>>> spins with constant speed, as I understood, this speed is controlled
>>> by magnitude. Also it is a place for report fixup: magnitude logical
>>> values are -127/127, but actually 1/255 -- 255 is strongest.
>> Hmm, so it is just rumble ( = periodic), not constant force. But what do the
>> periodic effects do then, if constant is rumble? Normally periodic effects
>> represent various types of rumble.
> Not exactly periodic, but same effect may be achieved using periodic
> effect with 0 period.
> This constant effect sets constant motor speed (and also could be more
> powerful, than periodic).
> Periodic effects control motor speed using effect type and parameters,
> so speed amplitude graph is sinusoidal or saw-like.

Okay, so periodic effects are also different than what they are supposed
to be. Saw-like etc define the force direction/magnitude (e.g. saw-like:
the joystick increasingly pulls to one direction, then stops suddenly
and starts doing it again; this happens quite quickly of course).

Basically this is a simple rumble device somewhat adapted into the PID
model.

The best we can do is define constant force as FF_RUMBLE and pretend
periodic is FF_PERIODIC.

> Envelope for constant effect controls effect playback begin and end.

That is what it is supposed to do.

> For periodic effects it controls every period, as I understood.

That is not supposed to be the case and seems very strange. Can you
confirm this (maybe after we get it working on linux)?

>>> I tried this, no result.
>>> I think, this problem is connected somehow to log message about
>>> maxusage and report_count do not match.
>> It is not related to those. I see two likely reasons:
>> 1) Device needs more initialization; in the dump we see a "Actuators Enable"
>> command sent first, and then the vendor report 64 three times with various
>> data.
> May be. I'll try to find some other PID drivers for windows to see if
> it will work without vendor reports.
> 
>> 2) Reports 21+22 are transmitted as control transfers in the dump. I'll have
>> to check whether we are doing the same.
> We do: http://paste.org.ru/index.pl?iyvkmg
> Got this log with patch: http://paste.org.ru/index.pl?m4wauv

Notice the difference in length of report 22 on windows and linux. Try
this in pidff_init():
pidff->reports[PID_BLOCK_LOAD]->size += 8;

-- 
Anssi Hannula
