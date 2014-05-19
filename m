From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] HID: core: fix validation of report id 0
Date: Mon, 19 May 2014 12:01:01 -0700
Message-ID: <CAGXu5jJLKQiC4zwYJ9dpVvELoYBKZ4OFsqKdQXQW9OyDwsdvmg@mail.gmail.com>
References: <20140417202209.GA30268@www.outflux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140417202209.GA30268@www.outflux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, linux-input <linux-input@vger.kernel.org>, Roland Bosa <rbosa@logitech.com>
List-Id: linux-input@vger.kernel.org

Pinging on this patch... I don't see it in -next yet. I've had more
reports of trouble with logitech devices, and this seems to solve the
problem.

-Kees

On Thu, Apr 17, 2014 at 1:22 PM, Kees Cook <keescook@chromium.org> wrote:
> Some drivers use the first HID report in the list instead of using an
> index. In these cases, validation uses ID 0, which was supposed to mean
> "first known report". This fixes the problem, which was causing at least
> the lgff family of devices to stop working since hid_validate_values
> was being called with ID 0, but the devices used single numbered IDs
> for their reports:
>
> 0x05, 0x01,         /*  Usage Page (Desktop),                   */
> 0x09, 0x05,         /*  Usage (Gamepad),                        */
> 0xA1, 0x01,         /*  Collection (Application),               */
> 0xA1, 0x02,         /*      Collection (Logical),               */
> 0x85, 0x01,         /*          Report ID (1),                  */
> ...
>
> Reported-by: Simon Wood <simon@mungewell.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Cc: stable@vger.kernel.org
> ---
>  drivers/hid/hid-core.c |   12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 9e8064205bc7..07ce28175168 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -839,7 +839,17 @@ struct hid_report *hid_validate_values(struct hid_device *hid,
>          * ->numbered being checked, which may not always be the case when
>          * drivers go to access report values.
>          */
> -       report = hid->report_enum[type].report_id_hash[id];
> +       if (id == 0) {
> +               /*
> +                * Validating on id 0 means we should examine the first
> +                * report in the list.
> +                */
> +               report = list_entry(
> +                               hid->report_enum[type].report_list.next,
> +                               struct hid_report, list);
> +       } else {
> +               report = hid->report_enum[type].report_id_hash[id];
> +       }
>         if (!report) {
>                 hid_err(hid, "missing %s %u\n", hid_report_names[type], id);
>                 return NULL;
> --
> 1.7.9.5
>
>
> --
> Kees Cook
> Chrome OS Security



-- 
Kees Cook
Chrome OS Security
