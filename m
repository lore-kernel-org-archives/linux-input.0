From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 0/4] Input: atmel_mxt_ts - make it work on Tegra
Date: Tue, 06 May 2014 16:35:12 -0600
Message-ID: <536963A0.4060506@wwwdotorg.org>
References: <1399414392-32572-1-git-send-email-swarren@wwwdotorg.org> <CANLzEkv8To0gWWYBF3JjRDqt+1xGUhQiYJJUwovVhBDEMW569Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:47546 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145AbaEFWfQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 May 2014 18:35:16 -0400
In-Reply-To: <CANLzEkv8To0gWWYBF3JjRDqt+1xGUhQiYJJUwovVhBDEMW569Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benson Leung <bleung@chromium.org>, Nick Dyer <nick.dyer@itdev.co.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Yufeng Shen <miletus@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Stephen Warren <swarren@nvidia.com>

On 05/06/2014 04:16 PM, Benson Leung wrote:
> Hi Stephen,
> 
> On Tue, May 6, 2014 at 3:13 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> This series contains the minimum number of patches required to make the
>> Atmel MXT touchpad work on NVIDIA Tegra, which requires the device to be
>> instantiated from device tree rather than from a C board file.
>>
>> These patches are based on patches in the ChromeOS kernel. However, I took
>> a different approach to the devicetree-doesn't-provide-platform-data issue.
>> Rather than amending all users of platform data to work with or without it,
>> as the patches in the ChromeOS kernel do, I implemented a single function
>> mxt_parse_dt() to create a platform data structure from DT. This isolates
>> the changes required to a single function, rather than spreading them all
>> over the driver.
> 
> Please coordinate with Nick Dyer, who has a long patch series that's
> been approved but not yet merged into the input tree. The few patches
> you've picked from the Chrome OS kernel overlap with his patch series.

Ah I remember you mentioning that before. Is Nick's work still active?
The link you sent me to the "latest status" was nearly a year ago:

https://lkml.org/lkml/2013/6/27/311

... and while the github link you sent:

https://github.com/ndyer/linux/commits/for-next-20140316-v8

... has much more recent activity, it hasn't been touched /that/
recently either.

To be honest, it'd be a bit off-putting to hold up a trivial patch
series like this and make it wait for a huge refactoring series that's
obviously been dragging on for a long time...
