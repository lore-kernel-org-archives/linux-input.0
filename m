From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH] HID: wacom: check for wacom->shared before following the pointer
Date: Thu, 5 Mar 2015 17:54:50 -0800
Message-ID: <CAF8JNhJ5BmgRYN+gnmT4FBDrWDAaqiUvPnmUxWYQiP2F5qyy5Q@mail.gmail.com>
References: <1425594995-22958-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425594995-22958-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Jason Gerecke <killertofu@gmail.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Mar 5, 2015 at 2:36 PM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> 486b908 (HID: wacom: do not send pen events before touch is up/forced out)
> introduces a kernel oops when plugging a tablet without touch.

Thank you for the catch. You must have tried an Intuos 4 or earlier
model. WACOM_QUIRK_MULTI_INPUT is only set for I5 and later.

> wacom->shared is null for these devices so this leads to a null pointer
> exception.

The root cause is "if (wacom->shared->touch_down)" was added outside
of "if (features->quirks & WACOM_QUIRK_MULTI_INPUT)". A consistent fix
would be:
----
@@ -555,8 +555,11 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
           (features->type == CINTIQ && !(data[1] & 0x40)))
                return 1;

-       if (features->quirks & WACOM_QUIRK_MULTI_INPUT)
+       if (features->quirks & WACOM_QUIRK_MULTI_INPUT) {
                wacom->shared->stylus_in_proximity = true;
+               if (wacom->shared->touch_down)
+                       return 1;
+       }

        /* in Range while exiting */
        if (((data[1] & 0xfe) == 0x20) && wacom->reporting_data) {
----

Cheers,

Ping

> Change the condition to make it clear that what we need is wacom->shared
> not NULL.
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>
> Hi Jiri,
>
> this one should be pulled in 4.0. Or we will have surprised users :)
>
> Cheers,
> Benjamin
>
>  drivers/hid/wacom_wac.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index ff9a7ab..9739a4c 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -564,11 +564,12 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
>            (features->type == CINTIQ && !(data[1] & 0x40)))
>                 return 1;
>
> -       if (features->quirks & WACOM_QUIRK_MULTI_INPUT)
> +       if (wacom->shared) {
>                 wacom->shared->stylus_in_proximity = true;
>
> -       if (wacom->shared->touch_down)
> -               return 1;
> +               if (wacom->shared->touch_down)
> +                       return 1;
> +       }
>
>         /* in Range while exiting */
>         if (((data[1] & 0xfe) == 0x20) && wacom->reporting_data) {
> --
> 2.1.0
>
