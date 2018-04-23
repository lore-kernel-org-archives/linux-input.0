From: Jason Andryuk <jandryuk@gmail.com>
Subject: Re: [Xen-devel] [PATCH v2] Input: xen-kbdfront - allow better
 run-time configuration
Date: Mon, 23 Apr 2018 14:40:08 -0400
Message-ID: <CAKf6xpuogcR96nq1OLmfk2=7URC_+d8aFZ-cWTWEYPNeQh=oWg@mail.gmail.com>
References: <20180419133934.31306-1-andr2000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180419133934.31306-1-andr2000@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Andrushchenko <andr2000@gmail.com>
Cc: xen-devel@lists.xenproject.org, linux-input@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Juergen Gross <jgross@suse.com>, lyan@suse.com, Boris Ostrovsky <boris.ostrovsky@oracle.com>, andrii_chepurnyi@epam.com, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: linux-input@vger.kernel.org

Hi, Oleksandr.

On Thu, Apr 19, 2018 at 9:39 AM, Oleksandr Andrushchenko
<andr2000@gmail.com> wrote:

<snip>

> @@ -241,60 +242,84 @@ static int xenkbd_probe(struct xenbus_device *dev,
>         }
>
>         /* keyboard */
> -       kbd = input_allocate_device();
> -       if (!kbd)
> -               goto error_nomem;
> -       kbd->name = "Xen Virtual Keyboard";
> -       kbd->phys = info->phys;
> -       kbd->id.bustype = BUS_PCI;
> -       kbd->id.vendor = 0x5853;
> -       kbd->id.product = 0xffff;
> -
> -       __set_bit(EV_KEY, kbd->evbit);
> -       for (i = KEY_ESC; i < KEY_UNKNOWN; i++)
> -               __set_bit(i, kbd->keybit);
> -       for (i = KEY_OK; i < KEY_MAX; i++)
> -               __set_bit(i, kbd->keybit);
> -
> -       ret = input_register_device(kbd);
> -       if (ret) {
> -               input_free_device(kbd);
> -               xenbus_dev_fatal(dev, ret, "input_register_device(kbd)");
> -               goto error;
> +       if (!no_kbd_dev) {

My earlier suggestion on the option name was aimed at replacing the above with:
   if (kbd_dev) {

I find it easier to read then the double negative !no_kbd_dev.  But
it's only used once, so it's not a big deal either way.

<snip>

>
> -       __set_bit(EV_KEY, ptr->evbit);
> -       for (i = BTN_LEFT; i <= BTN_TASK; i++)
> -               __set_bit(i, ptr->keybit);
> +               ptr = input_allocate_device();
> +               if (!ptr)
> +                       goto error_nomem;
> +               ptr->name = "Xen Virtual Pointer";
> +               ptr->phys = info->phys;
> +               ptr->id.bustype = BUS_PCI;
> +               ptr->id.vendor = 0x5853;
> +               ptr->id.product = 0xfffe;
> +
> +               if (abs) {
> +                       __set_bit(EV_ABS, ptr->evbit);
> +                       input_set_abs_params(ptr, ABS_X, 0, ptr_size[KPARAM_X], 0, 0);
> +                       input_set_abs_params(ptr, ABS_Y, 0, ptr_size[KPARAM_Y], 0, 0);

Just noticed these lines now exceed 80 columns.

Otherwise it's just code motion and fine by me.

Regards,
Jason
