From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH v2] Input: evdev - Flush queues during EVIOCGKEY-like ioctls
Date: Thu, 28 Mar 2013 10:52:49 +0100
Message-ID: <CANq1E4Q1MmwrqrHsrL_pZOjU3LWQgh1k8Kma7KDYSJqF+CAuuA@mail.gmail.com>
References: <1364431764-31378-1-git-send-email-dh.herrmann@gmail.com>
	<20130328050635.GA2812@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:37849 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756149Ab3C1Jwu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Mar 2013 05:52:50 -0400
Received: by mail-la0-f52.google.com with SMTP id fs12so17226104lab.39
        for <linux-input@vger.kernel.org>; Thu, 28 Mar 2013 02:52:49 -0700 (PDT)
In-Reply-To: <20130328050635.GA2812@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry

On Thu, Mar 28, 2013 at 6:06 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Thu, Mar 28, 2013 at 01:49:24AM +0100, David Herrmann wrote:
>> +     spin_lock_irq(&dev->event_lock);
>> +     spin_lock(&client->buffer_lock);
>> +
>> +     ret = bits_to_user(bits, max, size, p, compat);
>
> This copies data to userspace and thus may sleep. You can not hold spinlocks
> here.
>
> I think you need to collect the data, flush the events and then try
> copying the data out. If we fail on copying data out - too bad. Maybe we
> can stuff SYN_DROPPED in the queue, but it is not really necessary.

Ugh, I need to turn on CONFIG_DEBUG_ATOMIC_SLEEP again. Thanks for
catching it. I will allocate a temporary buffer and queue SYN_DROPPED
if the copy to userspace fails after that.

While we are at it, I stumbled across
bits_to_user()+CONFIG_COMPAT+LITTLE_ENDIAN. How is that supposed to
work? If sizeof(compat_long_t) == 4 and sizeof(long) == 8, we end up
splitting each key-state across two compat_long_t entries of the user.
Maybe I'm just missing something, but I think we cannot special-case
little-endian here. Could you have a look?

And I have a small helper to test EVIOCGKEY+flush. Should I add it to
the new kernel test-suite?

Thanks
David
