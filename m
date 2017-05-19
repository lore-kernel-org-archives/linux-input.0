From: Sriram V <vshrirama@gmail.com>
Subject: Re: Touch Calibration
Date: Fri, 19 May 2017 19:34:18 +0530
Message-ID: <CAH9_wRPrnwcZKs-aUNvmgHz3kL=kYzAUUm+qGvQ6Zy+pcfGG0w@mail.gmail.com>
References: <CAH9_wRNRoz1fEJT9OF4NEn6igPsrh2Kg9jvazXST+k_JBLNw8g@mail.gmail.com>
 <a4283e86-3181-f5cc-0861-1a8258c11696@ginzinger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:35957 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751336AbdESOET (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 May 2017 10:04:19 -0400
Received: by mail-vk0-f47.google.com with SMTP id p85so12322607vkd.3
        for <linux-input@vger.kernel.org>; Fri, 19 May 2017 07:04:19 -0700 (PDT)
In-Reply-To: <a4283e86-3181-f5cc-0861-1a8258c11696@ginzinger.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Martin Kepplinger <martin.kepplinger@ginzinger.com>
Cc: linux-input@vger.kernel.org

Hi Martin,

I am aware of tslib. However, I was not able to find something like
that on Android Systems.

Thanks,
Sriram

On Fri, May 19, 2017 at 6:24 PM, Martin Kepplinger
<martin.kepplinger@ginzinger.com> wrote:
> On 2017-05-18 11:21, Sriram V wrote:
>> Hi,
>>
>> I wanted to find out how does touch calibration works? Is this
>> something that is taken care in the userspace?
>> Unfortunately, my device does not have a Write Interface. I have read
>> the values from the device but can't do i2c writes to the device.
>> I also wanted to find out how touch screen calibration is done in
>> Android systems.
>>
>
> Calibration is linear transformation of coordinate values. Usually this
> is not a driver's work. The driver should make sure userspace can talk
> in "evdev" sync frames.
>
> It is usually done in userspace, by an X.org input "driver" for example.
> At least I think xf86-input-evdev does some calibration.
>
> For touchscreen devices, especially in embedded and if people need more
> filters than linear transormation, tslib ( http://tslib.org ) is often
> used for calibration. The one tslib module doing calibration is called
> "linear" and can be configured (the actual calibration process) with a
> graphical framebuffer application, ts_calibrate which is part of tslib.
>
>                        martin
>
> ________________________________
>
> Ginzinger electronic systems GmbH
> Gewerbegebiet Pirath 16
> 4952 Weng im Innkreis
> www.ginzinger.com
>
> Firmenbuchnummer: FN 364958d
> Firmenbuchgericht: Ried im Innkreis
> UID-Nr.: ATU66521089
>
