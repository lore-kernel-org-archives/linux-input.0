From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 02/14] HID: provide a helper for validating hid reports
Date: Thu, 29 Aug 2013 11:35:48 +0200
Message-ID: <CAN+gG=H5v=XZ1OOqwiTiOK8fuieMCGRcg_gCks1A5732H4J72Q@mail.gmail.com>
References: <alpine.LNX.2.00.1308282158570.22181@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:40951 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755578Ab3H2Jft (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Aug 2013 05:35:49 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp13so683708pab.21
        for <linux-input@vger.kernel.org>; Thu, 29 Aug 2013 02:35:48 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1308282158570.22181@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>, Kees Cook <keescook@chromium.org>

Hi Kees,

On Wed, Aug 28, 2013 at 10:30 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> From: Kees Cook <keescook@chromium.org>
>
> Many drivers need to validate the characteristics of their HID report
> during initialization to avoid misusing the reports. This adds a common
> helper to perform validation of the report, its field count, and the
> value count within the fields.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Cc: stable@kernel.org
> ---
>  drivers/hid/hid-core.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/hid.h    |    4 ++++
>  2 files changed, 54 insertions(+)
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 5ea7d51..55798b2 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -759,6 +759,56 @@ int hid_parse_report(struct hid_device *hid, __u8 *start, unsigned size)
>  }
>  EXPORT_SYMBOL_GPL(hid_parse_report);
>
> +static const char * const hid_report_names[] = {
> +       "HID_INPUT_REPORT",
> +       "HID_OUTPUT_REPORT",
> +       "HID_FEATURE_REPORT",
> +};
> +/**
> + * hid_validate_report - validate existing device report
> + *
> + * @device: hid device
> + * @type: which report type to examine
> + * @id: which report ID to examine (0 for first)
> + * @fields: expected number of fields
> + * @report_counts: expected number of values per field
> + *
> + * Validate the report details after parsing.
> + */
> +struct hid_report *hid_validate_report(struct hid_device *hid,
> +                                      unsigned int type, unsigned int id,

You should consider having an u8 for id, or at least add a check
against id >= HID_MAX_IDS

> +                                      unsigned int fields,
> +                                      unsigned int report_counts)
> +{
> +       struct hid_report *report;
> +       unsigned int i;
> +
> +       if (type > HID_FEATURE_REPORT) {
> +               hid_err(hid, "invalid HID report %u\n", type);
> +               return NULL;
> +       }
> +
> +       report = hid->report_enum[type].report_id_hash[id];

for code readability, and better checking, I'd prefer use
hid_get_report() here instead. Or just add an inlined accessor in
hid.h to retrieve the report from the id as many drivers are using the
report_id_hash directly.

> +       if (!report) {
> +               hid_err(hid, "missing %s %u\n", hid_report_names[type], id);
> +               return NULL;
> +       }
> +       if (report->maxfield < fields) {
> +               hid_err(hid, "not enough fields in %s %u\n",
> +                       hid_report_names[type], id);
> +               return NULL;
> +       }
> +       for (i = 0; i < fields; i++) {
> +               if (report->field[i]->report_count < report_counts) {

This is wrong.
you can have a per field different report_count, and it is perfectly
correct. So the only validate value for report_counts would be 1.
Otherwise, if you want to provide better checking, you need to provide
an array of report_counts, which start beeing a little bit annoying
for users.

> +                       hid_err(hid, "not enough values in %s %u fields\n",
> +                               hid_report_names[type], id);
> +                       return NULL;
> +               }
> +       }
> +       return report;
> +}
> +EXPORT_SYMBOL_GPL(hid_validate_report);
> +
>  /**
>   * hid_open_report - open a driver-specific device report
>   *
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index ff545cc..76e41d8 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -749,6 +749,10 @@ void hid_output_report(struct hid_report *report, __u8 *data);
>  struct hid_device *hid_allocate_device(void);
>  struct hid_report *hid_register_report(struct hid_device *device, unsigned type, unsigned id);
>  int hid_parse_report(struct hid_device *hid, __u8 *start, unsigned size);
> +struct hid_report *hid_validate_report(struct hid_device *hid,
> +                                      unsigned int type, unsigned int id,
> +                                      unsigned int fields,
> +                                      unsigned int report_counts);
>  int hid_open_report(struct hid_device *device);
>  int hid_check_keys_pressed(struct hid_device *hid);
>  int hid_connect(struct hid_device *hid, unsigned int connect_mask);
>
> --
> Jiri Kosina
> SUSE Labs
> --

Cheers,
Benjamin
