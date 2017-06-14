From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH v2] HID: Replace semaphore driver_lock with mutex
Date: Wed, 14 Jun 2017 09:45:27 +0200
Message-ID: <CANq1E4SqnS2fhQjrAsdS+=i+beSNKnqZZv=Y+ctjCsSWXiHBBQ@mail.gmail.com>
References: <1497345926-3262-1-git-send-email-binoy.jayan@linaro.org>
 <CAK8P3a27bGLpisra1YDT7VntWByk6oS0Fz3e2E0-Nmf-6pVYCA@mail.gmail.com>
 <20170613095618.GB29589@mail.corp.redhat.com> <CANq1E4Two8-Qk5q=OFunE-mfuHvopY1Hm=7CrVZUaHJzBPUPyQ@mail.gmail.com>
 <CAK8P3a3bzOv6T_6mgjrEZupb4t5vi2JDZVze2qbNXmOiY1BDBA@mail.gmail.com>
 <CAHv-k_9Wxt+TkeTssLizjf5WNZAgfMy1bcXGPBfMePsNLRAY1Q@mail.gmail.com> <CAK8P3a3+TG_q62HZi-N33xh-t6a-Wc-SRjR+18x6j7957KytqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f67.google.com ([209.85.213.67]:34872 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750828AbdFNHp3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 14 Jun 2017 03:45:29 -0400
In-Reply-To: <CAK8P3a3+TG_q62HZi-N33xh-t6a-Wc-SRjR+18x6j7957KytqQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Binoy Jayan <binoy.jayan@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rajendra <rnayak@codeaurora.org>, Mark Brown <broonie@kernel.org>, Jiri Kosina <jikos@kernel.org>, David Herrmann <dh.herrmann@googlemail.com>, Andrew de los Reyes <adlr@chromium.org>

Hey

On Wed, Jun 14, 2017 at 9:20 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Jun 14, 2017 at 7:22 AM, Binoy Jayan <binoy.jayan@linaro.org> wrote:
>> Hi,
>>
>> On 14 June 2017 at 01:55, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>>>> The mutex code clearly states mutex_trylock() must not be used in
>>>> interrupt context (see kernel/locking/mutex.c), hence we used a
>>>> semaphore here. Unless the mutex code is changed to allow this, we
>>>> cannot switch away from semaphores.
>>>
>>> Right, that makes a lot of sense. I don't think changing the mutex
>>> code is an option here, but I wonder if we can replace the semaphore
>>> with something simpler anyway.
>>>
>>> From what I can tell, it currently does two things:
>>>
>>> 1. it acts as a simple flag to prevent  hid_input_report from derefencing
>>>     the hid->driver pointer during initialization and exit. I think this could
>>>     be done equally well using a simple atomic set_bit()/test_bit() or similar.
>>>
>>> 2. it prevents the hid->driver pointer from becoming invalid while an
>>>     asynchronous hid_input_report() is in progress. This actually seems to
>>>     be a reference counting problem rather than a locking problem.
>>>     I don't immediately see how to better address it, or how exactly this
>>>     could go wrong in practice, but I would naively expect that either
>>>     hdev->driver->remove() needs to wait for the last user of hdev->driver
>>>     to complete, or we need kref_get/kref_put in hid_input_report()
>>>     to trigger the actual release function.

The HID design is explained in detail in
./Documentation/hid/hid-transport.txt, in case you want some
background information. The problem here is that the low-level
transport driver has a lifetime that is independent of the hid
device-driver. So the transport driver needs to be able to tell the
HID layer about coming/going devices, as well as incoming traffic. At
the same time, the HID layer can bind upper-layer hid device drivers
*anytime* (since it is exposed via the driver core interfaces in /sys
to bind drivers).

The locking architecture is very similar to 's_active' on
super-blocks, or 'active' on kernfs-nodes. However, the big difference
here is that drivers can be rebound. Hence, we're not limited to just
one driver lifetime, which is why we went with a semaphore instead.

Also note that hid_input_report() might be called from interrupt
context, hence it can never call into kref_put() or similar (unless we
want to guarantee that unbinding can run in interrupt context).

If we really want to get rid of the semaphore, a spinlock might do
fine as well. Then again, some hid device drivers might expect their
transport driver to *not* run in irq context, and thus break under a
spinlock. So if you want to fix this, we need to audit the hid device
drivers.

David
