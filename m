From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [RFC PATCH] input: Add disable sysfs entry for every input device
Date: Mon, 2 Jan 2017 17:44:38 +0100
Message-ID: <CANq1E4TLWyp+rZaE_S533Y3FxyMM8gPwV2SL06+ADuK96hBnOw@mail.gmail.com>
References: <1482660296-8432-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:36303 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933647AbdABQok (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 2 Jan 2017 11:44:40 -0500
In-Reply-To: <1482660296-8432-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Chuck Ebbert <cebbert.lkml@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

Hi

On Sun, Dec 25, 2016 at 11:04 AM, Pali Roh=C3=A1r <pali.rohar@gmail.com> wr=
ote:
> This patch allows user to disable events from any input device so events
> would not be delivered to userspace.
>
> Currently there is no way to disable particular input device by kernel.
> User for different reasons would need it for integrated PS/2 keyboard or
> touchpad in notebook or touchscreen on mobile device to prevent sending
> events. E.g. mobile phone in pocket or broken integrated PS/2 keyboard.
>
> This is just a RFC patch, not tested yet. Original post about motivation
> about this patch is there: https://lkml.org/lkml/2014/11/29/92
>
> Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> ---
>  drivers/input/input.c |   35 +++++++++++++++++++++++++++++++++++
>  include/linux/input.h |    4 ++++
>  2 files changed, 39 insertions(+)

Don't open the device, if you don't want events from it. Really.

I assume the reason behind this is that you don't know how to make
your user-space ignore devices. But with this patch in place, you now
end up with user-space trying to use the device, but not getting any
events. Anyone trying to debug this will go nuts because the setup
looks like the device is used, but ends up being muted.

I strongly recommend improving your user-space code to do what you
want it to do (meaning, make your user-space be configurable, if you
need this).

Btw., as a workaround, you can always disable input-drivers that you
don't want. Or you can run EVIOCGRAB on a device to get the same
effect as your patch.

Thanks
David

> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index d95c34e..9f0da7e 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -430,6 +430,9 @@ void input_event(struct input_dev *dev,
>  {
>         unsigned long flags;
>
> +       if (unlikely(dev->disabled))
> +               return;
> +
>         if (is_event_supported(type, dev->evbit, EV_MAX)) {
>
>                 spin_lock_irqsave(&dev->event_lock, flags);
> @@ -457,6 +460,9 @@ void input_inject_event(struct input_handle *handle,
>         struct input_handle *grab;
>         unsigned long flags;
>
> +       if (unlikely(dev->disabled))
> +               return;
> +
>         if (is_event_supported(type, dev->evbit, EV_MAX)) {
>                 spin_lock_irqsave(&dev->event_lock, flags);
>
> @@ -1389,12 +1395,41 @@ static ssize_t input_dev_show_properties(struct d=
evice *dev,
>  }
>  static DEVICE_ATTR(properties, S_IRUGO, input_dev_show_properties, NULL)=
;
>
> +static ssize_t input_dev_show_disable(struct device *dev,
> +                                     struct device_attribute *attr,
> +                                     char *buf)
> +{
> +       struct input_dev *input_dev =3D to_input_dev(dev);
> +
> +       return snprintf(buf, PAGE_SIZE, "%d\n", input_dev->disabled ? 1 :=
 0);
> +}
> +static ssize_t input_dev_store_disable(struct device *dev,
> +                                      struct device_attribute *attr,
> +                                      const char *buf, size_t count)
> +{
> +       struct input_dev *input_dev =3D to_input_dev(dev);
> +       int disable;
> +       int ret;
> +
> +       ret =3D kstrtoint(buf, 0, &disable);
> +       if (ret)
> +               return ret;
> +
> +       if (disable !=3D 0 && disable !=3D 1)
> +               return -EINVAL;
> +
> +       input_dev->disabled =3D disable;
> +       return count;
> +}
> +static DEVICE_ATTR(disable, S_IRUGO | S_IWUSR, input_dev_show_disable, i=
nput_dev_store_disable);
> +
>  static struct attribute *input_dev_attrs[] =3D {
>         &dev_attr_name.attr,
>         &dev_attr_phys.attr,
>         &dev_attr_uniq.attr,
>         &dev_attr_modalias.attr,
>         &dev_attr_properties.attr,
> +       &dev_arrr_disable.attr,
>         NULL
>  };
>
> diff --git a/include/linux/input.h b/include/linux/input.h
> index a65e3b2..e390b56 100644
> --- a/include/linux/input.h
> +++ b/include/linux/input.h
> @@ -117,6 +117,8 @@ struct input_value {
>   * @vals: array of values queued in the current frame
>   * @devres_managed: indicates that devices is managed with devres framew=
ork
>   *     and needs not be explicitly unregistered or freed.
> + * @disabled: indicates that device is in disabled state and kernel drop
> + *     all events from it
>   */
>  struct input_dev {
>         const char *name;
> @@ -187,6 +189,8 @@ struct input_dev {
>         struct input_value *vals;
>
>         bool devres_managed;
> +
> +       bool disabled;
>  };
>  #define to_input_dev(d) container_of(d, struct input_dev, dev)
>
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
