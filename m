From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: polldev can cause crash in case of polling disabled
Date: Wed, 17 Feb 2010 12:54:30 -0800
Message-ID: <128C206A-CDA0-47F8-AB9E-3FB90CFD6046@gmail.com>
References: <1266331481-2094-1-git-send-email-samu.p.onkalo@nokia.com> <20100216175047.GB15376@core.coreip.homeip.net> <62697B07E9803846BC582181BD6FB6B82661D4A81B@NOK-EUMSG-02.mgdnok.nokia.com> <20100216214309.GC15376@core.coreip.homeip.net> <62697B07E9803846BC582181BD6FB6B82661D4AA59@NOK-EUMSG-02.mgdnok.nokia.com> <20100217170315.GB10249@redhat.com> <20100217195044.GC15554@core.coreip.homeip.net> <20100217202339.GA21840@redhat.com>
Mime-Version: 1.0 (iPhone Mail 7C144)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f197.google.com ([209.85.211.197]:49058 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756084Ab0BQUym (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Feb 2010 15:54:42 -0500
Received: by ywh35 with SMTP id 35so297886ywh.4
        for <linux-input@vger.kernel.org>; Wed, 17 Feb 2010 12:54:41 -0800 (PST)
In-Reply-To: <20100217202339.GA21840@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: "samu.p.onkalo@nokia.com" <samu.p.onkalo@nokia.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Feb 17, 2010, at 12:23 PM, Oleg Nesterov <oleg@redhat.com> wrote:

> On 02/17, Dmitry Torokhov wrote:
>>
>> It apppears that it is allowed to try to cancel work that has never  
>> been
>> queued
>
> Yes,
>
>> and I believe that canceled or completed work should be exactly
>> the same as never been queued work (which is apparently not the case
>> currently).
>
> And yes, currently this is not the case.
>
> As I said, I agree that cancel() could clear ->data. Will this change
> help? (in any case this change is not for 2.6.33)
>
> But I don't see how "completed" can do this, please see my previous
> email. Note that flush() can't do this too.
>
>> Yes, it is certainly possible to work around the issue in every  
>> driver
>> that may happen to shut down and re-create workqueue as needed. The
>> question is whether it is the right thing to do.
>
> I'd say, the question is whether we can improve this ;) Well, see  
> above.
>

I understand. I think if we just change cancel to do the right thing  
that should be enough to avoid surprises.

-- 
Dmitry
