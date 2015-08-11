From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 2/9] Input: atmel_mxt_ts - use deep sleep mode when stopped
Date: Tue, 11 Aug 2015 12:29:54 -0400
Message-ID: <CAN+gG=GP8fJR88AOOcZ6NBEi6X6WfkThF06ksfnsn_ABdvuW7A@mail.gmail.com>
References: <1438615397-17112-1-git-send-email-nick.dyer@itdev.co.uk>
	<1438615397-17112-3-git-send-email-nick.dyer@itdev.co.uk>
	<CAN+gG=Hm-RAj6L8xM54RAWQhTe96XWmQp-1s+sAnQdK8qRzyng@mail.gmail.com>
	<55CA05A6.1020006@itdev.co.uk>
	<55CA1B03.3070605@itdev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:37743 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965269AbbHKQ3z (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Aug 2015 12:29:55 -0400
Received: by wibhh20 with SMTP id hh20so204383423wib.0
        for <linux-input@vger.kernel.org>; Tue, 11 Aug 2015 09:29:54 -0700 (PDT)
In-Reply-To: <55CA1B03.3070605@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, Alan Bowens <Alan.Bowens@atmel.com>

Hi Nick,

On Tue, Aug 11, 2015 at 11:55 AM, Nick Dyer <nick.dyer@itdev.co.uk> wrote:
> On 11/08/15 15:24, Nick Dyer wrote:
>> On 10/08/15 21:11, Benjamin Tissoires wrote:
>>> I am currently running v4.2-rc6, merged with Dmitry's and Jiri's tree.
>>> This patch completely kills my touchpad on the Pixel 2. No touch
>>> information is sent while the physical button still emits values. You
>>> said that you tested it on this laptop too, so I wonder why mine
>>> refuses to work.
>>
>> I'm just building that version to see if I can reproduce. Dmitry made some
>> minor changes when he merged it, but I don't think it should have affected
>> anything.
>>
>> Are you able to send me some dmesg output with dyndbg=+pt enabled?

I will do that after lunch if you still need them.

>>
>> It would also be useful if you could compile mxt-app and try issuing a
>> calibrate or reset command to see if that restores touch (let me know if
>> you need instructions).
>
> I've done some testing and I believe I'm able to reproduce your issue. It
> appears to be caused by a bad calibration, i.e. if I run the following
> command then the touchpad starts working:
>
> sudo ./mxt-app -d i2c-dev:0-004a --calibrate

Yep, this works with the deep sleep patches applied. On the regular
fedora kernel (without these patches, and after a boot with the kernel
with the patches), it does not make the touchpad back alive, however,
a reset with the mxt-app works.

Thanks for the fast work-around.

>
> (it times out waiting for the calibration complete message when in i2c-dev
> mode, but that's expected)
>
> Could you verify this at your end?
>
> The patch under discussion sends a calibrate command as the input device is
> opened. However I can see that user space is opening/closing the device 3x
> in the space of about a second as X starts up, which may be confusing the
> firmware. It might be that we need to wait for the calibration to complete,
> I will try adding some code to do that.

Can't you start a worker on open which will keep a ref count on how
many open/close you make and which would do the calibration in the
background without blocking the user-space? This way, you will be able
to guarantee that the calibration will end, and not be re-sent if
there are several open/close in a raw.

Cheers,
Benjamin
