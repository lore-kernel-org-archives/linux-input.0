From: Matt Ranostay <matt.ranostay@konsulko.com>
Subject: Re: [PATCH 1/3] iio: hid-sensor-rotation: Add relative orientation
 sensor hid support
Date: Thu, 4 May 2017 23:18:15 -0700
Message-ID: <CAJCx=gnij32Z=0U+1sTDtipJXBKrM6AJ9R7i0sYKvc0jDnLGwg@mail.gmail.com>
References: <1493991565-17947-1-git-send-email-hongyan.song@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f170.google.com ([209.85.217.170]:33512 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752611AbdEEGSR (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 5 May 2017 02:18:17 -0400
Received: by mail-ua0-f170.google.com with SMTP id z47so22957893uaz.0
        for <linux-input@vger.kernel.org>; Thu, 04 May 2017 23:18:16 -0700 (PDT)
In-Reply-To: <1493991565-17947-1-git-send-email-hongyan.song@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Song Hongyan <hongyan.song@intel.com>
Cc: linux-input@vger.kernel.org, "open list:IIO SUBSYSTEM AND..." <linux-iio@vger.kernel.org>, jikos@kernel.org, Jonathan Cameron <jic23@kernel.org>, srinivas.pandruvada@intel.com

On Fri, May 5, 2017 at 6:39 AM, Song Hongyan <hongyan.song@intel.com> wrote:
> Relative orientation(AG) sensor is a 6dof orientation sensor,
> it depends on acceleration and gyroscope sensor data. It gives
> a quaternion describing the orientation of the device relative
> to an initial orientation. It is a standard HID sensor.
>
> More information can be found in:
> http://www.usb.org/developers/hidpage/HUTRR59_-_Usages_for_Wearables.pdf
>
> Relative orientation(AG) sensor and dev rotation sensor have same
> channels and share channel usage id. So the most of the code for
> relative orientation sensor can be reused.
>
> Signed-off-by: Song Hongyan <hongyan.song@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Reviewed-by: Xu Even <even.xu@intel.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/iio/orientation/hid-sensor-rotation.c | 22 ++++++++++++++--------
>  include/linux/hid-sensor-ids.h                |  1 +
>  2 files changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
> index a97e802c..5f07a5a 100644
> --- a/drivers/iio/orientation/hid-sensor-rotation.c
> +++ b/drivers/iio/orientation/hid-sensor-rotation.c
> @@ -218,7 +218,7 @@ static int dev_rot_parse_report(struct platform_device *pdev,
>  static int hid_dev_rot_probe(struct platform_device *pdev)
>  {
>         int ret;
> -       static char *name = "dev_rotation";
> +       static char *name;
>         struct iio_dev *indio_dev;
>         struct dev_rot_state *rot_state;
>         struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
> @@ -234,8 +234,12 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
>         rot_state->common_attributes.hsdev = hsdev;
>         rot_state->common_attributes.pdev = pdev;
>
> -       ret = hid_sensor_parse_common_attributes(hsdev,
> -                               HID_USAGE_SENSOR_DEVICE_ORIENTATION,
> +       if (hsdev->usage == HID_USAGE_SENSOR_DEVICE_ORIENTATION)
> +               name = "dev_rotation";
> +       else if (hsdev->usage == HID_USAGE_SENSOR_RELATIVE_ORIENTATION)
> +               name = "relative_orientation";

Since you have yet another "else if" in another patch in this series..
it would be better to have

switch (hsdev->usage) {
case HID_USAGE_SENSOR_DEVICE_ORIENTATION:
    name = "dev_rotation"
    break;
case HID_USAGE_SENSOR_RELATIVE_ORIENTATION:
    name = "relative_orientation";
    break;
default:
    **probably some error out if somehow we get here**
}




> +
> +       ret = hid_sensor_parse_common_attributes(hsdev, hsdev->usage,
>                                 &rot_state->common_attributes);
>         if (ret) {
>                 dev_err(&pdev->dev, "failed to setup common attributes\n");
> @@ -252,8 +256,7 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
>
>         ret = dev_rot_parse_report(pdev, hsdev,
>                                    (struct iio_chan_spec *)indio_dev->channels,
> -                                  HID_USAGE_SENSOR_DEVICE_ORIENTATION,
> -                                  rot_state);
> +                                       hsdev->usage, rot_state);
>         if (ret) {
>                 dev_err(&pdev->dev, "failed to setup attributes\n");
>                 return ret;
> @@ -288,8 +291,7 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
>         rot_state->callbacks.send_event = dev_rot_proc_event;
>         rot_state->callbacks.capture_sample = dev_rot_capture_sample;
>         rot_state->callbacks.pdev = pdev;
> -       ret = sensor_hub_register_callback(hsdev,
> -                                       HID_USAGE_SENSOR_DEVICE_ORIENTATION,
> +       ret = sensor_hub_register_callback(hsdev, hsdev->usage,
>                                         &rot_state->callbacks);
>         if (ret) {
>                 dev_err(&pdev->dev, "callback reg failed\n");
> @@ -314,7 +316,7 @@ static int hid_dev_rot_remove(struct platform_device *pdev)
>         struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>         struct dev_rot_state *rot_state = iio_priv(indio_dev);
>
> -       sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_DEVICE_ORIENTATION);
> +       sensor_hub_remove_callback(hsdev, hsdev->usage);
>         iio_device_unregister(indio_dev);
>         hid_sensor_remove_trigger(&rot_state->common_attributes);
>         iio_triggered_buffer_cleanup(indio_dev);
> @@ -327,6 +329,10 @@ static int hid_dev_rot_remove(struct platform_device *pdev)
>                 /* Format: HID-SENSOR-usage_id_in_hex_lowercase */
>                 .name = "HID-SENSOR-20008a",
>         },
> +       {
> +               /* Relatve orientation(AG) sensor */

Slight typo. Should be "Relative"
> +               .name = "HID-SENSOR-20008e",
> +       },
>         { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(platform, hid_dev_rot_ids);
> diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
> index 30c7dc4..b61b985 100644
> --- a/include/linux/hid-sensor-ids.h
> +++ b/include/linux/hid-sensor-ids.h
> @@ -82,6 +82,7 @@
>  #define HID_USAGE_SENSOR_ORIENT_TILT_Z                         0x200481
>
>  #define HID_USAGE_SENSOR_DEVICE_ORIENTATION                    0x20008A
> +#define HID_USAGE_SENSOR_RELATIVE_ORIENTATION                  0x20008E
>  #define HID_USAGE_SENSOR_ORIENT_ROTATION_MATRIX                        0x200482
>  #define HID_USAGE_SENSOR_ORIENT_QUATERNION                     0x200483
>  #define HID_USAGE_SENSOR_ORIENT_MAGN_FLUX                      0x200484
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
