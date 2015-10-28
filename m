From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v3] Input: uinput - add new UINPUT_DEV_SETUP and
 UI_ABS_SETUP ioctl
Date: Wed, 28 Oct 2015 11:10:06 -0400
Message-ID: <20151028151006.GB20468@mail.corp.redhat.com>
References: <1440515579-5359-1-git-send-email-benjamin.tissoires@redhat.com>
 <20151024225341.GA17120@dtor-pixel>
 <CANq1E4TLDMjbfMY-rOM7M8VE_EKejk5DmbPF_BgwNtRwbJV-Aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36473 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752063AbbJ1PKK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Oct 2015 11:10:10 -0400
Content-Disposition: inline
In-Reply-To: <CANq1E4TLDMjbfMY-rOM7M8VE_EKejk5DmbPF_BgwNtRwbJV-Aw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

Hi,

On Oct 25 2015 or thereabouts, David Herrmann wrote:
> Hi
> 
> On Sun, Oct 25, 2015 at 12:53 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > Hi Benjamin,
> >
> > On Tue, Aug 25, 2015 at 11:12:59AM -0400, Benjamin Tissoires wrote:
> >> +static int uinput_abs_setup(struct uinput_device *udev,
> >> +                         struct uinput_setup __user *arg, size_t size)
> >> +{
> >> +     struct uinput_abs_setup setup = {};
> >> +     struct input_dev *dev;
> >> +
> >> +     if (size > sizeof(setup))
> >> +             return -E2BIG;
> >> +     if (udev->state == UIST_CREATED)
> >> +             return -EINVAL;
> >> +     if (copy_from_user(&setup, arg, size))
> >> +             return -EFAULT;
> >> +     if (setup.code > ABS_MAX)
> >> +             return -ERANGE;
> >> +
> >> +     dev = udev->dev;
> >> +
> >> +     input_alloc_absinfo(dev);
> >> +     if (!dev->absinfo)
> >> +             return -ENOMEM;
> >> +
> >> +     set_bit(setup.code, dev->absbit);
> >> +     dev->absinfo[setup.code] = setup.absinfo;
> >> +
> >> +     /*
> >> +      * We restore the state to UIST_NEW_DEVICE because the user has to call
> >> +      * UI_DEV_SETUP in the last place before UI_DEV_CREATE to check the
> >> +      * validity of the absbits.
> >> +      */
> >
> > Do we have to be this strict? It seems to me that with the new IOCTLs
> > you naturally want to use the new ioctl to setup the device, then adjust
> > various axes and bits and then validate everything.
> 
> Indeed, we now force the order to be abs-setup first, then
> device-setup as last step. Appended is a follow-up patch to cleanup
> ABS handling in uinput. It is untested. Benjamin, care to give it a
> spin?
> 

Sorry it took so long for the tests/review.

So the test part is fine. It works as expected. (Tested-by: BT
<benjamin.tissoires@redhat.com>)

For the review part, everything looks good except that now the doc for
UI_ABS_SETUP in uapi/linux/uinput.h should be changed to reflect the
fact that UI_DEV_SETUP is not a pre-requirement before calling
UI_ABS_SETUP.

With the doc change, the patch is also Reviewed-by: me.

Cheers,
Benjamin

> Thanks
> David
> 
> ----
> From 2568f83bcc5c4b8aeb149be2c5fc5a743812f0fe Mon Sep 17 00:00:00 2001
> From: David Herrmann <dh.herrmann@gmail.com>
> Date: Sun, 25 Oct 2015 10:34:13 +0100
> Subject: [PATCH] Input: uinput - rework ABS validation
> 
> Rework the uinput ABS validation to check passed absinfo data
> immediately, but do ABS initialization as last step in UI_DEV_CREATE. The
> behavior observed by user-space is not changed, as ABS initialization was
> never checked for errors.
> 
> With this in place, the order of device-initialization and
> abs-configuration is no longer fixed. User-space can initialize the
> device and afterwards set absinfo just fine.
> 
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> ---
>  drivers/input/misc/uinput.c | 89 +++++++++++++++++++++++----------------------
>  1 file changed, 45 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
> index baac903..1d93037 100644
> --- a/drivers/input/misc/uinput.c
> +++ b/drivers/input/misc/uinput.c
> @@ -256,13 +256,22 @@ static void uinput_destroy_device(...)
>  static int uinput_create_device(struct uinput_device *udev)
>  {
>   struct input_dev *dev = udev->dev;
> - int error;
> + int error, nslot;
> 
>   if (udev->state != UIST_SETUP_COMPLETE) {
>   printk(KERN_DEBUG "%s: write device info first\n", UINPUT_NAME);
>   return -EINVAL;
>   }
> 
> + if (test_bit(ABS_MT_SLOT, dev->absbit)) {
> + nslot = input_abs_get_max(dev, ABS_MT_SLOT) + 1;
> + error = input_mt_init_slots(dev, nslot, 0);
> + if (error)
> + goto fail1;
> + } else if (test_bit(ABS_MT_POSITION_X, dev->absbit)) {
> + input_set_events_per_packet(dev, 60);
> + }
> +
>   if (udev->ff_effects_max) {
>   error = input_ff_create(dev, udev->ff_effects_max);
>   if (error)
> @@ -308,10 +317,35 @@ static int uinput_open(...)
>   return 0;
>  }
> 
> +static int uinput_validate_absinfo(struct input_dev *dev, unsigned int code,
> +   const struct input_absinfo *abs)
> +{
> + int min, max;
> +
> + min = abs->minimum;
> + max = abs->maximum;
> +
> + if ((min != 0 || max != 0) && max <= min) {
> + printk(KERN_DEBUG
> +       "%s: invalid abs[%02x] min:%d max:%d\n",
> +       UINPUT_NAME, code, min, max);
> + return -EINVAL;
> + }
> +
> + if (abs->flat > max - min) {
> + printk(KERN_DEBUG
> +       "%s: abs_flat #%02x out of range: %d (min:%d/max:%d)\n",
> +       UINPUT_NAME, code, abs->flat, min, max);
> + return -EINVAL;
> + }
> +
> + return 0;
> +}
> +
>  static int uinput_validate_absbits(struct input_dev *dev)
>  {
>   unsigned int cnt;
> - int nslot;
> + int error;
> 
>   if (!test_bit(EV_ABS, dev->evbit))
>   return 0;
> @@ -321,38 +355,12 @@ static int uinput_validate_absbits(struct input_dev *dev)
>   */
> 
>   for_each_set_bit(cnt, dev->absbit, ABS_CNT) {
> - int min, max;
> -
> - min = input_abs_get_min(dev, cnt);
> - max = input_abs_get_max(dev, cnt);
> -
> - if ((min != 0 || max != 0) && max <= min) {
> - printk(KERN_DEBUG
> - "%s: invalid abs[%02x] min:%d max:%d\n",
> - UINPUT_NAME, cnt,
> - input_abs_get_min(dev, cnt),
> - input_abs_get_max(dev, cnt));
> + if (!dev->absinfo)
>   return -EINVAL;
> - }
> -
> - if (input_abs_get_flat(dev, cnt) >
> -    input_abs_get_max(dev, cnt) - input_abs_get_min(dev, cnt)) {
> - printk(KERN_DEBUG
> - "%s: abs_flat #%02x out of range: %d "
> - "(min:%d/max:%d)\n",
> - UINPUT_NAME, cnt,
> - input_abs_get_flat(dev, cnt),
> - input_abs_get_min(dev, cnt),
> - input_abs_get_max(dev, cnt));
> - return -EINVAL;
> - }
> - }
> 
> - if (test_bit(ABS_MT_SLOT, dev->absbit)) {
> - nslot = input_abs_get_max(dev, ABS_MT_SLOT) + 1;
> - input_mt_init_slots(dev, nslot, 0);
> - } else if (test_bit(ABS_MT_POSITION_X, dev->absbit)) {
> - input_set_events_per_packet(dev, 60);
> + error = uinput_validate_absinfo(dev, cnt, &dev->absinfo[cnt]);
> + if (error)
> + return error;
>   }
> 
>   return 0;
> @@ -375,7 +383,6 @@ static int uinput_dev_setup(struct uinput_device *udev,
>  {
>   struct uinput_setup setup;
>   struct input_dev *dev;
> - int retval;
> 
>   if (udev->state == UIST_CREATED)
>   return -EINVAL;
> @@ -393,10 +400,6 @@ static int uinput_dev_setup(struct uinput_device *udev,
>   if (!dev->name)
>   return -ENOMEM;
> 
> - retval = uinput_validate_absbits(dev);
> - if (retval < 0)
> - return retval;
> -
>   udev->state = UIST_SETUP_COMPLETE;
>   return 0;
>  }
> @@ -406,6 +409,7 @@ static int uinput_abs_setup(struct uinput_device *udev,
>  {
>   struct uinput_abs_setup setup = {};
>   struct input_dev *dev;
> + int error;
> 
>   if (size > sizeof(setup))
>   return -E2BIG;
> @@ -418,19 +422,16 @@ static int uinput_abs_setup(struct uinput_device *udev,
> 
>   dev = udev->dev;
> 
> + error = uinput_validate_absinfo(dev, setup.code, &setup.absinfo);
> + if (error)
> + return error;
> +
>   input_alloc_absinfo(dev);
>   if (!dev->absinfo)
>   return -ENOMEM;
> 
>   set_bit(setup.code, dev->absbit);
>   dev->absinfo[setup.code] = setup.absinfo;
> -
> - /*
> - * We restore the state to UIST_NEW_DEVICE because the user has to call
> - * UI_DEV_SETUP in the last place before UI_DEV_CREATE to check the
> - * validity of the absbits.
> - */
> - udev->state = UIST_NEW_DEVICE;
>   return 0;
>  }
> 
> -- 
> 2.6.1

> From 2568f83bcc5c4b8aeb149be2c5fc5a743812f0fe Mon Sep 17 00:00:00 2001
> From: David Herrmann <dh.herrmann@gmail.com>
> Date: Sun, 25 Oct 2015 10:34:13 +0100
> Subject: [PATCH] Input: uinput - rework ABS validation
> 
> Rework the uinput ABS validation to check passed absinfo data
> immediately, but do ABS initialization as last step in UI_DEV_CREATE. The
> behavior observed by user-space is not changed, as ABS initialization was
> never checked for errors.
> 
> With this in place, the order of device-initialization and
> abs-configuration is no longer fixed. User-space can initialize the
> device and afterwards set absinfo just fine.
> 
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> ---
>  drivers/input/misc/uinput.c | 89 +++++++++++++++++++++++----------------------
>  1 file changed, 45 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
> index baac903..1d93037 100644
> --- a/drivers/input/misc/uinput.c
> +++ b/drivers/input/misc/uinput.c
> @@ -256,13 +256,22 @@ static void uinput_destroy_device(...)
>  static int uinput_create_device(struct uinput_device *udev)
>  {
>  	struct input_dev *dev = udev->dev;
> -	int error;
> +	int error, nslot;
>  
>  	if (udev->state != UIST_SETUP_COMPLETE) {
>  		printk(KERN_DEBUG "%s: write device info first\n", UINPUT_NAME);
>  		return -EINVAL;
>  	}
>  
> +	if (test_bit(ABS_MT_SLOT, dev->absbit)) {
> +		nslot = input_abs_get_max(dev, ABS_MT_SLOT) + 1;
> +		error = input_mt_init_slots(dev, nslot, 0);
> +		if (error)
> +			goto fail1;
> +	} else if (test_bit(ABS_MT_POSITION_X, dev->absbit)) {
> +		input_set_events_per_packet(dev, 60);
> +	}
> +
>  	if (udev->ff_effects_max) {
>  		error = input_ff_create(dev, udev->ff_effects_max);
>  		if (error)
> @@ -308,10 +317,35 @@ static int uinput_open(...)
>  	return 0;
>  }
>  
> +static int uinput_validate_absinfo(struct input_dev *dev, unsigned int code,
> +				   const struct input_absinfo *abs)
> +{
> +	int min, max;
> +
> +	min = abs->minimum;
> +	max = abs->maximum;
> +
> +	if ((min != 0 || max != 0) && max <= min) {
> +		printk(KERN_DEBUG
> +		       "%s: invalid abs[%02x] min:%d max:%d\n",
> +		       UINPUT_NAME, code, min, max);
> +		return -EINVAL;
> +	}
> +
> +	if (abs->flat > max - min) {
> +		printk(KERN_DEBUG
> +		       "%s: abs_flat #%02x out of range: %d (min:%d/max:%d)\n",
> +		       UINPUT_NAME, code, abs->flat, min, max);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static int uinput_validate_absbits(struct input_dev *dev)
>  {
>  	unsigned int cnt;
> -	int nslot;
> +	int error;
>  
>  	if (!test_bit(EV_ABS, dev->evbit))
>  		return 0;
> @@ -321,38 +355,12 @@ static int uinput_validate_absbits(struct input_dev *dev)
>  	 */
>  
>  	for_each_set_bit(cnt, dev->absbit, ABS_CNT) {
> -		int min, max;
> -
> -		min = input_abs_get_min(dev, cnt);
> -		max = input_abs_get_max(dev, cnt);
> -
> -		if ((min != 0 || max != 0) && max <= min) {
> -			printk(KERN_DEBUG
> -				"%s: invalid abs[%02x] min:%d max:%d\n",
> -				UINPUT_NAME, cnt,
> -				input_abs_get_min(dev, cnt),
> -				input_abs_get_max(dev, cnt));
> +		if (!dev->absinfo)
>  			return -EINVAL;
> -		}
> -
> -		if (input_abs_get_flat(dev, cnt) >
> -		    input_abs_get_max(dev, cnt) - input_abs_get_min(dev, cnt)) {
> -			printk(KERN_DEBUG
> -				"%s: abs_flat #%02x out of range: %d "
> -				"(min:%d/max:%d)\n",
> -				UINPUT_NAME, cnt,
> -				input_abs_get_flat(dev, cnt),
> -				input_abs_get_min(dev, cnt),
> -				input_abs_get_max(dev, cnt));
> -			return -EINVAL;
> -		}
> -	}
>  
> -	if (test_bit(ABS_MT_SLOT, dev->absbit)) {
> -		nslot = input_abs_get_max(dev, ABS_MT_SLOT) + 1;
> -		input_mt_init_slots(dev, nslot, 0);
> -	} else if (test_bit(ABS_MT_POSITION_X, dev->absbit)) {
> -		input_set_events_per_packet(dev, 60);
> +		error = uinput_validate_absinfo(dev, cnt, &dev->absinfo[cnt]);
> +		if (error)
> +			return error;
>  	}
>  
>  	return 0;
> @@ -375,7 +383,6 @@ static int uinput_dev_setup(struct uinput_device *udev,
>  {
>  	struct uinput_setup setup;
>  	struct input_dev *dev;
> -	int retval;
>  
>  	if (udev->state == UIST_CREATED)
>  		return -EINVAL;
> @@ -393,10 +400,6 @@ static int uinput_dev_setup(struct uinput_device *udev,
>  	if (!dev->name)
>  		return -ENOMEM;
>  
> -	retval = uinput_validate_absbits(dev);
> -	if (retval < 0)
> -		return retval;
> -
>  	udev->state = UIST_SETUP_COMPLETE;
>  	return 0;
>  }
> @@ -406,6 +409,7 @@ static int uinput_abs_setup(struct uinput_device *udev,
>  {
>  	struct uinput_abs_setup setup = {};
>  	struct input_dev *dev;
> +	int error;
>  
>  	if (size > sizeof(setup))
>  		return -E2BIG;
> @@ -418,19 +422,16 @@ static int uinput_abs_setup(struct uinput_device *udev,
>  
>  	dev = udev->dev;
>  
> +	error = uinput_validate_absinfo(dev, setup.code, &setup.absinfo);
> +	if (error)
> +		return error;
> +
>  	input_alloc_absinfo(dev);
>  	if (!dev->absinfo)
>  		return -ENOMEM;
>  
>  	set_bit(setup.code, dev->absbit);
>  	dev->absinfo[setup.code] = setup.absinfo;
> -
> -	/*
> -	 * We restore the state to UIST_NEW_DEVICE because the user has to call
> -	 * UI_DEV_SETUP in the last place before UI_DEV_CREATE to check the
> -	 * validity of the absbits.
> -	 */
> -	udev->state = UIST_NEW_DEVICE;
>  	return 0;
>  }
>  
> -- 
> 2.6.1
> 

