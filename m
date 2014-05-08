From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH 0/4] Input: atmel_mxt_ts - make it work on Tegra
Date: Thu, 08 May 2014 17:01:30 +0100
Message-ID: <536BAA5A.1010809@itdev.co.uk>
References: <1399414392-32572-1-git-send-email-swarren@wwwdotorg.org> <CANLzEkv8To0gWWYBF3JjRDqt+1xGUhQiYJJUwovVhBDEMW569Q@mail.gmail.com> <536963A0.4060506@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kdh-gw.itdev.co.uk ([89.21.227.133]:27949 "EHLO
	hermes.kdh.itdev.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755002AbaEHQBg (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 May 2014 12:01:36 -0400
In-Reply-To: <536963A0.4060506@wwwdotorg.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Benson Leung <bleung@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yufeng Shen <miletus@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Stephen Warren <swarren@nvidia.com>, "Bowens, Alan" <Alan.Bowens@atmel.com>

Stephen Warren wrote:
> On 05/06/2014 04:16 PM, Benson Leung wrote:
>> Please coordinate with Nick Dyer, who has a long patch series that's
>> been approved but not yet merged into the input tree. The few patches
>> you've picked from the Chrome OS kernel overlap with his patch series.
> 
> Ah I remember you mentioning that before. Is Nick's work still active?
> The link you sent me to the "latest status" was nearly a year ago:
> 
> https://lkml.org/lkml/2013/6/27/311

My latest set of patches for upstream was sent just over a month ago:
https://lkml.org/lkml/2014/3/17/403

Dmitry Torokov has signed-off on them but not merged them into his tree
yet. It would be good to hear something from him!

> ... and while the github link you sent:
> 
> https://github.com/ndyer/linux/commits/for-next-20140316-v8
> 
> ... has much more recent activity, it hasn't been touched /that/
> recently either.
> 
> To be honest, it'd be a bit off-putting to hold up a trivial patch
> series like this and make it wait for a huge refactoring series that's
> obviously been dragging on for a long time...

>From my point of view, it would be better if everyone with a stake in this
driver worked together to test and review a single set of improvements that
fixed bugs, added new features, and supported new chips, rather than
everyone implementing trivial fixes in various different ways that cause
merge conflicts and strange bugs.
