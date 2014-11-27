From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCHv3 1/1] HID: add BETOP game controller force feedback
 support
Date: Thu, 27 Nov 2014 10:05:09 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1411271004260.23174@pobox.suse.cz>
References: <54768284.4060201@163.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54768284.4060201@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Huang Bo <huangbobupt@163.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 27 Nov 2014, Huang Bo wrote:

> From: Huang Bo <huangbobupt@163.com>
> 
> Adds force feedback support for BETOP USB game controllers.
> These devices are mass produced in China.

Thanks. We are almost there, except ...

[ ... snip ... ]
> +static int betopff_init(struct hid_device *hid)
> +{
> +    struct betopff_device *betopff;
> +    struct hid_report *report;
> +    struct hid_input *hidinput =
> +            list_first_entry(&hid->inputs, struct hid_input, list);
> +    struct list_head *report_list =
> +            &hid->report_enum[HID_OUTPUT_REPORT].report_list;
> +    struct input_dev *dev = hidinput->input;
> +    int field_count = 0;
> +    int error;
> +    int i, j;
> +
> +    if (list_empty(report_list)) {
> +        hid_err(hid, "no output reports found\n");
> +        return -ENODEV;
> +    }
> +
> +    report = list_first_entry(report_list, struct hid_report, list);
> +    for (i = 0; i < report->maxfield; i++) {
> +        for (j = 0; j < report->field[i]->report_count; j++) {
> +            report->field[i]->value[j] = 0x00;

I asked for a comment to be added here why you are zeroing those out.

Thanks,

-- 
Jiri Kosina
SUSE Labs
