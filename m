From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 0/4] Input: atmel_mxt_ts - make it work on Tegra
Date: Mon, 30 Jun 2014 10:11:05 -0600
Message-ID: <53B18C19.6030404@wwwdotorg.org>
References: <1399414392-32572-1-git-send-email-swarren@wwwdotorg.org> <CANLzEkv8To0gWWYBF3JjRDqt+1xGUhQiYJJUwovVhBDEMW569Q@mail.gmail.com> <536963A0.4060506@wwwdotorg.org> <536BAA5A.1010809@itdev.co.uk> <536BB3C9.8070908@wwwdotorg.org> <536BDFFD.4080009@itdev.co.uk> <537128D0.3060005@wwwdotorg.org> <53763B06.7020100@itdev.co.uk> <53763F95.6000609@wwwdotorg.org> <537B8087.1040306@itdev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:41731 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756361AbaF3QLJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Jun 2014 12:11:09 -0400
In-Reply-To: <537B8087.1040306@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Stephen Warren <swarren@nvidia.com>, "Bowens, Alan" <Alan.Bowens@atmel.com>

On 05/20/2014 10:19 AM, Nick Dyer wrote:
> Stephen Warren wrote:
>> On 05/16/2014 10:21 AM, Nick Dyer wrote:
>>> Thanks for this. Would you be happy for me to pick these changes up and
>>> include them along with the other work I am sending to Dmitry? I am just
>>> beginning to do various updates to the whole series, one of the things I
>>> need to sort out is the device tree support.
>>
>> That would be fine. I assume you'd only take the 2 Atmel driver patches.
>> I'll send the Tegra patches separately once the driver is merged.
> 
> Great! Dmitry has merged some of the patches I sent now, so I'm just
> working on updating to take account of that and adding the device tree
> changes, and taking account of a couple of other review comments.

Nick, did you get anywhere with taking my DT patches and resending them?
Would you like me to resend them instead? I was really hoping to see
them working in 3.17. Unfortunately, I'm away for ~2.5 weeks starting in
a couple of days, so I won't be able to get them into 3.17 myself.
