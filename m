From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [v3,1/4] input: add an EV_REL event for high-res vertical wheel
Date: Fri, 7 Apr 2017 14:17:51 +0200
Message-ID: <20170407121751.GA13764@mail.corp.redhat.com>
References: <dda7b8209731d30b1255c8cbde2efd46f71fae4b.1491564565.git.mchehab@s-opensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47752 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933348AbdDGMSN (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 7 Apr 2017 08:18:13 -0400
Content-Disposition: inline
In-Reply-To: <dda7b8209731d30b1255c8cbde2efd46f71fae4b.1491564565.git.mchehab@s-opensource.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Peter Hutterer <peter.hutterer@who-t.net>, Hans Verkuil <hans.verkuil@cisco.com>, Ping Cheng <pinglinux@gmail.com>, Kamil Debski <kamil@wypas.org>, Douglas Anderson <dianders@chromium.org>, linux-doc@vger.kernel.org

Hi Mauro,

On Apr 07 2017 or thereabouts, Mauro Carvalho Chehab wrote:
> As some devices can produce either low-res or high-res
> vertical wheel EV_REL events, add a new event to allow
> userspace to distinguish between them.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> ---
>  Documentation/input/event-codes.rst    | 16 +++++++++++++---
>  include/uapi/linux/input-event-codes.h |  1 +
>  2 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/input/event-codes.rst b/Documentation/input/event-codes.rst
> index 92db50954169..0c8591d39bc6 100644
> --- a/Documentation/input/event-codes.rst
> +++ b/Documentation/input/event-codes.rst
> @@ -185,10 +185,20 @@ instead of EV_REL codes.
>  
>  A few EV_REL codes have special meanings:
>  
> -* REL_WHEEL, REL_HWHEEL:
> +* REL_WHEEL:
>  
> -  - These codes are used for vertical and horizontal scroll wheels,
> -    respectively.
> +  - These codes are used for vertical scroll wheels.
> +
> +  - REL_WHEEL is for normal wheel operational mode, e. g. low-resolution
> +    (line-based) scroll.
> +
> +  - REL_HIRES_WHEEL should be used when the wheel has two resolutions and it
> +    is in high-resolution mode, e. g. the same angular movement that would
> +    produce a single REL_WHEEL will produce multiple REL_HIRES_WHEEL events.
> +
> +* REL_HWHEEL:
> +
> +  - This code is used for horizontal scroll wheels.
>  
>  EV_ABS
>  ------
> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> index 3af60ee69053..23b2d377af59 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -703,6 +703,7 @@
>  #define REL_DIAL		0x07
>  #define REL_WHEEL		0x08
>  #define REL_MISC		0x09
> +#define REL_HIRES_WHEEL		0x0a

There is one issue here. The HID input layer has a tendency to map
usages to REL_MISC +1, +2, +3, etc... When it doesn't know how to map an
usage, the core layer maps it to the next one.

I am not aware of devices exposing such REL axes, but I wouldn't be
surprised if the issue will not raise at some point.

We already had an issue with ABS events where ABS_MISC are conflicting
with ABS_MT_SLOTS. Luckily, we have a little empty space between
ABS_MISC and ABS_MT_SLOT, which allows userspace to detect such issues.

Could you give the define a bigger number (and maybe reserve a couple of
REL_MISC-n) to make sure that we do not end up with joysticks exporting
REL_HIRES_WHEEL?

I'll try the rest of the series on the MX Master today.

Cheers,
Benjamin

>  #define REL_MAX			0x0f
>  #define REL_CNT			(REL_MAX+1)
>  
