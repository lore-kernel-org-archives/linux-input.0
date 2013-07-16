From: Michael Wright <michaelwr@android.com>
Subject: Re: [PATCH 001/001] [Input:] Propagate hardware generated event
 timestamp to evdev.
Date: Tue, 16 Jul 2013 16:22:50 -0700
Message-ID: <CALDEARj5x+BL0_BC3cn-DBOZUNAz0-egOCjvSjM8zRWQb_bEbA@mail.gmail.com>
References: <CAJVTVr=rbkYHD93N4H9ANy1Hsivdd_XFLONXxOBp+TR9LfAyaQ@mail.gmail.com>
 <20130713064430.GA20979@core.coreip.homeip.net> <CALDEARgU_qD88ExdufXkTFjaenVEwLC=q3t-RNwRrm4A-mMVZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:41488 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933657Ab3GPXXL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Jul 2013 19:23:11 -0400
Received: by mail-oa0-f54.google.com with SMTP id o6so1672765oag.27
        for <linux-input@vger.kernel.org>; Tue, 16 Jul 2013 16:23:10 -0700 (PDT)
In-Reply-To: <CALDEARgU_qD88ExdufXkTFjaenVEwLC=q3t-RNwRrm4A-mMVZw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Wright <michaelwr@android.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alexander Levitskiy <sanek@google.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Rob Landley <rob@landley.net>, Henrik Rydberg <rydberg@euromail.se>, =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>, Stephen Boyd <sboyd@codeaurora.org>

Apologies, forgot to make sure it was plain text.

On Tue, Jul 16, 2013 at 4:16 PM, Michael Wright <michaelwr@android.com> wrote:
> Hi Dmitry,
>
>
> On Fri, Jul 12, 2013 at 11:44 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> We already have MSC_TIMESTAMP (which is in usec), do you really need
>> nsec resolution?
>
> We don't actually need nsec resolution, usec resolution would be sufficient.
>
>
>> Why do you need this special handling? Can you simply have MSC_TIMESTAMP
>> to be delivered as part of the event packet and use it instead of the
>> event timestamp if userspace chooses to do so?
>
> We need stronger guarantees than MSC_TIMESTAMP gives us. Much of
> our system relies on the fact that timestamps produced by evdev are based on
> the systems monotonic clock, whereas MSC_TIMESTAMP provides no such
> guarantee.
> As for whether it's a MSC or SYN event, I don't think we really have
> preference.
>
> Thanks,
>
> Michael
