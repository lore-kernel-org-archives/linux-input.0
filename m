From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH v2] HID: Replace semaphore driver_lock with mutex
Date: Tue, 13 Jun 2017 17:43:52 +0200
Message-ID: <CANq1E4Two8-Qk5q=OFunE-mfuHvopY1Hm=7CrVZUaHJzBPUPyQ@mail.gmail.com>
References: <1497345926-3262-1-git-send-email-binoy.jayan@linaro.org>
 <CAK8P3a27bGLpisra1YDT7VntWByk6oS0Fz3e2E0-Nmf-6pVYCA@mail.gmail.com> <20170613095618.GB29589@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f180.google.com ([209.85.217.180]:34736 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750899AbdFMPny (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 13 Jun 2017 11:43:54 -0400
In-Reply-To: <20170613095618.GB29589@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Binoy Jayan <binoy.jayan@linaro.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rajendra <rnayak@codeaurora.org>, Mark Brown <broonie@kernel.org>, Jiri Kosina <jikos@kernel.org>, David Herrmann <dh.herrmann@googlemail.com>, Andrew de los Reyes <adlr@chromium.org>

Hi

On Tue, Jun 13, 2017 at 11:56 AM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>> > -       struct semaphore driver_lock;                                   /* protects the current driver, except during input */
>> > +       struct mutex driver_lock;                                       /* protects the current driver, except during input */
>> >         struct semaphore driver_input_lock;                             /* protects the current driver */
>
> Unless I am mistaken, this one could also be converted to a mutex (in a
> separate patch, of course).

The mutex code clearly states mutex_trylock() must not be used in
interrupt context (see kernel/locking/mutex.c), hence we used a
semaphore here. Unless the mutex code is changed to allow this, we
cannot switch away from semaphores.

Otherwise, this patch (given Benjamin's comments are addressed) looks good:

Reviewed-by: David Herrmann <dh.herrmann@gmail.com>

Thanks
David
