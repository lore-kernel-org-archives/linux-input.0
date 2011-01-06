From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [RFC v2 0/10] hid-multitouch: a first step towards multitouch unification
Date: Thu, 6 Jan 2011 17:08:39 +0100
Message-ID: <AANLkTik9qHn4u_U6FGKR0A4AOyPoYPkXM7rTMxVjiXgk@mail.gmail.com>
References: <1294248468-19979-1-git-send-email-benjamin.tissoires@enac.fr>
	<20110105174927.GB2146@polaris.bitmath.org>
	<AANLkTikCqufvOgYqqBZLjfmtSdsgyQV4L2HyvEP07+vf@mail.gmail.com>
	<alpine.LNX.2.00.1101061610270.26685@pobox.suse.cz>
	<20110106160418.GA1790@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:40983 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753607Ab1AFQIk (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Jan 2011 11:08:40 -0500
In-Reply-To: <20110106160418.GA1790@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jan 6, 2011 at 5:04 PM, Henrik Rydberg <rydberg@euromail.se> wrote:
>> > The point is that currently we have users that want to have a proper
>> > support for their device (PixCir, Cypress TrueTouch and GeneralTouch),
>> > and it's a shame to ask them to wait for 3 more months.
>
> That is understandable, but for the future, please bear in mind that
> submitting patches in the merge window is the worst possible time
> within that three-month period.
>
>> > Maybe a solution would be to make what we can here during this merge
>> > window to add support for at least the new devices. Then, in 2.6.39
>> > and above, we could still migrate other devices, and eventually modify
>> > some lines in the code.
>> >
>> > Jiri, Dmitry, what do you think?
>>
>> I still have to go through the patchset, my backlog has grown very badly
>> recently, sorry.
>>
>> In case the patchset doesn't impose danger of regressions for already
>> existing devices, we could merge this new 'unified' driver only for newly
>> supported devices, and finish the unification in 2.6.39.
>
> Sounds reasonable.

Thanks Henrik and Jiri.

Do you want me to send a new patchset with only the new devices?

Benjamin
