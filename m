From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH v2] HID: wacom: Update last_slot_field during pre_report phase
Date: Thu, 21 Jul 2016 11:01:22 -0700
Message-ID: <CAF8JNhJaBRnsCB60UEGW_6k1ecHMK0x5jyhqydtm+GDi3PiraQ@mail.gmail.com>
References: <f20b53ac-1bde-7005-2874-74bdd6d6aa96@gmail.com> <20160721161046.25608-1-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:36178 "EHLO
	mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979AbcGUSBm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Jul 2016 14:01:42 -0400
Received: by mail-it0-f67.google.com with SMTP id j124so1634123ith.3
        for <linux-input@vger.kernel.org>; Thu, 21 Jul 2016 11:01:42 -0700 (PDT)
In-Reply-To: <20160721161046.25608-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Aaron Skomra <skomra@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Thu, Jul 21, 2016 at 9:10 AM, Jason Gerecke <killertofu@gmail.com> wrote:
> If a touchscreen contains both multitouch and single-touch reports in its
> descriptor in that order, the driver may overwrite information it saved
> about the format of the multitouch report. This can cause the report
> processing code to get tripped up and send an incorrect event stream to
> userspace.
>
> In particular, this can cause last_slot_field to be overwritten with the
> result that the driver prematurely assumes it has finished processing a
> slot and sending the ABS_MT_SLOT event at the wrong point in time,
> associating events for the current contact with the following contact
> instead.
>
> To prevent this from occurring, we update the value of last_slot_field
> durring the pre_report phase to ensure that it is correct for the report
> that is to be processed.

Nice job, Jason! I like this approach. The patch is:

Reviewed-by: Ping Cheng <pingc@wacom.com>

Cheers,

Ping

> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> ---
> Changes from v1:
>  * The v1 patch cut off processing by wacom_wac_finger_usage_mapping once
>    it saw a HID_DG_CONTACTCOUNT usage in any report. This method of
>    handling the bug has two potential problems: 1) reports which place
>    the HID_DG_CONTACTCOUNT usage near the beginning of the packet will
>    not properly map the rest of the usages, and 2) devices which have
>    multiple reports with the HID_DG_CONTACTCOUNT usage will only send
>    reports formatted like the first discovered. Neither of these should
>    cause issues for currently available hardware, but to maximize forward
>    compatibility, the revised scheme contained here was devised.
>
>  drivers/hid/wacom_wac.c | 62 +++++++++++++++++++++----------------------------
>  drivers/hid/wacom_wac.h |  2 +-
>  2 files changed, 27 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index fcf2264..d2611f3 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -1556,13 +1556,11 @@ static void wacom_wac_finger_usage_mapping(struct hid_device *hdev,
>  {
>         struct wacom *wacom = hid_get_drvdata(hdev);
>         struct wacom_wac *wacom_wac = &wacom->wacom_wac;
> -       struct wacom_features *features = &wacom_wac->features;
>         struct input_dev *input = wacom_wac->touch_input;
>         unsigned touch_max = wacom_wac->features.touch_max;
>
>         switch (usage->hid) {
>         case HID_GD_X:
> -               features->last_slot_field = usage->hid;
>                 if (touch_max == 1)
>                         wacom_map_usage(input, usage, field, EV_ABS, ABS_X, 4);
>                 else
> @@ -1570,7 +1568,6 @@ static void wacom_wac_finger_usage_mapping(struct hid_device *hdev,
>                                         ABS_MT_POSITION_X, 4);
>                 break;
>         case HID_GD_Y:
> -               features->last_slot_field = usage->hid;
>                 if (touch_max == 1)
>                         wacom_map_usage(input, usage, field, EV_ABS, ABS_Y, 4);
>                 else
> @@ -1579,22 +1576,11 @@ static void wacom_wac_finger_usage_mapping(struct hid_device *hdev,
>                 break;
>         case HID_DG_WIDTH:
>         case HID_DG_HEIGHT:
> -               features->last_slot_field = usage->hid;
>                 wacom_map_usage(input, usage, field, EV_ABS, ABS_MT_TOUCH_MAJOR, 0);
>                 wacom_map_usage(input, usage, field, EV_ABS, ABS_MT_TOUCH_MINOR, 0);
>                 input_set_abs_params(input, ABS_MT_ORIENTATION, 0, 1, 0, 0);
>                 break;
> -       case HID_DG_CONTACTID:
> -               features->last_slot_field = usage->hid;
> -               break;
> -       case HID_DG_INRANGE:
> -               features->last_slot_field = usage->hid;
> -               break;
> -       case HID_DG_INVERT:
> -               features->last_slot_field = usage->hid;
> -               break;
>         case HID_DG_TIPSWITCH:
> -               features->last_slot_field = usage->hid;
>                 wacom_map_usage(input, usage, field, EV_KEY, BTN_TOUCH, 0);
>                 break;
>         case HID_DG_CONTACTCOUNT:
> @@ -1672,7 +1658,7 @@ static int wacom_wac_finger_event(struct hid_device *hdev,
>
>
>         if (usage->usage_index + 1 == field->report_count) {
> -               if (usage->hid == wacom_wac->features.last_slot_field)
> +               if (usage->hid == wacom_wac->hid_data.last_slot_field)
>                         wacom_wac_finger_slot(wacom_wac, wacom_wac->touch_input);
>         }
>
> @@ -1685,31 +1671,35 @@ static void wacom_wac_finger_pre_report(struct hid_device *hdev,
>         struct wacom *wacom = hid_get_drvdata(hdev);
>         struct wacom_wac *wacom_wac = &wacom->wacom_wac;
>         struct hid_data* hid_data = &wacom_wac->hid_data;
> +       int i;
>
> -       if (hid_data->cc_report != 0 &&
> -           hid_data->cc_report != report->id) {
> -               int i;
> -
> -               hid_data->cc_report = report->id;
> -               hid_data->cc_index = -1;
> -               hid_data->cc_value_index = -1;
> -
> -               for (i = 0; i < report->maxfield; i++) {
> -                       struct hid_field *field = report->field[i];
> -                       int j;
> -
> -                       for (j = 0; j < field->maxusage; j++) {
> -                               if (field->usage[j].hid == HID_DG_CONTACTCOUNT) {
> -                                       hid_data->cc_index = i;
> -                                       hid_data->cc_value_index = j;
> -
> -                                       /* break */
> -                                       i = report->maxfield;
> -                                       j = field->maxusage;
> -                               }
> +       for (i = 0; i < report->maxfield; i++) {
> +               struct hid_field *field = report->field[i];
> +               int j;
> +
> +               for (j = 0; j < field->maxusage; j++) {
> +                       struct hid_usage *usage = &field->usage[j];
> +
> +                       switch (usage->hid) {
> +                       case HID_GD_X:
> +                       case HID_GD_Y:
> +                       case HID_DG_WIDTH:
> +                       case HID_DG_HEIGHT:
> +                       case HID_DG_CONTACTID:
> +                       case HID_DG_INRANGE:
> +                       case HID_DG_INVERT:
> +                       case HID_DG_TIPSWITCH:
> +                               hid_data->last_slot_field = usage->hid;
> +                               break;
> +                       case HID_DG_CONTACTCOUNT:
> +                               hid_data->cc_report = report->id;
> +                               hid_data->cc_index = i;
> +                               hid_data->cc_value_index = j;
> +                               break;
>                         }
>                 }
>         }
> +
>         if (hid_data->cc_report != 0 &&
>             hid_data->cc_index >= 0) {
>                 struct hid_field *field = report->field[hid_data->cc_index];
> diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
> index 8a8974c..267025c 100644
> --- a/drivers/hid/wacom_wac.h
> +++ b/drivers/hid/wacom_wac.h
> @@ -185,7 +185,6 @@ struct wacom_features {
>         int pktlen;
>         bool check_for_hid_type;
>         int hid_type;
> -       int last_slot_field;
>  };
>
>  struct wacom_shared {
> @@ -214,6 +213,7 @@ struct hid_data {
>         int cc_report;
>         int cc_index;
>         int cc_value_index;
> +       int last_slot_field;
>         int num_expected;
>         int num_received;
>  };
> --
> 2.9.0
>
