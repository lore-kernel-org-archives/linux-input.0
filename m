From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH v2] input: sirfsoc_pwrc: add onkey input driver for CSR
 SiRFprimaII PWRC
Date: Tue, 28 May 2013 16:07:46 +0800
Message-ID: <CAGsJ_4zY0+O6fP2bKLy__U_+-ZsWQXwZ8JXYMpRmtVe6zihfDQ@mail.gmail.com>
References: <1369709258-14529-1-git-send-email-Baohua.Song@csr.com> <20130528075808.GA19496@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:53634 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933327Ab3E1III (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 May 2013 04:08:08 -0400
Received: by mail-qc0-f176.google.com with SMTP id o10so3879931qcv.35
        for <linux-input@vger.kernel.org>; Tue, 28 May 2013 01:08:06 -0700 (PDT)
In-Reply-To: <20130528075808.GA19496@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Workgroup.Linux@csr.com, linux-arm-kernel@lists.infradead.org, Binghua Duan <Binghua.Duan@csr.com>, Xianglong Du <Xianglong.Du@csr.com>, Barry Song <Baohua.Song@csr.com>

2013/5/28 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> Hi Barry,
>
> On Tue, May 28, 2013 at 10:47:38AM +0800, Barry Song wrote:
>> +     /*
>> +      * For a typical Linux system, we report KEY_SUSPEND to trigger apm-power.c
>> +      * to queue a SUSPEND APM event
>> +      */
>> +     input_event(pwrcdrv->input, EV_PWR, KEY_SUSPEND, 1);
>> +     input_sync(pwrcdrv->input);
>> +
>> +     /*
>> +      * Todo: report KEY_POWER event for Android platforms, Android PowerManager
>> +      * will handle the suspend and powerdown/hibernation
>> +      */
>> +
> ...
>
>> +
>> +     pwrcdrv->input->evbit[0] = BIT_MASK(EV_PWR) | BIT_MASK(EV_KEY);
>> +     set_bit(KEY_POWER, pwrcdrv->input->keybit);
>
> Why are we setting up KEY_POWER if we do not send this event?

For Android products, we send KEY_POWER to let Android PM trigger
SUSPEND. that is left to be done.

>
> Thanks.
>
> --
> Dmitry

-barry
