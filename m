From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] Input: evdev - add ioctl cmd EVIOCGBUFSIZE to get buffer size
Date: Fri, 8 Jan 2016 16:29:48 +0100
Message-ID: <CANq1E4T0UVLijsFivcANtMjknn6bkq7W5nned_hAvRQD=K94Nw@mail.gmail.com>
References: <1452266588-3139-1-git-send-email-a.mathur@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37520 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbcAHP3u (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Jan 2016 10:29:50 -0500
In-Reply-To: <1452266588-3139-1-git-send-email-a.mathur@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aniroop Mathur <a.mathur@samsung.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, aniroop.mathur@gmail.com

Hi

On Fri, Jan 8, 2016 at 4:23 PM, Aniroop Mathur <a.mathur@samsung.com> wrote:
> Add ioctl cmd EVIOCGBUFSIZE to get kernel buffer size of device so that
> clients can accordingly set the size of userspace buffer and can know
> maximum number of events that they are required to read in worst case.

Why is that needed? What's wrong with resizing your buffers in
user-space? Exposing this information limits the kernel to never allow
dynamically sized buffers.

Furthermore, in user-space you don't have to pre-allocate your
buffers. It'd be enough to reserve the address space for it.

Could you elaborate on your use-case?

> Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
> ---
>  drivers/input/evdev.c      |    3 +++
>  include/uapi/linux/input.h |    2 ++
>  2 files changed, 5 insertions(+)
>
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index e9ae3d5..8b16f08 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -1103,6 +1103,9 @@ static long evdev_do_ioctl(struct file *file, unsigned int cmd,
>
>                 return 0;
>
> +       case EVIOCGBUFSIZE:
> +               return put_user(client->bufsize, (unsigned int __user *)p);
> +
>         case EVIOCRMFF:
>                 return input_ff_erase(dev, (int)(unsigned long) p, file);
>
> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
> index 2758687..51d66aa 100644
> --- a/include/uapi/linux/input.h
> +++ b/include/uapi/linux/input.h
> @@ -114,6 +114,8 @@ struct input_mask {
>  #define EVIOCSKEYCODE          _IOW('E', 0x04, unsigned int[2])        /* set keycode */
>  #define EVIOCSKEYCODE_V2       _IOW('E', 0x04, struct input_keymap_entry)
>
> +#define EVIOCGBUFSIZE          _IOR('E', 0x05, unsigned int)           /* get device buffer size */

Please document all new ioctls. See EVIOCSMASK for an example.

Thanks
David

> +
>  #define EVIOCGNAME(len)                _IOC(_IOC_READ, 'E', 0x06, len)         /* get device name */
>  #define EVIOCGPHYS(len)                _IOC(_IOC_READ, 'E', 0x07, len)         /* get physical location */
>  #define EVIOCGUNIQ(len)                _IOC(_IOC_READ, 'E', 0x08, len)         /* get unique identifier */
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
