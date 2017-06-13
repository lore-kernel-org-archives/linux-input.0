From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] HID: Replace semaphore driver_lock with mutex
Date: Tue, 13 Jun 2017 22:00:44 +0200
Message-ID: <CAK8P3a03nW5wVX3zZpN9xj5D=0omfeewD9jG=EjU-1_V9b5WvA@mail.gmail.com>
References: <1497345926-3262-1-git-send-email-binoy.jayan@linaro.org>
 <CAK8P3a27bGLpisra1YDT7VntWByk6oS0Fz3e2E0-Nmf-6pVYCA@mail.gmail.com>
 <20170613095618.GB29589@mail.corp.redhat.com> <CAHv-k_9zTAjiubsjmbRfpMRTSxv214452+xXyw5A3RFZKbQFpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:32833 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753875AbdFMUAq (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 13 Jun 2017 16:00:46 -0400
In-Reply-To: <CAHv-k_9zTAjiubsjmbRfpMRTSxv214452+xXyw5A3RFZKbQFpA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Binoy Jayan <binoy.jayan@linaro.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rajendra <rnayak@codeaurora.org>, Mark Brown <broonie@kernel.org>, Jiri Kosina <jikos@kernel.org>, David Herrmann <dh.herrmann@googlemail.com>, Andrew de los Reyes <adlr@chromium.org>

On Tue, Jun 13, 2017 at 12:09 PM, Binoy Jayan <binoy.jayan@linaro.org> wrote:
> Hi,
>
> On 13 June 2017 at 15:26, Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
>
>>> Looks good to me, but I see you didn't include David and Andrew on
>>> Cc, it would be good for at least one of them to provide an Ack as well.
>>
>> Please also CC linux-input@
>
> Will do that.
>> (one more nitpick below too)
>> A little bit below, there is:
>>         bool io_started;                                                /* Protected by driver_lock. If IO has started */
>>
>> You should probably remove the mention to driver_lock here.
>
> Will remove the reference too.
>
> Thank you for noticing that, initially I missed it as I thought
> 'io_started' somehow
> influences the increment of the semaphore, but its anyway used only in
> hid-core.c

It is also used in hid_device_io_start()  and hid_device_io_stop(), but
what's important here is that these are only ever called from inside of
hid_device_probe() and other functions called by that, so no
synchronization across CPUs is required here.

I think in theory, it could be accessed from below hid_device_remove
as well, but I did not find any instance of that.

        Arnd
