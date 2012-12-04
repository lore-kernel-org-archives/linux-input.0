From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 2/2] input: wacom - use new input-mt routines
Date: Tue, 4 Dec 2012 11:58:30 -0800
Message-ID: <CAF8JNhKWpF3L9F7BXZ=+UXEtHjHyEpCKu9JNEF73FpL4nU+Txg@mail.gmail.com>
References: <1354570717-2274-1-git-send-email-pingc@wacom.com>
	<20121204161314.GA1432@polaris.bitmath.org>
	<CAF8JNhJ3wC9Oih_0Lx3-JyP_MJdd9TfBRsLnfLsfC+wbm9xCww@mail.gmail.com>
	<20121204191622.GE23964@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:38914 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566Ab2LDT6b (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Dec 2012 14:58:31 -0500
Received: by mail-la0-f46.google.com with SMTP id p5so3633688lag.19
        for <linux-input@vger.kernel.org>; Tue, 04 Dec 2012 11:58:30 -0800 (PST)
In-Reply-To: <20121204191622.GE23964@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input <linux-input@vger.kernel.org>

On Tue, Dec 4, 2012 at 11:16 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Tue, Dec 04, 2012 at 10:22:24AM -0800, Ping Cheng wrote:
>>
>> However, for this particular one (and maybe 2 below), we do need to
>> remove it. 24hdt is a touchscren device, which should not emulate
>> pointer events. I will make a separate patch for this change.
>
> Why not? Legacy clients should be able to use touchscreens and I think
> most (all?) of our MT touchscreen drivers report ST events.

Some touchscreens have it, some don't.

I see your point to keep it. I'll update the patch and keep pointer
emulation as is.

Ping
