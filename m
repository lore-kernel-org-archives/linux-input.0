From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH 0/4] Input: atmel_mxt_ts - make it work on Tegra
Date: Thu, 08 May 2014 20:50:21 +0100
Message-ID: <536BDFFD.4080009@itdev.co.uk>
References: <1399414392-32572-1-git-send-email-swarren@wwwdotorg.org> <CANLzEkv8To0gWWYBF3JjRDqt+1xGUhQiYJJUwovVhBDEMW569Q@mail.gmail.com> <536963A0.4060506@wwwdotorg.org> <536BAA5A.1010809@itdev.co.uk> <536BB3C9.8070908@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kdh-gw.itdev.co.uk ([89.21.227.133]:64561 "EHLO
	hermes.kdh.itdev.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754871AbaEHTuZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 May 2014 15:50:25 -0400
In-Reply-To: <536BB3C9.8070908@wwwdotorg.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Stephen Warren <swarren@nvidia.com>, "Bowens, Alan" <Alan.Bowens@atmel.com>

Stephen Warren wrote:
> Anyway, I'd like to pull these patches into my local repo to build on.
> Can you point me at a tree where Dmitry applied them even if not in
> linux-next? Alternatively, does your github repo contain exactly the
> patches from the recent mailing list posting you linked above?

https://git.kernel.org/cgit/linux/kernel/git/dtor/input.git/log/?h=atmel-mxt-ts

However, I have made minor updates on top of that to take account of API
changes since he worked on them (reinit_completion).

The patches I posted at the end of March are the first 22 out of this tag:

https://github.com/ndyer/linux/tree/for-next-20140316-v8

> ...
>> From my point of view, it would be better if everyone with a stake in this
>> driver worked together to test and review a single set of improvements that
>> fixed bugs, added new features, and supported new chips, rather than
>> everyone implementing trivial fixes in various different ways that cause
>> merge conflicts and strange bugs.
> 
> Luckily, it doesn't look like it will be too hard to rebase my patches
> on top of your work. However, I'd really like some feedback from Dmitry
> re: when and where your patches will be applied, so that I know if/when
> it makes sense to rebase on top of them.

OK. I agree that it's a good thing if we can get a sensible device tree
patch in as soon as possible. You will notice that a lot of the existing
platform data is removed in that sequence, and we already have a patch to
read the screen resolution from the chip.
