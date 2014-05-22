From: Elias Vanderstuyft <elias.vds@gmail.com>
Subject: Re: [PATCH v4 01/24] input: Add ff-memless-next module
Date: Thu, 22 May 2014 11:48:11 +0200
Message-ID: <CADbOyBTjC-Gfx+gKo0VRbnKMLFvNpQzo9a-VHRPMUuTNLGoiqw@mail.gmail.com>
References: <1398524543-15012-1-git-send-email-madcatxster@devoid-pointer.net>
	<2965006.XKYHWj9YzJ@sigyn>
	<865ad8dbc7ae0d13c045bd2a85cff2e2.squirrel@mungewell.org>
	<6970969.ej8OFzkVkO@sigyn>
	<CADbOyBTOQLewGSzXY6O1Rghw28bMtDYf5UdH9QU17DPur8hryw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f171.google.com ([209.85.220.171]:48900 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518AbaEVJsM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 May 2014 05:48:12 -0400
In-Reply-To: <CADbOyBTOQLewGSzXY6O1Rghw28bMtDYf5UdH9QU17DPur8hryw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Simon Wood <simon@mungewell.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Anssi Hannula <anssi.hannula@iki.fi>, =?UTF-8?B?TWljaGFsIE1hbMO9?= <madcatxster@devoid-pointer.net>, Roland Bosa <rbosa@logitech.com>

On Tue, May 20, 2014 at 11:26 PM, Elias Vanderstuyft
<elias.vds@gmail.com> wrote:
> On Tue, May 20, 2014 at 10:58 PM, Michal Mal=C3=BD
> <madcatxster@devoid-pointer.net> wrote:
>> On Tuesday 20 of May 2014 16:16:12 simon@mungewell.org wrote:
>>> Regarding the question of emulated vs. real effects, can we extend =
the API
>>> so that applications can know which effects are really supported, a=
nd
>>> enable/disable emulation somehow?
>>
>> I suppose that a few extra flags (FF_PERIODIC_EMULATED etc.) defined=
 in
>> "uapi/linux/input.h" should suffice.
>
> @Dmitry:
> Now that we're talking about API changes, I would like to propose som=
e
> additional things in the Linux FF API:
>
> - Possibility to *get* FF state variables, such as the value of the
> current GAIN, and the current AUTOCENTER:
> At the moment, only *setting* is possible.
> This poses a problem when implementing proper AUTOCENTER state
> recovery (upon closing a Windows program) in Wine, because the initia=
l
> AUTOCENTER state was unknown.
> The same applies for GAIN.
>
> - Introduce multiple types of GAIN, apart from the current global
> GAIN, e.g. GAIN_CONSTANT and GAIN_DAMPER:
> This is mainly on request of some users, especially Logitech users: o=
n
> Windows Logitech additionally supports to set the global Damper and
> Spring gain.
> Maybe it would be nicer to create a global gain for every supported
> Linux FF effect?

And Roland Bosa (from Logitech) also agrees with the following
addition/modification to the Linux FF API:

- Infinite iterations, or in Linux FF terms: playback of an effect
with an event count of infinity.
Right now, an event count of zero stops the effect, while the maximum
count is INT_MAX.
An event count value of '-1' can be used to indicate infinity.
(However note that it is somewhat inconsistent with the infinite
effect "duration" we already support: in that case '0' is used)
Is this feasible? (in terms of backward compatibility)

Thanks,
Elias
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
