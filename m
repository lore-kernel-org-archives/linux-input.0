From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH v3] Input: uinput - add new UINPUT_DEV_SETUP and
 UI_ABS_SETUP ioctl
Date: Mon, 21 Sep 2015 12:45:25 +0200
Message-ID: <CANq1E4RihBei-eanwKfMxw6BA3oYPnhRST6yPqY6NKgWHgNcyQ@mail.gmail.com>
References: <1440515579-5359-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:34296 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753391AbbIUKp1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Sep 2015 06:45:27 -0400
In-Reply-To: <1440515579-5359-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

Hi Dmitry

Any comment on this?

Thanks
David

On Tue, Aug 25, 2015 at 5:12 PM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> This adds two new ioctls, UINPUT_DEV_SETUP and UI_ABS_SETUP, that
> replaces the old device setup method (by write()'ing "struct
> uinput_user_dev" to the node). The old method is not easily extendable
> and requires huge payloads. Furthermore, overloading write() without
> properly versioned objects is error-prone.
>
> Therefore, we introduce two new ioctls to replace the old method.
> These ioctls support all features of the old method, plus a "resolution"
> field for absinfo. Furthermore, it's properly forward-compatible to new
> ABS codes and a growing "struct input_absinfo" structure.
>
> UI_ABS_SETUP also allows user-space to skip unknown axes if not set.
> There is no need to copy the whole array temporarily into the kernel,
> but instead the caller issues several ioctl where we copy each value
> manually.
>
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Reviewed-by: David Herrmann <dh.herrmann@gmail.com>
> ---
>
> Changes from v2:
> - returned E2BIG when the userspace has been compiled against a newer kernel
>   than the current one
> - formatting changes
> - remove extra memset
>
>
>  drivers/input/misc/uinput.c | 80 +++++++++++++++++++++++++++++++++++++++++--
>  include/linux/uinput.h      |  5 +++
>  include/uapi/linux/uinput.h | 83 +++++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 162 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
> index 345df9b..7af1e54 100644
> --- a/drivers/input/misc/uinput.c
> +++ b/drivers/input/misc/uinput.c
> @@ -370,8 +370,73 @@ static int uinput_allocate_device(struct uinput_device *udev)
>         return 0;
>  }
>
> -static int uinput_setup_device(struct uinput_device *udev,
> -                              const char __user *buffer, size_t count)
> +static int uinput_dev_setup(struct uinput_device *udev,
> +                           struct uinput_setup __user *arg)
> +{
> +       struct uinput_setup setup;
> +       struct input_dev *dev;
> +       int retval;
> +
> +       if (udev->state == UIST_CREATED)
> +               return -EINVAL;
> +       if (copy_from_user(&setup, arg, sizeof(setup)))
> +               return -EFAULT;
> +       if (!setup.name[0])
> +               return -EINVAL;
> +
> +       dev = udev->dev;
> +       dev->id = setup.id;
> +       udev->ff_effects_max = setup.ff_effects_max;
> +
> +       kfree(dev->name);
> +       dev->name = kstrndup(setup.name, UINPUT_MAX_NAME_SIZE, GFP_KERNEL);
> +       if (!dev->name)
> +               return -ENOMEM;
> +
> +       retval = uinput_validate_absbits(dev);
> +       if (retval < 0)
> +               return retval;
> +
> +       udev->state = UIST_SETUP_COMPLETE;
> +       return 0;
> +}
> +
> +static int uinput_abs_setup(struct uinput_device *udev,
> +                           struct uinput_setup __user *arg, size_t size)
> +{
> +       struct uinput_abs_setup setup = {};
> +       struct input_dev *dev;
> +
> +       if (size > sizeof(setup))
> +               return -E2BIG;
> +       if (udev->state == UIST_CREATED)
> +               return -EINVAL;
> +       if (copy_from_user(&setup, arg, size))
> +               return -EFAULT;
> +       if (setup.code > ABS_MAX)
> +               return -ERANGE;
> +
> +       dev = udev->dev;
> +
> +       input_alloc_absinfo(dev);
> +       if (!dev->absinfo)
> +               return -ENOMEM;
> +
> +       set_bit(setup.code, dev->absbit);
> +       dev->absinfo[setup.code] = setup.absinfo;
> +
> +       /*
> +        * We restore the state to UIST_NEW_DEVICE because the user has to call
> +        * UI_DEV_SETUP in the last place before UI_DEV_CREATE to check the
> +        * validity of the absbits.
> +        */
> +       udev->state = UIST_NEW_DEVICE;
> +       return 0;
> +}
> +
> +/* legacy setup via write() */
> +static int uinput_setup_device_legacy(struct uinput_device *udev,
> +                                     const char __user *buffer, size_t count)
>  {
>         struct uinput_user_dev  *user_dev;
>         struct input_dev        *dev;
> @@ -474,7 +539,7 @@ static ssize_t uinput_write(struct file *file, const char __user *buffer,
>
>         retval = udev->state == UIST_CREATED ?
>                         uinput_inject_events(udev, buffer, count) :
> -                       uinput_setup_device(udev, buffer, count);
> +                       uinput_setup_device_legacy(udev, buffer, count);
>
>         mutex_unlock(&udev->mutex);
>
> @@ -735,6 +800,12 @@ static long uinput_ioctl_handler(struct file *file, unsigned int cmd,
>                         uinput_destroy_device(udev);
>                         goto out;
>
> +               case UI_DEV_SETUP:
> +                       retval = uinput_dev_setup(udev, p);
> +                       goto out;
> +
> +               /* UI_ABS_SETUP is handled in the variable size ioctls */
> +
>                 case UI_SET_EVBIT:
>                         retval = uinput_set_bit(arg, evbit, EV_MAX);
>                         goto out;
> @@ -879,6 +950,9 @@ static long uinput_ioctl_handler(struct file *file, unsigned int cmd,
>                 name = dev_name(&udev->dev->dev);
>                 retval = uinput_str_to_user(p, name, size);
>                 goto out;
> +       case UI_ABS_SETUP & ~IOCSIZE_MASK:
> +               retval = uinput_abs_setup(udev, p, size);
> +               goto out;
>         }
>
>         retval = -EINVAL;
> diff --git a/include/linux/uinput.h b/include/linux/uinput.h
> index 0994c0d..75de43d 100644
> --- a/include/linux/uinput.h
> +++ b/include/linux/uinput.h
> @@ -20,6 +20,11 @@
>   * Author: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
>   *
>   * Changes/Revisions:
> + *     0.5     08/13/2015 (David Herrmann <dh.herrmann@gmail.com> &
> + *                         Benjamin Tissoires <benjamin.tissoires@redhat.com>)
> + *             - add UI_DEV_SETUP ioctl
> + *             - add UI_ABS_SETUP ioctl
> + *             - add UI_GET_VERSION ioctl
>   *     0.4     01/09/2014 (Benjamin Tissoires <benjamin.tissoires@redhat.com>)
>   *             - add UI_GET_SYSNAME ioctl
>   *     0.3     24/05/2006 (Anssi Hannula <anssi.hannulagmail.com>)
> diff --git a/include/uapi/linux/uinput.h b/include/uapi/linux/uinput.h
> index 013c9d8..ef6c9f5 100644
> --- a/include/uapi/linux/uinput.h
> +++ b/include/uapi/linux/uinput.h
> @@ -20,6 +20,11 @@
>   * Author: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
>   *
>   * Changes/Revisions:
> + *     0.5     08/13/2015 (David Herrmann <dh.herrmann@gmail.com> &
> + *                         Benjamin Tissoires <benjamin.tissoires@redhat.com>)
> + *             - add UI_DEV_SETUP ioctl
> + *             - add UI_ABS_SETUP ioctl
> + *             - add UI_GET_VERSION ioctl
>   *     0.4     01/09/2014 (Benjamin Tissoires <benjamin.tissoires@redhat.com>)
>   *             - add UI_GET_SYSNAME ioctl
>   *     0.3     24/05/2006 (Anssi Hannula <anssi.hannulagmail.com>)
> @@ -37,8 +42,8 @@
>  #include <linux/types.h>
>  #include <linux/input.h>
>
> -#define UINPUT_VERSION         4
> -
> +#define UINPUT_VERSION         5
> +#define UINPUT_MAX_NAME_SIZE   80
>
>  struct uinput_ff_upload {
>         __u32                   request_id;
> @@ -58,6 +63,79 @@ struct uinput_ff_erase {
>  #define UI_DEV_CREATE          _IO(UINPUT_IOCTL_BASE, 1)
>  #define UI_DEV_DESTROY         _IO(UINPUT_IOCTL_BASE, 2)
>
> +struct uinput_setup {
> +       struct input_id id;
> +       char name[UINPUT_MAX_NAME_SIZE];
> +       __u32 ff_effects_max;
> +};
> +
> +/**
> + * UI_DEV_SETUP - Set device parameters for setup
> + *
> + * This ioctl sets parameters for the input-device to be created. It must be
> + * issued *before* calling UI_DEV_CREATE or it will fail. This ioctl supersedes
> + * the old "struct uinput_user_dev" method, which wrote this data via write().
> + * To actually set the absolute axes, you also need to call the ioctl
> + * UI_ABS_SETUP *before* calling this ioctl.
> + *
> + * This ioctl takes a "struct uinput_setup" object as argument. The fields of
> + * this object are as follows:
> + *              id: See the description of "struct input_id". This field is
> + *                  copied unchanged into the new device.
> + *            name: This is used unchanged as name for the new device.
> + *  ff_effects_max: This limits the maximum numbers of force-feedback effects.
> + *                  See below for a description of FF with uinput.
> + *
> + * This ioctl can be called multiple times and will overwrite previous values.
> + * If this ioctl fails with -EINVAL, you're recommended to use the old
> + * "uinput_user_dev" method via write() as fallback, in case you run on an old
> + * kernel that does not support this ioctl.
> + *
> + * This ioctl may fail with -EINVAL if it is not supported or if you passed
> + * incorrect values, -ENOMEM if the kernel runs out of memory or -EFAULT if the
> + * passed uinput_setup object cannot be read/written.
> + * If this call fails, partial data may have already been applied to the
> + * internal device.
> + */
> +#define UI_DEV_SETUP _IOW(UINPUT_IOCTL_BASE, 3, struct uinput_setup)
> +
> +struct uinput_abs_setup {
> +       __u16  code; /* axis code */
> +       /* __u16 filler; */
> +       struct input_absinfo absinfo;
> +};
> +
> +/**
> + * UI_ABS_SETUP - Set absolute axis information for the device to setup
> + *
> + * This ioctl sets one absolute axis information for the input-device to be
> + * created. It must be issued *before* calling UI_DEV_SETUP and UI_DEV_CREATE
> + * for every absolute axis the device exports.
> + * This ioctl supersedes the old "struct uinput_user_dev" method, which wrote
> + * part of this data and the content of UI_DEV_SETUP via write().
> + *
> + * This ioctl takes a "struct uinput_abs_setup" object as argument. The fields
> + * of this object are as follows:
> + *            code: The corresponding input code associated with this axis
> + *                  (ABS_X, ABS_Y, etc...)
> + *         absinfo: See "struct input_absinfo" for a description of this field.
> + *                  This field is copied unchanged into the kernel for the
> + *                  specified axis. If the axis is not enabled via
> + *                  UI_SET_ABSBIT, this ioctl will enable it.
> + *
> + * This ioctl can be called multiple times and will overwrite previous values.
> + * If this ioctl fails with -EINVAL, you're recommended to use the old
> + * "uinput_user_dev" method via write() as fallback, in case you run on an old
> + * kernel that does not support this ioctl.
> + *
> + * This ioctl may fail with -EINVAL if it is not supported or if you passed
> + * incorrect values, -ENOMEM if the kernel runs out of memory or -EFAULT if the
> + * passed uinput_setup object cannot be read/written.
> + * If this call fails, partial data may have already been applied to the
> + * internal device.
> + */
> +#define UI_ABS_SETUP _IOW(UINPUT_IOCTL_BASE, 4, struct uinput_abs_setup)
> +
>  #define UI_SET_EVBIT           _IOW(UINPUT_IOCTL_BASE, 100, int)
>  #define UI_SET_KEYBIT          _IOW(UINPUT_IOCTL_BASE, 101, int)
>  #define UI_SET_RELBIT          _IOW(UINPUT_IOCTL_BASE, 102, int)
> @@ -144,7 +222,6 @@ struct uinput_ff_erase {
>  #define UI_FF_UPLOAD           1
>  #define UI_FF_ERASE            2
>
> -#define UINPUT_MAX_NAME_SIZE   80
>  struct uinput_user_dev {
>         char name[UINPUT_MAX_NAME_SIZE];
>         struct input_id id;
> --
> 2.4.3
>
