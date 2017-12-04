From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 4/4] input: serio: Replace timeval by timespec64
Date: Mon, 4 Dec 2017 14:44:40 +0100
Message-ID: <CAK8P3a3xa3erifBXncz7PDD+322XXw+52E3VJ=dO3F0QTHmmFg@mail.gmail.com>
References: <20171204005545.23325-1-deepa.kernel@gmail.com> <20171204005545.23325-5-deepa.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:44400 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752540AbdLDNol (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 4 Dec 2017 08:44:41 -0500
In-Reply-To: <20171204005545.23325-5-deepa.kernel@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>

On Mon, Dec 4, 2017 at 1:55 AM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> struct timeval is not y2038 safe.
> All references to timeval will be deleted from the
> kernel to make it y2038 safe.
> Replace its uses by y2038 safe struct timespec64.
>
> The timestamps changed here only keep track of delta
> times. These timestamps are also internal to kernel.
> Hence, monotonic times are sufficient here.
> The unit of the delta times is also changed in certain
> cases to nanoseconds rather than microseconds. This is
> in line with timespec64 which keeps time in nanoseconds.
>
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Hi Deepa,

I forgot you also had these on your backlog. I submitted a different
set of patches
two weeks ago for the two HP drivers, originally by Pingbo Wen, based on a
different approach.

That version simplified the code in question a bit more by using jiffies,
while your version is a little safer since it changes less. Both versions
should be fine though, it's up to Dmitry which one he wants to pick up.

      Arnd
