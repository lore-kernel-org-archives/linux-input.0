From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH] HID: wacom: do not directly use input_mt_report_pointer_emulation
Date: Tue, 17 Feb 2015 14:36:11 -0800
Message-ID: <CAF8JNhKwMpLEnBYSAA4-sT_qNLQN7ymKpiYxb6a5m6VTbE_1cQ@mail.gmail.com>
References: <1424200786-4009-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f170.google.com ([209.85.220.170]:43794 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754772AbbBQWgM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Feb 2015 17:36:12 -0500
In-Reply-To: <1424200786-4009-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Jason Gerecke <killertofu@gmail.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Feb 17, 2015 at 11:19 AM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> input_mt_sync_frame() calls input_mt_report_pointer_emulation() and do
> some internal steps required to keep in sync the state of the touch within
> the various reports.
>
> Given that we use input_mt_assign_slot() in this driver, it is better to
> use input_mt_sync_frame().

It is sensible to me, except I think you meant input_mt_slot() instead
of input_mt_assign_slot().

> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Reviewed-by: Ping Cheng <pingc@wacom.com>

Ping

> ---
>  drivers/hid/wacom_wac.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 8627581..de93968 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -1093,7 +1093,7 @@ static int wacom_24hdt_irq(struct wacom_wac *wacom)
>                         }
>                 }
>         }
> -       input_mt_report_pointer_emulation(input, true);
> +       input_mt_sync_frame(input);
>
>         wacom->num_contacts_left -= contacts_to_send;
>         if (wacom->num_contacts_left <= 0)
> @@ -1144,7 +1144,7 @@ static int wacom_mt_touch(struct wacom_wac *wacom)
>                         input_report_abs(input, ABS_MT_POSITION_Y, y);
>                 }
>         }
> -       input_mt_report_pointer_emulation(input, true);
> +       input_mt_sync_frame(input);
>
>         wacom->num_contacts_left -= contacts_to_send;
>         if (wacom->num_contacts_left < 0)
> @@ -1176,7 +1176,7 @@ static int wacom_tpc_mt_touch(struct wacom_wac *wacom)
>                         contact_with_no_pen_down_count++;
>                 }
>         }
> -       input_mt_report_pointer_emulation(input, true);
> +       input_mt_sync_frame(input);
>
>         /* keep touch state for pen event */
>         wacom->shared->touch_down = (contact_with_no_pen_down_count > 0);
> @@ -1638,7 +1638,7 @@ static int wacom_bpt_touch(struct wacom_wac *wacom)
>                 }
>         }
>
> -       input_mt_report_pointer_emulation(input, true);
> +       input_mt_sync_frame(input);
>
>         input_report_key(pad_input, BTN_LEFT, (data[1] & 0x08) != 0);
>         input_report_key(pad_input, BTN_FORWARD, (data[1] & 0x04) != 0);
> @@ -1728,7 +1728,7 @@ static int wacom_bpt3_touch(struct wacom_wac *wacom)
>                         wacom_bpt3_button_msg(wacom, data + offset);
>
>         }
> -       input_mt_report_pointer_emulation(input, true);
> +       input_mt_sync_frame(input);
>
>         return 1;
>  }
> --
> 2.1.0
>
