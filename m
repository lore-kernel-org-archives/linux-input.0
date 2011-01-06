From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [RFC v2 0/10] hid-multitouch: a first step towards multitouch unification
Date: Thu, 6 Jan 2011 16:08:42 +0100
Message-ID: <AANLkTikCqufvOgYqqBZLjfmtSdsgyQV4L2HyvEP07+vf@mail.gmail.com>
References: <1294248468-19979-1-git-send-email-benjamin.tissoires@enac.fr>
	<20110105174927.GB2146@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:54506 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234Ab1AFPIn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Jan 2011 10:08:43 -0500
In-Reply-To: <20110105174927.GB2146@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Stephane Chatty <chatty@enac.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Henrik,

thanks for the future review ;)

Well, patches n=B0 3,4,5,6 and 7 are only those sent by St=E9phane and
reviewed by you 3 months ago with small changes:
  - I took into account most of your comments
  - I inserted suspend/resume support
  - I implemented a way to find out the end of a mt report.

Patch 1 (hid: add feature_mapping callback) is new but not very
dangerous I think: it only adds a hook. Thanks to it, I could retrieve
the magic number which is device-specific.

Patch 2 (hid: set HID_MAX_FIELD at 128) may need further discussions
(but is required to use Stantum panels)

the last patches only introduce support for 3 devices, 1 of them is
new for the kernel.

The point is that currently we have users that want to have a proper
support for their device (PixCir, Cypress TrueTouch and GeneralTouch),
and it's a shame to ask them to wait for 3 more months.

Maybe a solution would be to make what we can here during this merge
window to add support for at least the new devices. Then, in 2.6.39
and above, we could still migrate other devices, and eventually modify
some lines in the code.

Jiri, Dmitry, what do you think?

Cheers,
Benjamin



On Wed, Jan 5, 2011 at 6:49 PM, Henrik Rydberg <rydberg@euromail.se> wr=
ote:
> Hi Benjamin,
>
>> these patches is the set for the unified driver hid-multitouch.
>> I'm putting the flag RFC as I'm still waiting some testers feedback =
on some devices. But I don't think they will change a lot.
>
> This will be an interesting read, thank you very much for the patches=
=2E
>
>> This would be great if this stuff could go into 2.6.38, if it's not =
too late.
>
> The merge window just opened, which generally means the work for
> 2.6.38 is done. On top of that, we would expect some changes and
> further testing, and limited time from everybody involved.
> Given that
> also additional drivers should be added, which might affect the
> general solution, it seems like a good idea to let this mature over
> time, such that it is ready for the 2.6.39 merge window.
>
> Thanks,
> Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
