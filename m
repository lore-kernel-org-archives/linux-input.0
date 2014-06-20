From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [RFC] Input: uinput - add new UINPUT_DEV_SETUP ioctl
Date: Fri, 20 Jun 2014 10:55:57 +1000
Message-ID: <20140620005557.GA22050@jelly.redhat.com>
References: <1403183515-15621-1-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:41904 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753798AbaFTA4B (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Jun 2014 20:56:01 -0400
Content-Disposition: inline
In-Reply-To: <1403183515-15621-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>

On Thu, Jun 19, 2014 at 03:11:55PM +0200, David Herrmann wrote:
> This adds a new ioctl UINPUT_DEV_SETUP that replaces the old device setup
> method (by write()'ing "struct uinput_user_dev" to the node). The old
> method is not easily extendable and requires huge payloads. Furthermore,
> overloading write() without properly versioned objects is error-prone.
> 
> Therefore, we introduce a new ioctl to replace the old method. The ioctl
> supports all features of the old method, plus a "resolution" field for
> absinfo. Furthermore, it's properly forward-compatible to new ABS codes
> and a growing "struct input_absinfo" structure.
> 
> The ioctl also allows user-space to skip unknown axes if not set. The
> payload-size can now be specified by the caller. There is no need to copy
> the whole array temporarily into the kernel, but instead we can iterate
> over it and copy each value manually.
> 
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> ---
> Hi
> 
> I replaced my old approach with a new ioctl(). In my opinion the write() method
> for setup is error-prone and hard to replace correctly with a dynamic structure
> like I did for this ioctl. The ioctl-way is also much more flexible and allows
> read _and_ write in the same call.
> 
> This is untested so far, just wanted to get it out as Peter asked for it.
> 
> Btw., this should even perform better than the old method as it avoids copying
> the whole object from the user into a temporary buffer.
> 
> Comments?

so on the whole, works for me. the API is a bit clunky with the various
sizeofs() but I'm not sure how to make this any better. One thought would be
a UI_SET_ABSINFO(abs_cnt, sizeof(input_absinfo), *data) that can set the
absinfo for a set of axes. You'd still need sizeof(input_absinfo) but the
rest of userspace would largely stay the same.

The main problem here is that you'd need a kernel behaviour change:
either ignore the abs axes in the write() once the new ioctl has been
called, or allow for absinfo of min/max 0/0 for axes already set.
I'm not a big fan of either.

>  drivers/input/misc/uinput.c | 83 +++++++++++++++++++++++++++++++++++++++++++--
>  include/uapi/linux/uinput.h | 79 ++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 156 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
> index 615324c..e3952f4 100644
> --- a/drivers/input/misc/uinput.c
> +++ b/drivers/input/misc/uinput.c
> @@ -371,8 +371,81 @@ static int uinput_allocate_device(struct uinput_device *udev)
>  	return 0;
>  }
>  
> -static int uinput_setup_device(struct uinput_device *udev,
> -			       const char __user *buffer, size_t count)
> +static int uinput_dev_setup(struct uinput_device *udev,
> +			    struct uinput_setup __user *arg)
> +{
> +	struct uinput_setup setup;
> +	struct input_dev *dev;
> +	int i, retval;
> +	u16 ver;
> +
> +	/*
> +	 * Currently, we require:
> +	 *   setup.size >= sizeof(struct uinput_setup)
> +	 *   setup.absinfo_size >= sizeof(struct input_absinfo)
> +	 * because we only support the initial version of uinput_setup. In case
> +	 * we extend this type, we need to adjust those checks and fall-back to
> +	 * older types if we run old user-space.
> +	 */
> +
> +	if (get_user(setup.size, (__u64 __user*)arg))
> +		return -EFAULT;
> +	if (setup.size < sizeof(struct uinput_setup))
> +		return -EINVAL;
> +	if (copy_from_user(&setup, arg, sizeof(setup)))
> +		return -EFAULT;
> +
> +	ver = setup.version;
> +	if (put_user((__u16)UINPUT_VERSION, &arg->version))
> +		return -EFAULT;
> +	if (ver > UINPUT_VERSION)
> +		return -EOPNOTSUPP;

see my comments at the end of this email, other than that the code looks
good.

> +
> +	if (!setup.name[0])
> +		return -EINVAL;
> +	if (setup.absinfo_size < sizeof(struct input_absinfo))
> +		return -EINVAL;
> +
> +	dev = udev->dev;
> +	dev->id = setup.id;
> +	udev->ff_effects_max = setup.ff_effects_max;
> +
> +	kfree(dev->name);
> +	dev->name = kstrndup(setup.name, UINPUT_MAX_NAME_SIZE, GFP_KERNEL);
> +	if (!dev->name)
> +		return -ENOMEM;
> +
> +	if (setup.abs_cnt > ABS_CNT)
> +		setup.abs_cnt = ABS_CNT;
> +
> +	if (setup.abs_cnt > 0) {
> +		input_alloc_absinfo(dev);
> +		if (!dev->absinfo)
> +			return -ENOMEM;
> +
> +		for (i = 0; i < setup.abs_cnt; ++i) {
> +			struct input_absinfo absinfo;
> +			u8 __user *p = (u8 __user*)arg->abs;
> +
> +			if (copy_from_user(&absinfo, p, sizeof(absinfo)))
> +				return -EFAULT;
> +
> +			dev->absinfo[i] = absinfo;
> +			p += setup.absinfo_size;
> +		}
> +	}
> +
> +	retval = uinput_validate_absbits(dev);
> +	if (retval < 0)
> +		return retval;
> +
> +	udev->state = UIST_SETUP_COMPLETE;
> +	return 0;
> +}
> +
> +/* legacy setup via write() */
> +static int __uinput_setup_device(struct uinput_device *udev,
> +				 const char __user *buffer, size_t count)

wouldn't it be more obvious to rename this to "....legacy" or so?

>  {
>  	struct uinput_user_dev	*user_dev;
>  	struct input_dev	*dev;
> @@ -475,7 +548,7 @@ static ssize_t uinput_write(struct file *file, const char __user *buffer,
>  
>  	retval = udev->state == UIST_CREATED ?
>  			uinput_inject_events(udev, buffer, count) :
> -			uinput_setup_device(udev, buffer, count);
> +			__uinput_setup_device(udev, buffer, count);
>  
>  	mutex_unlock(&udev->mutex);
>  
> @@ -730,6 +803,10 @@ static long uinput_ioctl_handler(struct file *file, unsigned int cmd,
>  			uinput_destroy_device(udev);
>  			goto out;
>  
> +		case UI_DEV_SETUP:
> +			retval = uinput_dev_setup(udev, p);
> +			goto out;
> +
>  		case UI_SET_EVBIT:
>  			retval = uinput_set_bit(arg, evbit, EV_MAX);
>  			goto out;
> diff --git a/include/uapi/linux/uinput.h b/include/uapi/linux/uinput.h
> index 0389b48..bafc0dd 100644
> --- a/include/uapi/linux/uinput.h
> +++ b/include/uapi/linux/uinput.h
> @@ -20,6 +20,8 @@
>   * Author: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
>   *
>   * Changes/Revisions:
> + *	0.5	06/19/2014 (David Herrmann <dh.herrmann@gmail.com>
> + *		- add UI_DEV_SETUP ioctl

how comes the version here is 0.5 but the UINPUT_VERSION is 5? where does
the 0 come from?


>   *	0.4	01/09/2014 (Benjamin Tissoires <benjamin.tissoires@redhat.com>)
>   *		- add UI_GET_SYSNAME ioctl
>   *	0.3	24/05/2006 (Anssi Hannula <anssi.hannulagmail.com>)
> @@ -37,8 +39,8 @@
>  #include <linux/types.h>
>  #include <linux/input.h>
>  
> -#define UINPUT_VERSION		4
> -
> +#define UINPUT_VERSION		5
> +#define UINPUT_MAX_NAME_SIZE	80
>  
>  struct uinput_ff_upload {
>  	__u32			request_id;
> @@ -84,6 +86,78 @@ struct uinput_ff_erase {
>   */
>  #define UI_GET_SYSNAME(len)	_IOC(_IOC_READ, UINPUT_IOCTL_BASE, 300, len)
>  
> +struct uinput_setup {
> +	__u32 size;
> +	__u32 absinfo_size;
> +	struct input_id id;
> +	char name[UINPUT_MAX_NAME_SIZE];
> +	__u32 ff_effects_max;
> +	__u16 version;
> +	__u16 abs_cnt;
> +	struct input_absinfo abs[];
> +};
> +
> +/**
> + * UI_DEV_SETUP - Set device parameters for setup
> + *
> + * This ioctl sets parameters for the input-device to be created. It must be
> + * issued _before_ calling UI_DEV_CREATE or it will fail. This ioctl supersedes
> + * the old "struct uinput_user_dev" method, which wrote this data via write().
> + *
> + * This ioctl takes a "struct uinput_setup" object as argument. The fields of
> + * this object are as follows:
> + *            size: This field _must_ be initialized to
> + *                  "sizeof(struct uinput_setup)". It *may not* include the

s/may/must/

also, I notice different markup: "_must_" but "*may not*", is this intended?

> + *                  size of the "abs" array at its end. The kernel uses this
> + *                  field to detect the revision of this ioctl. "uinput_setup"
> + *                  might be increased in the future, but will always be

s/increased/enlarged/

> + *                  backwards compatible. If you pass a new object to an old
> + *                  kernel, the kernel will ignore unknown new fields.
> + *    absinfo_size: This field _must_ be initialized to
> + *                  "sizeof(struct input_absinfo)". It allows to extend the API
> + *                  to support more absinfo fields. Older kernels ignore unknown
> + *                  extensions to "struct input_absinfo".
> + *              id: See the description of "struct input_id". This field is
> + *                  copied unchanged into the new device.
> + *            name: This is used unchanged as name for the new device.
> + *  ff_effects_max: This limits the maximum numbers of force-feedback effects.
> + *                  See below for a description of FF with uinput.
> + *         version: This field must be set to the least required UINPUT version.

s/least/minimum/

> + *                  If you do not require a specific version, set this to 0.
> + *                  Note that this ioctl was introduced with UINPUT_VERSION==5,
> + *                  so any version below will be treated as 0.

IMO a client that wants a uinput version below the first that was introduced
should be greeted with an error, patted on the head and shown the door.
I can't think of a way to legitimately pass in 1-4 for the version field
that's not a result of a programming error or memory corruption.

> + *                  Upon ioctl return, the kernel will overwrite this field
> + *                  with the actual UINPUT version of the kernel. You can
> + *                  obviously only rely on this, if the ioctl was successful.

drop the comma

> + *                  Otherwise, writing "version" might have caused the failure.
> + *                  However, the kernel tries to write this field as early as
> + *                  possible. So if it changed, you know that it was written
> + *                  properly.

This is confusing. First you say you can't rely on it, but then I'm
supposed to know it was written properly anyway. And if I request a fixed
version (e.g. 5) I can't know if the -EINVAL overwrote the field or not.
How about just limiting it to success and EOPNOTSUPP:
anything else is off-limits:

On success, the kernel overwrites this field with the UINPUT version
supported by the kernel. If the kernel version is less than the requested
version, the kernel overwrites this field with the UINPUT version supported
by the kernel and the ioctl fails with -EOPNOTSUPP. For any other error,
this field is unmodified."

And then in the actual code you do:

  ver = setup.version;
  if (ver > UINPUT_VERSION) {
        if (put_user())
            -EFAULT
        return -EOPNOTSUPP;
  }

  ... everything else

  if (put_user(version))
       -EFAULT
  udev->state = UIST_SETUP_COMPLETE;
  return 0



> + *                  The kernel always writes a version greater than, or equal
> + *                  to, UINPUT_VERSION==5.

drop the commas

> + *         abs_cnt: This field defines the amount of elements in the following
> + *                  "abs" array. If this field is bigger than the kernel's view
> + *                  of ABS_CNT, the kernel will ignore any values beyond
> + *                  ABS_CNT.

A simple "axes beyond the kernel's ABS_CNT are ignored" is enough, imo.


> + *             abs: This is an appended array that contains parameters for ABS
> + *                  axes. See "struct input_absinfo" for a description of these
> + *                  fields. This array is copied unchanged into the kernel for
> + *                  all specified axes. However, to have effect, you must also
> + *                  enable the wanted axes via UI_SET_ABSBIT.

last sentence: "Only axes previously enabled with UI_SET_ABSBIT are copied."

> + *
> + * This ioctl can be called multiple times and will overwrite previous values.
> + * If this ioctl fails, you're recommended to use the old "uinput_user_dev"

"fails with -EINVAL" ...

> + * method via write() as fallback, in case you run on an old kernel that does
> + * not support this ioctl.
> + *
> + * This ioctl may fail with -EINVAL if it is not supported or if you passed
> + * incorrect values, -ENOMEM if the kernel runs out of memory or -EFAULT if the
> + * passed uinput_setup object cannot be read/written.

-EOPNOTSUPP for version > kernel version

and: doesn't it look like it's time to add a UI_GET_VERSION ioctl? because
with this ioctl you're pushing backwards-compat to the client, so knowing
what the kernel expects would be nice before assembling the data in a format
it may not like. That would also make it a lot easier to figure out if the
new ioctl is supported in the first place.

> + * If this call fails, partial data may have already been applied to the
> + * internal device.

maybe "The state of the internal device is undefined"

Cheers,
   Peter

> + */
> +#define UI_DEV_SETUP _IOWR(UINPUT_IOCTL_BASE, 301, struct uinput_setup)
> +
>  /*
>   * To write a force-feedback-capable driver, the upload_effect
>   * and erase_effect callbacks in input_dev must be implemented.
> @@ -135,7 +209,6 @@ struct uinput_ff_erase {
>  #define UI_FF_UPLOAD		1
>  #define UI_FF_ERASE		2
>  
> -#define UINPUT_MAX_NAME_SIZE	80
>  struct uinput_user_dev {
>  	char name[UINPUT_MAX_NAME_SIZE];
>  	struct input_id id;
> -- 
> 2.0.0
> 
