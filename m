From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: Re: [PATCH] Input: Do not add SYN_REPORT in between a single packet data
Date: Thu, 7 Apr 2016 02:13:37 +0530
Message-ID: <CADYu30_KXBSVTvrZVgt4aSk=Lc+64KZGf8ZBoTrD5dXSoFq+2w@mail.gmail.com>
References: <1457372672-884-1-git-send-email-a.mathur@samsung.com>
	<CAKdAkRQT0R6peS8iO8PhQ4YoPMowt6voZJez4EubK7R0ZV_m4Q@mail.gmail.com>
	<56E17A73.8090901@bitmath.org>
	<CADYu30-b+5TFh2yy2SrGTJJ7FzvcezWut1XL3Ypno5R29hyYww@mail.gmail.com>
	<20160401215128.GA5216@dtor-ws>
	<CADYu309K20ki1oMMTGmGQ+CmftCELoSFZfv704YZ_hzmzQG1kQ@mail.gmail.com>
	<CADYu3083da+hW_uLg3WWqgotvOZD1f3V3TdabgX6gDTY93GB7w@mail.gmail.com>
	<20160406173848.GC38452@dtor-ws>
	<CADYu308OF98jdbsqpSVdQpTa0sEafuQmVuC=ttN3-1u59_QvmA@mail.gmail.com>
	<570568AB.8010501@bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34143 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328AbcDFUnq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Apr 2016 16:43:46 -0400
In-Reply-To: <570568AB.8010501@bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aniroop Mathur <a.mathur@samsung.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

Hello Mr. Henrik,

On Thu, Apr 7, 2016 at 1:21 AM, Henrik Rydberg <rydberg@bitmath.org> wrote:
> Hi Aniroop,
>
>>> I am not sure what the urgency is. It is more of a theoretical problem
>>> ans so far the proposed solutions were actually introducing more
>>> problems than they were solving.
>>>
>>> I am sorry, bit this particular topic is not a priority for me.
>>>
>>
>> There is no hurry at all. :-) As you know request is made a long time ago,
>> so I am only very curious to complete it.
>
> This kind of patch is not liked by any maintainer, because it does not solve any
> immediate problem, but instead may create one. If such a simple patch takes
> three of four tries to look right, it only adds to the perception that the code
> is best left alone.
>
> I think the solution at this stage is to say no to this patch.
>
> If there is ever a driver for which the input_estimate_events_per_packet()
> function returns less than the actual maximum number of events per frame, this
> issue can be revisited and resolved in a number of different ways.
>
> Sorry, and thanks for your work.
>

Well, I agree this code might not be used by any driver so far.
But if some driver developer writes such a driver, then it definitely cannot
work well because of the bug in input subsystem code. So I am afraid that it
is not a good idea to wait for someone to report this bug when we already know
that the bug does exist in input core.

Secondly, I submitted this patch not only because it breaks protocol of
SYN_REPORT event but also because without this bug fix, another bug could not
be concluded which depends on when the input event packet ended really.
Bug:
Input: evdev: fix bug of dropping valid packet after syn_dropped event
https://patchwork.kernel.org/patch/8083641/
So to fix this bug, we need to fix SYN_REPORT bug first.

It would be appreciating of you if you could give it one more spin.


> Henrik
>
