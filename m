From: "Pandruvada, Srinivas" <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 5/8] HID-Sensors: Added accelerometer 3D
Date: Thu, 5 Jul 2012 15:32:42 +0000
Message-ID: <4FA419E87744DF4DAECD5BCE1214B7A91935DF35@ORSMSX104.amr.corp.intel.com>
References: <1341431532-15060-1-git-send-email-srinivas.pandruvada@intel.com>
	<1341431532-15060-6-git-send-email-srinivas.pandruvada@intel.com>
 <CANq1E4R8yutQ0QWw_No4fHDwmp=YkCX_xz7KJ7gfRoy2F40CZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CANq1E4R8yutQ0QWw_No4fHDwmp=YkCX_xz7KJ7gfRoy2F40CZw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Herrmann <dh.herrmann-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "jkosina-AlSwsSmVLrQ@public.gmane.org" <jkosina-AlSwsSmVLrQ@public.gmane.org>, "lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org" <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, "jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org" <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi David,

It is a typo. There are three places in Kconfig Help, "3G" is typed instead of "3D". I will correct this.

Thanks,
Srinivas

-----Original Message-----
From: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of David Herrmann
Sent: Wednesday, July 04, 2012 2:28 PM
To: Pandruvada, Srinivas
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; jkosina-AlSwsSmVLrQ@public.gmane.org; lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org; jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org
Subject: Re: [PATCH 5/8] HID-Sensors: Added accelerometer 3D

Hi Srinivas

On Wed, Jul 4, 2012 at 9:52 PM, srinivas pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> Added usage id processing for Accelerometer 3D.This uses IIO 
> interfaces for triggerred buffer to present data to user mode.This 
> uses HID sensor framework for registering callback events from the 
> sensor hub.
>
> Signed-off-by: srinivas pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/staging/iio/accel/Kconfig               |   10 +
>  drivers/staging/iio/accel/Makefile              |    3 +
>  drivers/staging/iio/accel/hid-sensor-accel-3d.c |  451 
> +++++++++++++++++++++++
>  3 files changed, 464 insertions(+), 0 deletions(-)  create mode 
> 100644 drivers/staging/iio/accel/hid-sensor-accel-3d.c
>
> diff --git a/drivers/staging/iio/accel/Kconfig 
> b/drivers/staging/iio/accel/Kconfig
> index 5ab7167..6ab1efa 100644
> --- a/drivers/staging/iio/accel/Kconfig
> +++ b/drivers/staging/iio/accel/Kconfig
> @@ -102,4 +102,14 @@ config SCA3000
>           Say yes here to build support for the VTI SCA3000 series of SPI
>           accelerometers. These devices use a hardware ring buffer.
>
> +config HID_SENSOR_ACCEL_3D
> +       depends on HID_SENSOR_HUB
> +       select IIO_BUFFER
> +       select IIO_TRIGGERED_BUFFER
> +       select HID_SENSOR_IIO_COMMON
> +       tristate "HID Acelerometers 3D"
> +       help
> +         Say yes here to build support for the HID SENSOR
> +         accelerometers 3G.

Maybe it's just me missing something, but why do all the Kconfig entries mention "3G" instead of "3D"? I couldn't find any other place where "3G" is used, only lots of "3D". What does 3G stand for?

Or maybe I just didn't pay enough attention.. ;) Regards David
--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
