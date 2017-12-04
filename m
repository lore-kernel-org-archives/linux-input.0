From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 1/4] uinput: Add ioctl for using monotonic/ boot times
Date: Mon, 4 Dec 2017 15:21:54 +0100
Message-ID: <CAK8P3a0bzqBm+3HCsxjtVbYL0-Wt3h=afnN_KQZL+xoktNUP=w@mail.gmail.com>
References: <20171204005545.23325-1-deepa.kernel@gmail.com> <20171204005545.23325-2-deepa.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:36437 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751558AbdLDOVz (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 4 Dec 2017 09:21:55 -0500
In-Reply-To: <20171204005545.23325-2-deepa.kernel@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>, Peter Hutterer <peter.hutterer@who-t.net>

On Mon, Dec 4, 2017 at 1:55 AM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> struct timeval which is part of struct input_event to
> maintain the event times is not y2038 safe.
>
> Real time timestamps are also not ideal for input_event
> as this time can go backwards as noted in the patch
> a80b83b7b8 by John Stultz.
>
> Arnd Bergmann suggested deprecating real time and using
> monotonic or other timers for all input_event times as a
> solution to both the above problems.
>
> Add a new ioctl to let the user dictate the kind of time
> to be used for input events. This is similar to the evdev
> implementation of the feature. Realtime is still the
> default time. This is to maintain backward compatibility.
>
> The structure to maintain input events will be changed
> in a different patch.

Based on Peter's comment from when you first posted this,
https://patchwork.kernel.org/patch/9381209/, I tried to follow
the code path again, to see if we can come up with a way
to avoid introducing a new ioctl.

There is one idea I had now: The two events we
get (upload and erase) are both triggered from evdev,
which gets called from user space through the EVIOCSFF
and EVIOCRMFF ioctls. This device already sets the
clock domain. Would it make sense to send the event
to the uinput owner using the same clock domain that
was set by the evdev owner, or are these two separate
by definition?

       Arnd
