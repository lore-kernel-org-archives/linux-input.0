From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH v4 0/4] Make input drivers y2038 safe
Date: Thu, 14 Dec 2017 15:33:37 +1000
Message-ID: <20171214053255.GA4638@jelly>
References: <20171207181306.5623-1-deepa.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:57448 "EHLO
        mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750844AbdLNFdr (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 14 Dec 2017 00:33:47 -0500
Content-Disposition: inline
In-Reply-To: <20171207181306.5623-1-deepa.kernel@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org

On Thu, Dec 07, 2017 at 10:13:02AM -0800, Deepa Dinamani wrote:
> The series is aimed at making input events y2038 safe.
> It extends the lifetime of the realtime timestamps in the
> events to year 2106.
> The series is also a necessary update as glibc is set to provide
> 64 bit time_t support for 32 bit binaries. glibc plan is detailed
> at https://sourceware.org/glibc/wiki/Y2038ProofnessDesign .
> 
> The series is a result of discussions with Arnd Bergmann and
> Dmitry Torokhov at last Plumbers.
> 
> The plan is to deprecate realtime timestamps anyway as they
> are not appropriate for these timestamps as noted in the patch
> a80b83b7b8 by John Stultz.
> 
> The design also updates the format of the input events read/ written
> to the device nodes. This breaks 32 bit interface to the input
> events at compile time as preferred by the maintainer.
> 
> The userspace library changes to libevdev, libuinput and mtdev
> will be posted to the respective mailing groups for review.

Acked-by: Peter Hutterer <peter.hutterer@who-t.net>

Cheers,
   Peter

> Changes from v3:
> * Updated uinput to support monotonic time only
> * Addressed review comments
> Changes from v2:
> * Updated the design to break 32 bit interfaces at compile time.
> Changes from v1:
> * Updated changes according to review comments.
> * Posted userspace library changes that go along with the series.
> 
> Deepa Dinamani (4):
>   uinput: Use monotonic times for uinput timestamps.
>   input: evdev: Replace timeval with timespec64
>   input: Deprecate real timestamps beyond year 2106
>   input: serio: Replace timeval by timespec64
> 
>  drivers/input/evdev.c            | 43 +++++++++++++++++++++++++---------------
>  drivers/input/input-compat.c     | 11 +++++-----
>  drivers/input/input-compat.h     |  3 ++-
>  drivers/input/misc/uinput.c      |  5 ++++-
>  drivers/input/serio/hil_mlc.c    | 37 +++++++++++++++++-----------------
>  drivers/input/serio/hp_sdc.c     | 17 ++++++++--------
>  drivers/input/serio/hp_sdc_mlc.c | 10 +++++-----
>  include/linux/hil_mlc.h          |  6 +++---
>  include/linux/hp_sdc.h           |  6 +++---
>  include/uapi/linux/input.h       | 12 ++++++++++-
>  10 files changed, 88 insertions(+), 62 deletions(-)
> 
> 
> base-commit: b0a84f19a5161418d4360cd57603e94ed489915e
> -- 
> 2.14.1
> 
