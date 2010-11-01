From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH] Input: wacom - report hardware provided MT_TRACKING_IDs
Date: Mon, 1 Nov 2010 10:34:25 -0700
Message-ID: <AANLkTik4b2siRUHAohr7tM1F5auVpC555G_7fjgLnSxv@mail.gmail.com>
References: <1288497626-25416-1-git-send-email-pingc@wacom.com>
	<4CCECDCA.9040200@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50823 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815Ab0KARe0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 1 Nov 2010 13:34:26 -0400
Received: by wwe15 with SMTP id 15so6314804wwe.1
        for <linux-input@vger.kernel.org>; Mon, 01 Nov 2010 10:34:25 -0700 (PDT)
In-Reply-To: <4CCECDCA.9040200@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Mon, Nov 1, 2010 at 7:25 AM, Henrik Rydberg <rydberg@euromail.se> wrote:
> On 10/31/2010 05:00 AM, Ping Cheng wrote:
>
>> The "Multi-touch (MT) Protocol" says:
>>
>> "The slot protocol requires the use of the ABS_MT_TRACKING_ID, either
>> provided by the hardware or computed from the raw data".
>>
>> We get the IDs from Bamboo touch device. Let's use them instead of
>> compute our own.
>>
>> Signed-off-by: Ping Cheng <pingc@wacom.com>
>
>
> Hi Ping,
>
> I share the same concern as Dmitry here. This patch weakens the semantics of the
> current tracking id definition.  As it seems, only to allow the tracking id to be
> used in a different, undocumented or hardware-specific way. This is not a good
> way to go - neither from a kernel maintenance perspective, nor from a user
> experience perspective. After all, the kernel is about unifying the experience
> of different hardware.

I think I got the point now. The tracking id is aimed at an unified
touch/finger tracking in the kernel. Not just to pass whatever
hardware provides.

I was stuck at the phrase of "provided by the hardware". With your
explanation, I see the rationale behind the use of "trk_id". This
discussion made it clear how I need to convince app developers. Please
ignore this patch.

I see a potential in merging type A into type B with the introduction
of trk_id. The type A drivers may need to tweak their x/y/..values a
bit to fit into the protocol. But the benefit of tracking ID should be
universal.

Trust me, this is all technical. Wacom does not even have a type A
device. It is not my job to care about type A.

>From a pure developer point of view, if our goal is to unify the
experience of different hardwares, merging type A to type B may not be
a bad idea. However, I do know there was issues preventing us from
merging them when we started in June. I bring it up now to see if
things has changed in our favor or not.

Thank you Henrik for your reply and comments. It helped me a lot. I
hope it does the same for others too.

Ping
