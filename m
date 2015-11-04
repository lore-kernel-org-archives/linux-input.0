From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH v2] HID: wacom: Call 'wacom_query_tablet_data' only after 'hid_hw_start'
Date: Wed, 4 Nov 2015 09:07:35 -0800
Message-ID: <CAF8JNhJAprBmpnZNWd8eZRxfiL5bgAbViiA10SzeBCeSL3PcMg@mail.gmail.com>
References: <CAF8JNhLjUCmQ30+fQG7_a0xHr6kCG-Kq_-q8T_8T90gs2qLPMw@mail.gmail.com>
 <1446598678-1908-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:35732 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbbKDRHz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Nov 2015 12:07:55 -0500
Received: by obctp1 with SMTP id tp1so44459272obc.2
        for <linux-input@vger.kernel.org>; Wed, 04 Nov 2015 09:07:55 -0800 (PST)
In-Reply-To: <1446598678-1908-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Aaron Skomra <skomra@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Tue, Nov 3, 2015 at 4:57 PM, Jason Gerecke <killertofu@gmail.com> wrote:
> When connecting the Cintiq Companion 2 as an external tablet (i.e., using
> it in "hybrid" mode) it has been seen to cause the kernel of the machine
> it is connected to to Oops. The cause has been traced to us attempting to
> switch the tablet's mode prior to actually starting HID device (resulting
> in the eventual dereference of the uninitialized control URB).
>
> Commit 3b164a0 moved the mode switch from occuring post-start to occurring
> pre-start. The change was not seen to cause issues largely due to the fact
> that most devices mode switch with 'hid_hw_raw_request' (which is safe to
> call prior to start) rather than 'hid_hw_request'.
>
> Moving the call back to its original location resolves the issue, but
> causes some touch-only Bamboo tablets (e.g. 056a:00d0) to stop working.
> The affected tablets require us to perform a mode switch on their
> vestigial pen interface prior ignoring with -ENODEV, meaning that the
> code which is responsible for doing the ignoring has to move as well.

We'll need to clean up the code a bit more. But, that's for future.
This patch is good to go.

> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>

Reviewed-by: Ping Cheng <pingc@wacom.com>

Ping

> ---
> Jiri,
>
> Ping clued me in to the fact that 'wacom_query_tablet_data' hasn't always
> been in this problematic location. The offending commit mentioned in the
> revised commit summary is queued for 4.4, so this only needs to get into
> the next RC rather than be targeted for stable.
>
> Jason
>
>  drivers/hid/wacom_sys.c | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index abb7fdf..e06af5b 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -1778,24 +1778,6 @@ static int wacom_probe(struct hid_device *hdev,
>                 features->device_type |= WACOM_DEVICETYPE_PEN;
>         }
>
> -       /* Note that if query fails it is not a hard failure */
> -       wacom_query_tablet_data(hdev, features);
> -
> -       /* touch only Bamboo doesn't support pen */
> -       if ((features->type == BAMBOO_TOUCH) &&
> -           (features->device_type & WACOM_DEVICETYPE_PEN)) {
> -               error = -ENODEV;
> -               goto fail_shared_data;
> -       }
> -
> -       /* pen only Bamboo neither support touch nor pad */
> -       if ((features->type == BAMBOO_PEN) &&
> -           ((features->device_type & WACOM_DEVICETYPE_TOUCH) ||
> -           (features->device_type & WACOM_DEVICETYPE_PAD))) {
> -               error = -ENODEV;
> -               goto fail_shared_data;
> -       }
> -
>         wacom_calculate_res(features);
>
>         wacom_update_name(wacom);
> @@ -1833,6 +1815,24 @@ static int wacom_probe(struct hid_device *hdev,
>                 goto fail_hw_start;
>         }
>
> +       /* Note that if query fails it is not a hard failure */
> +       wacom_query_tablet_data(hdev, features);
> +
> +       /* touch only Bamboo doesn't support pen */
> +       if ((features->type == BAMBOO_TOUCH) &&
> +           (features->device_type & WACOM_DEVICETYPE_PEN)) {
> +               error = -ENODEV;
> +               goto fail_hw_start;
> +       }
> +
> +       /* pen only Bamboo neither support touch nor pad */
> +       if ((features->type == BAMBOO_PEN) &&
> +           ((features->device_type & WACOM_DEVICETYPE_TOUCH) ||
> +           (features->device_type & WACOM_DEVICETYPE_PAD))) {
> +               error = -ENODEV;
> +               goto fail_hw_start;
> +       }
> +
>         if (features->device_type & WACOM_DEVICETYPE_WL_MONITOR)
>                 error = hid_hw_open(hdev);
>
> --
> 2.6.2
>
