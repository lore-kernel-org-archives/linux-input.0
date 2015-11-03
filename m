From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 1/3] HID: wacom: Call 'wacom_query_tablet_data' only after 'hid_hw_start'
Date: Mon, 2 Nov 2015 17:36:49 -0800
Message-ID: <CAF8JNhLjUCmQ30+fQG7_a0xHr6kCG-Kq_-q8T_8T90gs2qLPMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:35615 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754511AbbKCBhK (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Nov 2015 20:37:10 -0500
Received: by obctp1 with SMTP id tp1so1709476obc.2
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2015 17:37:09 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>

On Mon, Nov 2, 2015 at 3:41 PM, Jason Gerecke <killertofu@gmail.com> wrote:
>
> When connecting the Cintiq Companion 2 as an external tablet (i.e., using
> it in "hybrid" mode) it has been seen to cause the kernel of the machine
> it is connected to to Oops. The cause has been traced to us attempting to
> switch the tablet's mode prior to actually starting HID device (resulting
> in the eventual dereference of the uninitialized control URB).
>
> This has not been an issue in the past since we've historically used
> 'hid_hw_raw_request' to perform the mode switch. HID_GENERIC devices,
> however use 'hid_hw_request' which assumes that 'hid_hw_start' has already
> been called. That we've not encountered problems beforehand seems to
> be entirely due to luck.
>
> Since the timing of the mode switch is not critical, we can simply

The timing of the mode switch makes a difference for Bamboo touch only
devices. Without switching mode for pen interface before it is
ignored, we will not receive touch data later.

All other devices should be fine with your moved mode switch code.

> move it to occur after the call to 'hid_hw_start'. Alternately, we
> could have potentially modified 'wacom_hid_set_device_mode' to use
> 'hid_hw_raw_reqest'.
>
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>

Nacked-by: Ping Cheng <pingc@wacom.com>

Ping


> ---
> Jiri,
>
> Please mark this for stable since it possible other HID_GENERIC
> devices may trigger this Oops as well.
>
> Thanks,
> Jason
>
>  drivers/hid/wacom_sys.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index b4de325..45656e8 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -1778,9 +1778,6 @@ static int wacom_probe(struct hid_device *hdev,
>                 features->device_type |= WACOM_DEVICETYPE_PEN;
>         }
>
> -       /* Note that if query fails it is not a hard failure */
> -       wacom_query_tablet_data(hdev, features);
> -
>         /* touch only Bamboo doesn't support pen */
>         if ((features->type == BAMBOO_TOUCH) &&
>             (features->device_type & WACOM_DEVICETYPE_PEN)) {
> @@ -1833,6 +1830,9 @@ static int wacom_probe(struct hid_device *hdev,
>                 goto fail_hw_start;
>         }
>
> +       /* Note that if query fails it is not a hard failure */
> +       wacom_query_tablet_data(hdev, features);
> +
>         if (features->device_type & WACOM_DEVICETYPE_WL_MONITOR)
>                 error = hid_hw_open(hdev);
>
> --
> 2.6.2
>
