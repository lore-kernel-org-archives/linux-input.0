From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 0/4] Input: atmel_mxt_ts - make it work on Tegra
Date: Mon, 12 May 2014 20:31:08 -0600
Message-ID: <537183EC.6040806@wwwdotorg.org>
References: <1399414392-32572-1-git-send-email-swarren@wwwdotorg.org> <CANLzEkv8To0gWWYBF3JjRDqt+1xGUhQiYJJUwovVhBDEMW569Q@mail.gmail.com> <536963A0.4060506@wwwdotorg.org> <536BAA5A.1010809@itdev.co.uk> <536BB3C9.8070908@wwwdotorg.org> <536BDFFD.4080009@itdev.co.uk> <537128D0.3060005@wwwdotorg.org> <20140513011635.GB26152@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:60695 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085AbaEMCbM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 May 2014 22:31:12 -0400
In-Reply-To: <20140513011635.GB26152@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Nick Dyer <nick.dyer@itdev.co.uk>, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Stephen Warren <swarren@nvidia.com>, "Bowens, Alan" <Alan.Bowens@atmel.com>

On 05/12/2014 07:16 PM, Dmitry Torokhov wrote:
> On Mon, May 12, 2014 at 02:02:24PM -0600, Stephen Warren wrote:
>> On 05/08/2014 01:50 PM, Nick Dyer wrote:
>>> Stephen Warren wrote:
>>>> Anyway, I'd like to pull these patches into my local repo to build on.
>>>> Can you point me at a tree where Dmitry applied them even if not in
>>>> linux-next? Alternatively, does your github repo contain exactly the
>>>> patches from the recent mailing list posting you linked above?
>>>
>>> https://git.kernel.org/cgit/linux/kernel/git/dtor/input.git/log/?h=atmel-mxt-ts
>>>
>>> However, I have made minor updates on top of that to take account of API
>>> changes since he worked on them (reinit_completion).
>>>
>>> The patches I posted at the end of March are the first 22 out of this tag:
>>>
>>> https://github.com/ndyer/linux/tree/for-next-20140316-v8
>>
>> I took those 22 patches, applied them on top of next-20150507 (which is
>> just what I happened to be developing on top of right now), and rebased
>> my patches which add DT support. You can find the result here if you want:
>>
>> git://github.com/swarren/linux-tegra.git tegra_dev
>>
>> However, with that code-base, the touchpad doesn't work for me. I see a
>> long pause and errors during boot:
>>
>>> [    1.246253] atmel_mxt_ts 1-004b: Direct firmware load failed with error -2
>>> [    1.253120] atmel_mxt_ts 1-004b: Falling back to user helper
>>> [   61.394348] atmel_mxt_ts 1-004b: Failure to request config file maxtouch.cfg
>>> [   61.403717] atmel_mxt_ts 1-004b: Family: 130 Variant: 1 Firmware V1.0.AA Objects: 22
>>
>> ... and the touchpad doesn't work once X starts. With next-20140507 plus
>> the patches I sent to the mailing list, everything works.
>>
>> I'm not sure if I'm supposed to have some configuration file now and
>> that's why it doesn't work, or whether some other problem has been
>> introduced? If I do need a config file, can you tell me what to put into it?
>>
>> Thanks for any pointers.
> 
> If you build firmware into kernel or build the driver as a module it
> will work, but we do need to solve it general case as well.

Building it as a module does solve the long delay at bootup, but doesn't
make the device actually work.

I believe the HW doesn't require any firmware; it has non-volatile
storage for both the firmware and configuration. However, the driver
doesn't seem to work without a firmware file being present.
