From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 2/3] HID: wacom: Manually declare ABS_{X,Y} for pointer emulation
Date: Tue, 25 Nov 2014 10:34:49 -0500
Message-ID: <CAN+gG=GvZrFiD47hZHfs9v2iso1Vj416K=Ja9F8Z5fy9pzyD6w@mail.gmail.com>
References: <1416871934-14133-1-git-send-email-killertofu@gmail.com>
	<1416871934-14133-3-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:38429 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbaKYPeu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Nov 2014 10:34:50 -0500
Received: by mail-qc0-f170.google.com with SMTP id x3so591786qcv.15
        for <linux-input@vger.kernel.org>; Tue, 25 Nov 2014 07:34:49 -0800 (PST)
In-Reply-To: <1416871934-14133-3-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>

On Mon, Nov 24, 2014 at 6:32 PM, Jason Gerecke <killertofu@gmail.com> wrote:
> If a HID descriptor places HID_DG_CONTACTID before HID_DG_X and HID_DG_Y then
> the ABS_X and ABS_Y will not be automatically initialized by the call to
> input_mt_init_slots. Here we move the setup of those axes outside of the
> 'if' statement so that they're always present if the associated HID field
> is.

No, I am afraid, that this does not work. The solution is to call
input_mt_init_slot once the mapping has been done.
I am complaining here because input_mt_init_slot will set the fuzz to
0 for ABS_X and 4 for ABS_MT_POSITION_X. If both have a fuzz of 4,
there will be a double de-fuzzing while sending out the single touch
emulation.
Likewise, the pressure should be initialized with ABS_MT_PRESSURE only
(not implemented right now, I know).

At the end of wacom_parse_hid in wacom_sys, there should be a call to
a function which would finalize the initialization. And then,
input_mt_init_slot will be called after ABS_MT_*, no matter what the
order of the fields is.

Cheers,
Benjamin

>
> Signed-off-by: Jason Gerecke <killertofu@gmail.com>
> ---
>  drivers/hid/wacom_wac.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 1468f00..a55e0ed 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -1382,16 +1382,14 @@ static void wacom_wac_finger_usage_mapping(struct hid_device *hdev,
>
>         switch (usage->hid) {
>         case HID_GD_X:
> -               if (touch_max == 1)
> -                       wacom_map_usage(wacom, usage, field, EV_ABS, ABS_X, 4);
> -               else
> +               wacom_map_usage(wacom, usage, field, EV_ABS, ABS_X, 4);
> +               if (touch_max > 1)
>                         wacom_map_usage(wacom, usage, field, EV_ABS,
>                                         ABS_MT_POSITION_X, 4);
>                 break;
>         case HID_GD_Y:
> -               if (touch_max == 1)
> -                       wacom_map_usage(wacom, usage, field, EV_ABS, ABS_Y, 4);
> -               else
> +               wacom_map_usage(wacom, usage, field, EV_ABS, ABS_Y, 4);
> +               if (touch_max > 1)
>                         wacom_map_usage(wacom, usage, field, EV_ABS,
>                                         ABS_MT_POSITION_Y, 4);
>                 break;
> --
> 2.1.3
>
