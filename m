From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/8] Adding PM support to hid sensor iio drivers
Date: Wed, 21 Jan 2015 21:39:55 +0000
Message-ID: <54C01CAB.40909@kernel.org>
References: <1420656960-7365-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1420656960-7365-1-git-send-email-srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, jkosina-AlSwsSmVLrQ@public.gmane.org
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 07/01/15 18:55, Srinivas Pandruvada wrote:
> Linux PM and runtime PM support.
> 
> Srinivas Pandruvada (8):
>   iio: hid_sensor_hub: Common PM functions
>   iio: hid-sensor-accel-3d: Introduce PM
>   iio: hid-sensor-gyro-3d: Introduce PM
>   iio: hid-sensor-als: Introduce PM
>   iio: hid-sensor-prox: Introduce PM
>   iio: hid-sensor-magn-3d: Introduce PM
>   iio: hid-sensor-incl-3d: Introduce PM
>   iio: hid-sensor-press: Introduce PM
> 
>  drivers/iio/accel/hid-sensor-accel-3d.c            |  8 +--
>  .../iio/common/hid-sensors/hid-sensor-trigger.c    | 76 +++++++++++++++++++++-
>  .../iio/common/hid-sensors/hid-sensor-trigger.h    |  5 ++
>  drivers/iio/gyro/hid-sensor-gyro-3d.c              |  8 +--
>  drivers/iio/light/hid-sensor-als.c                 |  9 +--
>  drivers/iio/light/hid-sensor-prox.c                | 10 +--
>  drivers/iio/magnetometer/hid-sensor-magn-3d.c      |  9 +--
>  drivers/iio/orientation/hid-sensor-incl-3d.c       |  9 +--
>  drivers/iio/pressure/hid-sensor-press.c            |  9 +--
>  9 files changed, 86 insertions(+), 57 deletions(-)
> 
Series applied to the togreg branch of iio.git.
First patch caused a bit of fuzz- probably due to my picking up the
series you sent based on time I have to review them (rather than in
the original order).

Anyhow, pushed out as testing for the autobuilders to play with it.
