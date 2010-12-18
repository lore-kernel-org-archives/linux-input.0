From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 1/4] Input: synaptics - add multitouch packet support
Date: Sat, 18 Dec 2010 10:56:59 -0600
Message-ID: <AANLkTiktxcwfSvoVDEe3ykcT7ff9VwL_NBRVbbEvuJCV@mail.gmail.com>
References: <1292683981-6908-1-git-send-email-rydberg@euromail.se>
	<1292683981-6908-2-git-send-email-rydberg@euromail.se>
	<AANLkTimrNrfTXGh675_8zhOg_+9+NKgOmzJq9rafyh+6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:49202 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756797Ab0LRQ47 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 18 Dec 2010 11:56:59 -0500
In-Reply-To: <AANLkTimrNrfTXGh675_8zhOg_+9+NKgOmzJq9rafyh+6@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Chase Douglas <chase.douglas@canonical.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>

On Sat, Dec 18, 2010 at 10:55 AM, Chris Bagwell <chris@cnpbagwell.com> =
wrote:
> On Sat, Dec 18, 2010 at 8:52 AM, Henrik Rydberg <rydberg@euromail.se>=
 wrote:
>> From: Chase Douglas <chase.douglas@canonical.com>
>>
>> Synaptics 2.7 series of touchpads support a mode for reporting 2 set=
s
>> of X/Y/Pressure data (multi-touch). =A0These same devices default mo=
de
>> report single finger data and do not report finger counts.
>>
>> Enabling MT mode makes finger count reporting start working in same
>> fashion as touchpads that claim that capability. Up to three fingers
>> can be reported this way.
>>
>> While in MT mode and two or three fingers are touching, two sets of
>> data are sent. =A0The first is a new format buffer with lower resolu=
tion
>> reporting of stationary finger and the second is standard data forma=
t
>> reporting movement.
>
> We should probably update this comment and remove parts that mention
> stationary and movement. =A0It appears to be doing finger tracking an=
d
> first packet is always first touch... except we are getting reports
> that clickpads/integrated button pads may not be consistently like
> this.
>

Sorry.  Not first packet but higher resolution/second packet.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
