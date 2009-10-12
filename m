From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] input: bcm5974: report ABS_MT events
Date: Tue, 13 Oct 2009 01:08:18 +0200
Message-ID: <4AD3B6E2.9020703@euromail.se>
References: <1255386223-4109-1-git-send-email-rydberg@euromail.se>	<1255386223-4109-2-git-send-email-rydberg@euromail.se> <20091012154528.6830da60.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758608AbZJLXJF@vger.kernel.org>
In-Reply-To: <20091012154528.6830da60.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Andrew Morton wrote:
> On Tue, 13 Oct 2009 00:23:43 +0200
> "Henrik Rydberg" <rydberg@euromail.se> wrote:
> 
>> This patch makes bcm5974 report raw multi-touch (MT) data in the form
>> of ABS_MT events. The module parameter (nomt) may be used to turn off
>> the effect of this patch.
>>
> 
> Why do we need a module parameter to disable the newly-added feature?

All MT events bypass the input filtering and gets sent directly to the X driver.
Although it works as intended, without visible side effects, the stream of
events is rather large, and since the bypassing is completely new behavior, I
felt compelled to provide an option to turn it all off. Perhaps it is just me
being paranoid.

> 
> IMO, your first patch ("input: bcm5974: retract efi-broken
> suspend_resume") is 2.6.32 material whereas this one is 2.6.33
> material?
> 
> This assumes that the two patches can be safely separated in this
> manner, which does appear to be the case.
> 

I was imagining both for 2.6.33; the efi booting is just beginning to work, and
since no distro is using it fully so far the problem currently only hits the
adventure-seekers anyways.

Cheers,
Henrik
