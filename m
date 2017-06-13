From: Binoy Jayan <binoy.jayan@linaro.org>
Subject: Re: [PATCH v2] HID: Replace semaphore driver_lock with mutex
Date: Tue, 13 Jun 2017 15:39:28 +0530
Message-ID: <CAHv-k_9zTAjiubsjmbRfpMRTSxv214452+xXyw5A3RFZKbQFpA@mail.gmail.com>
References: <1497345926-3262-1-git-send-email-binoy.jayan@linaro.org>
 <CAK8P3a27bGLpisra1YDT7VntWByk6oS0Fz3e2E0-Nmf-6pVYCA@mail.gmail.com> <20170613095618.GB29589@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f179.google.com ([209.85.217.179]:33751 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752033AbdFMKJa (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 13 Jun 2017 06:09:30 -0400
Received: by mail-ua0-f179.google.com with SMTP id 68so54855549uas.0
        for <linux-input@vger.kernel.org>; Tue, 13 Jun 2017 03:09:29 -0700 (PDT)
In-Reply-To: <20170613095618.GB29589@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rajendra <rnayak@codeaurora.org>, Mark Brown <broonie@kernel.org>, Jiri Kosina <jikos@kernel.org>, David Herrmann <dh.herrmann@googlemail.com>, Andrew de los Reyes <adlr@chromium.org>

Hi,

On 13 June 2017 at 15:26, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:

>> Looks good to me, but I see you didn't include David and Andrew on
>> Cc, it would be good for at least one of them to provide an Ack as well.
>
> Please also CC linux-input@

Will do that.
> (one more nitpick below too)
> A little bit below, there is:
>         bool io_started;                                                /* Protected by driver_lock. If IO has started */
>
> You should probably remove the mention to driver_lock here.

Will remove the reference too.

>> > -       struct semaphore driver_lock;                                   /* protects the current driver, except during input */
>> > +       struct mutex driver_lock;                                       /* protects the current driver, except during input */
>> >         struct semaphore driver_input_lock;                             /* protects the current driver */
>
> Unless I am mistaken, this one could also be converted to a mutex (in a
> separate patch, of course).

Thank you for noticing that, initially I missed it as I thought
'io_started' somehow
influences the increment of the semaphore, but its anyway used only in
hid-core.c

Thanks,
Binoy
