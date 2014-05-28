From: Reyad Attiyat <reyad.attiyat@gmail.com>
Subject: Re: [PATCH 3/3] IO: hid-sensor-magn-3d: Add in support for
 True/Magnetic North HID usages
Date: Wed, 28 May 2014 16:15:16 -0500
Message-ID: <CA+BWVUQEsprV1jEzD9D0hidR0jvYeSRVGT=ESzstR4apa+nV1A@mail.gmail.com>
References: <1401311175-12784-1-git-send-email-reyad.attiyat@gmail.com> <1401311175-12784-4-git-send-email-reyad.attiyat@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1401311175-12784-4-git-send-email-reyad.attiyat@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, jic23@kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>
Cc: Reyad Attiyat <reyad.attiyat@gmail.com>
List-Id: linux-input@vger.kernel.org

> +static void sensor_hub_fill_attr_info(
> +               struct hid_sensor_hub_attribute_info *info,
> +               s32 index, s32 report_id, struct hid_field *field)
> +{
> +       info->index = index;
> +       info->report_id = report_id;
> +       info->units = field->unit;
> +       info->unit_expo = field->unit_exponent;
> +       info->size = (field->report_size * field->report_count)/8;
> +       info->logical_minimum = field->logical_minimum;
> +       info->logical_maximum = field->logical_maximum;
>  }

I copied this function from hid/hid-sensor-hub.c as it is marked
static in that file. I use it to fill attributes as I find them.
Should I create an another patch to make it non-static?

> +       list_for_each_entry(report, &report_enum->report_list, list) {
> +               for (i = 0; i < report->maxfield; ++i) {
> +                       field = report->field[i];
> +
> +                       for (j = 0; j < field->maxusage; j++) {
> +                               usage = &(field->usage[j]);
> +

This is how I mange to find all possible hid reports in the parse
reports function. I noticed that in the other function that was used,
sensor_hub_input_get_attribute_info(),  it only uses field->usage[0].
Is there a reason for this and should I change my current
implementation?
