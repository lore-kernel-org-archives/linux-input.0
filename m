From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 1/4] uinput: Use monotonic times for uinput timestamps.
Date: Thu, 7 Dec 2017 23:24:31 +0100
Message-ID: <CAK8P3a3FaN86_qOLjXGO=d4QLmX6vS5veHGcky_NJNebyMG7rw@mail.gmail.com>
References: <20171207181306.5623-1-deepa.kernel@gmail.com> <20171207181306.5623-2-deepa.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:39335 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751001AbdLGWYc (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 7 Dec 2017 17:24:32 -0500
In-Reply-To: <20171207181306.5623-2-deepa.kernel@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>, y2038 Mailman List <y2038@lists.linaro.org>

On Thu, Dec 7, 2017 at 7:13 PM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> struct timeval which is part of struct input_event to
> maintain the event times is not y2038 safe.
>
> Real time timestamps are also not ideal for input_event
> as this time can go backwards as noted in the patch
> a80b83b7b8 by John Stultz.
>
> The patch switches the timestamps to use monotonic time
> from realtime time. This is assuming no one is using
> absolute times from these timestamps.
>
> The structure to maintain input events will be changed
> in a different patch.
>
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
