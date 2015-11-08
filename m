From: Elias Vanderstuyft <elias.vds@gmail.com>
Subject: Re: [PATCH v3] Input: uinput - add new UINPUT_DEV_SETUP and
 UI_ABS_SETUP ioctl
Date: Sun, 8 Nov 2015 11:55:04 +0100
Message-ID: <CADbOyBTM0dKYik6uHAsA102hwAbhWeXM+QrFba11p+ABoMxi+w@mail.gmail.com>
References: <1440515579-5359-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:34590 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbbKHKzF (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 8 Nov 2015 05:55:05 -0500
In-Reply-To: <1440515579-5359-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Herrmann <dh.herrmann@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi,

On Tue, Aug 25, 2015 at 5:12 PM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
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

Is there a reason to not follow the same field order as in struct
uinput_user_dev?
I.e., why not:

struct uinput_setup {
        char name[UINPUT_MAX_NAME_SIZE];
        struct input_id id;
        __u32 ff_effects_max;
};

In case you would change this, also make sure to change the order in
the documentation of UI_DEV_SETUP.

Cheers,
Elias
