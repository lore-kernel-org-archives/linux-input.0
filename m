From: Binoy Jayan <binoy.jayan@linaro.org>
Subject: Re: [PATCH v2] HID: Replace semaphore driver_lock with mutex
Date: Wed, 14 Jun 2017 10:52:31 +0530
Message-ID: <CAHv-k_9Wxt+TkeTssLizjf5WNZAgfMy1bcXGPBfMePsNLRAY1Q@mail.gmail.com>
References: <1497345926-3262-1-git-send-email-binoy.jayan@linaro.org>
 <CAK8P3a27bGLpisra1YDT7VntWByk6oS0Fz3e2E0-Nmf-6pVYCA@mail.gmail.com>
 <20170613095618.GB29589@mail.corp.redhat.com> <CANq1E4Two8-Qk5q=OFunE-mfuHvopY1Hm=7CrVZUaHJzBPUPyQ@mail.gmail.com>
 <CAK8P3a3bzOv6T_6mgjrEZupb4t5vi2JDZVze2qbNXmOiY1BDBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:34188 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750717AbdFNFWc (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 14 Jun 2017 01:22:32 -0400
Received: by mail-vk0-f52.google.com with SMTP id g66so75046815vki.1
        for <linux-input@vger.kernel.org>; Tue, 13 Jun 2017 22:22:32 -0700 (PDT)
In-Reply-To: <CAK8P3a3bzOv6T_6mgjrEZupb4t5vi2JDZVze2qbNXmOiY1BDBA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Herrmann <dh.herrmann@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rajendra <rnayak@codeaurora.org>, Mark Brown <broonie@kernel.org>, Jiri Kosina <jikos@kernel.org>, David Herrmann <dh.herrmann@googlemail.com>, Andrew de los Reyes <adlr@chromium.org>

Hi,

On 14 June 2017 at 01:55, Arnd Bergmann <arnd@arndb.de> wrote:

>> The mutex code clearly states mutex_trylock() must not be used in
>> interrupt context (see kernel/locking/mutex.c), hence we used a
>> semaphore here. Unless the mutex code is changed to allow this, we
>> cannot switch away from semaphores.
>
> Right, that makes a lot of sense. I don't think changing the mutex
> code is an option here, but I wonder if we can replace the semaphore
> with something simpler anyway.
>
> From what I can tell, it currently does two things:
>
> 1. it acts as a simple flag to prevent  hid_input_report from derefencing
>     the hid->driver pointer during initialization and exit. I think this could
>     be done equally well using a simple atomic set_bit()/test_bit() or similar.
>
> 2. it prevents the hid->driver pointer from becoming invalid while an
>     asynchronous hid_input_report() is in progress. This actually seems to
>     be a reference counting problem rather than a locking problem.
>     I don't immediately see how to better address it, or how exactly this
>     could go wrong in practice, but I would naively expect that either
>     hdev->driver->remove() needs to wait for the last user of hdev->driver
>     to complete, or we need kref_get/kref_put in hid_input_report()
>     to trigger the actual release function.

Thank you everyone for the comments. I'll resend the patch with Benjamin's
comments incorporated and address the changes in the second semaphore later.

Regards,
Binoy
