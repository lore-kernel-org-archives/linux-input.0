From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] hyper-v: Fix wakeup from suspend-to-idle
Date: Thu, 13 Sep 2018 08:55:22 +0200
Message-ID: <CAJZ5v0jmNFaH3JUVS9W_1ofXcD=8U8Y9enPi+j+9U=6cBVxfJQ@mail.gmail.com>
References: <20180912161101.2634-1-vkuznets@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180912161101.2634-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com, Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, Sep 12, 2018 at 6:11 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> It makes little sense but still possible to put Hyper-V guests into
> suspend-to-idle state. To wake them up two wakeup sources were registered
> in the past: hyperv-keyboard and hid-hyperv. However, since
> commit eed4d47efe95 ("ACPI / sleep: Ignore spurious SCI wakeups from
> suspend-to-idle") pm_wakeup_event() from these devices is ignored. Switch
> to pm_wakeup_hard_event() API as these devices are actually the only
> possible way to wakeup Hyper-V guests.
>
> Fixes: eed4d47efe95 (ACPI / sleep: Ignore spurious SCI wakeups from suspend-to-idle)
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/hid/hid-hyperv.c              | 2 +-
>  drivers/input/serio/hyperv-keyboard.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
> index b372854cf38d..704049e62d58 100644
> --- a/drivers/hid/hid-hyperv.c
> +++ b/drivers/hid/hid-hyperv.c
> @@ -309,7 +309,7 @@ static void mousevsc_on_receive(struct hv_device *device,
>                 hid_input_report(input_dev->hid_device, HID_INPUT_REPORT,
>                                  input_dev->input_buf, len, 1);
>
> -               pm_wakeup_event(&input_dev->device->device, 0);
> +               pm_wakeup_hard_event(&input_dev->device->device);
>
>                 break;
>         default:
> diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/hyperv-keyboard.c
> index 47a0e81a2989..a8b9be3e28db 100644
> --- a/drivers/input/serio/hyperv-keyboard.c
> +++ b/drivers/input/serio/hyperv-keyboard.c
> @@ -177,7 +177,7 @@ static void hv_kbd_on_receive(struct hv_device *hv_dev,
>                  * state because the Enter-UP can trigger a wakeup at once.
>                  */
>                 if (!(info & IS_BREAK))
> -                       pm_wakeup_event(&hv_dev->device, 0);
> +                       pm_wakeup_hard_event(&hv_dev->device);
>
>                 break;
>
> --
> 2.14.4
>
