From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 0/4] Input: atmel_mxt_ts - make it work on Tegra
Date: Thu, 08 May 2014 10:41:45 -0600
Message-ID: <536BB3C9.8070908@wwwdotorg.org>
References: <1399414392-32572-1-git-send-email-swarren@wwwdotorg.org> <CANLzEkv8To0gWWYBF3JjRDqt+1xGUhQiYJJUwovVhBDEMW569Q@mail.gmail.com> <536963A0.4060506@wwwdotorg.org> <536BAA5A.1010809@itdev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:49128 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755165AbaEHQlt (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 May 2014 12:41:49 -0400
In-Reply-To: <536BAA5A.1010809@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Stephen Warren <swarren@nvidia.com>, "Bowens, Alan" <Alan.Bowens@atmel.com>

On 05/08/2014 10:01 AM, Nick Dyer wrote:
> Stephen Warren wrote:
>> On 05/06/2014 04:16 PM, Benson Leung wrote:
>>> Please coordinate with Nick Dyer, who has a long patch series that's
>>> been approved but not yet merged into the input tree. The few patches
>>> you've picked from the Chrome OS kernel overlap with his patch series.
>>
>> Ah I remember you mentioning that before. Is Nick's work still active?
>> The link you sent me to the "latest status" was nearly a year ago:
>>
>> https://lkml.org/lkml/2013/6/27/311
> 
> My latest set of patches for upstream was sent just over a month ago:
> https://lkml.org/lkml/2014/3/17/403
> 
> Dmitry Torokov has signed-off on them but not merged them into his tree
> yet. It would be good to hear something from him!

I don't understand the following comment in patch 0 at that link:

> Hi Dimitry-
>
> Here is a set of patches for atmel_mxt_ts that you've already
> signed-off.

Surely Dmitry would only have signed off on the patches if he had
applied them somewhere. I'm puzzled why he would have applied them but
not pushed them out into linux-next.

Perhaps he didn't sign off on the patches but rather just said they were
OK, or gave an ack? In which case, did you add Dmitry's S-o-b line to
the patches yourself? That's certainly not the correct procedure.
Perhaps he ignored the patches because of that?

Anyway, I'd like to pull these patches into my local repo to build on.
Can you point me at a tree where Dmitry applied them even if not in
linux-next? Alternatively, does your github repo contain exactly the
patches from the recent mailing list posting you linked above?

...
> From my point of view, it would be better if everyone with a stake in this
> driver worked together to test and review a single set of improvements that
> fixed bugs, added new features, and supported new chips, rather than
> everyone implementing trivial fixes in various different ways that cause
> merge conflicts and strange bugs.

Luckily, it doesn't look like it will be too hard to rebase my patches
on top of your work. However, I'd really like some feedback from Dmitry
re: when and where your patches will be applied, so that I know if/when
it makes sense to rebase on top of them.

Thanks.
