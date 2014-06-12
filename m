From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 0/4] Input: atmel_mxt_ts - make it work on Tegra
Date: Thu, 12 Jun 2014 11:12:22 -0600
Message-ID: <5399DF76.8020108@wwwdotorg.org>
References: <1399414392-32572-1-git-send-email-swarren@wwwdotorg.org> <CANLzEkv8To0gWWYBF3JjRDqt+1xGUhQiYJJUwovVhBDEMW569Q@mail.gmail.com> <536963A0.4060506@wwwdotorg.org> <536BAA5A.1010809@itdev.co.uk> <536BB3C9.8070908@wwwdotorg.org> <536BDFFD.4080009@itdev.co.uk> <537128D0.3060005@wwwdotorg.org> <53763B06.7020100@itdev.co.uk> <53763F95.6000609@wwwdotorg.org> <537B8087.1040306@itdev.co.uk> <53989D30.1000605@wwwdotorg.org> <53998E12.8050408@itdev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:59805 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753017AbaFLRM0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Jun 2014 13:12:26 -0400
In-Reply-To: <53998E12.8050408@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Stephen Warren <swarren@nvidia.com>, "Bowens, Alan" <Alan.Bowens@atmel.com>

On 06/12/2014 05:25 AM, Nick Dyer wrote:
> Stephen Warren wrote:
>>> I will test this on my setup and see if I can figure out what is causing
>>> the problem.
>>
>> Nick, did you get anywhere reproducing my problem? Unfortunately with
>> your recent patches merged, I can't get the touchpad working at all,
>> whereas before I had a few simple patches that made it work:-(
> 
> I haven't been able to reproduce your issue, I have a devicetree based
> system that will successfully probe without a config file.
> 
> Could you send me the dmesg output with all of the driver debug enabled? It
> would be good to see how far it is getting.

My apologies; I should have retested before asking about this again. I
guess something must have changed in linux-next since the last time I
tested this.

With next-20140611 plus the following patches on top:

d3168ccd7d57 ARM: tegra: enable Atmel touchpad in defconfig
fc1d7c4aefe0 ARM: tegra: add touchpad to Venice2 DT
da5f283a52ea Input: atmel_mxt_ts: implement device tree parsing
22911ed92e76 Input: atmel_mxt_ts: define a device tree binding
57f79f65a8f9 Input: atmel_mxt_ts - Set pointer emulation on touchpads

... the driver built into the kernel, and no firmware available in
/lib/firmware, the touchpad now works.

Are you still expecting to take my DT binding patches above and resend them?

One bug I see is that the mouse doesn't seem to release when I drag it
(either through double clicking and holding on the second click, or by a
two-finger drag). Is that a known issue?
