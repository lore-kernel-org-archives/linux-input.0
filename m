From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH 2/9] Input: atmel_mxt_ts - use deep sleep mode when stopped
Date: Tue, 11 Aug 2015 19:32:27 +0100
Message-ID: <55CA3FBB.40402@itdev.co.uk>
References: <1438615397-17112-1-git-send-email-nick.dyer@itdev.co.uk>	<1438615397-17112-3-git-send-email-nick.dyer@itdev.co.uk>	<CAN+gG=Hm-RAj6L8xM54RAWQhTe96XWmQp-1s+sAnQdK8qRzyng@mail.gmail.com>	<55CA05A6.1020006@itdev.co.uk>	<55CA1B03.3070605@itdev.co.uk> <CAN+gG=GP8fJR88AOOcZ6NBEi6X6WfkThF06ksfnsn_ABdvuW7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kdh-gw.itdev.co.uk ([89.21.227.133]:53685 "EHLO
	hermes.kdh.itdev.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751841AbbHKSce (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Aug 2015 14:32:34 -0400
In-Reply-To: <CAN+gG=GP8fJR88AOOcZ6NBEi6X6WfkThF06ksfnsn_ABdvuW7A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, Alan Bowens <Alan.Bowens@atmel.com>

On 11/08/15 17:29, Benjamin Tissoires wrote:
>>> Are you able to send me some dmesg output with dyndbg=+pt enabled?
> 
> I will do that after lunch if you still need them.

Looks unnecessary given that the calibrate worked.

>> sudo ./mxt-app -d i2c-dev:0-004a --calibrate
> 
> Yep, this works with the deep sleep patches applied. On the regular
> fedora kernel (without these patches, and after a boot with the kernel
> with the patches), it does not make the touchpad back alive, however,
> a reset with the mxt-app works.
> 
> Thanks for the fast work-around.

Thanks for testing this!

>> The patch under discussion sends a calibrate command as the input device is
>> opened. However I can see that user space is opening/closing the device 3x
>> in the space of about a second as X starts up, which may be confusing the
>> firmware. It might be that we need to wait for the calibration to complete,
>> I will try adding some code to do that.
> 
> Can't you start a worker on open which will keep a ref count on how
> many open/close you make and which would do the calibration in the
> background without blocking the user-space? This way, you will be able
> to guarantee that the calibration will end, and not be re-sent if
> there are several open/close in a raw.

Yes, something like that sounds sensible.
