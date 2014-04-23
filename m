From: simon@mungewell.org
Subject: Re: HID: hid-logitech - missing HID_OUTPUT_REPORT 0
Date: Wed, 23 Apr 2014 10:50:01 -0400
Message-ID: <918734d612baaa87fcc577d5bdb8806b.squirrel@mungewell.org>
References: <6452400bfacafd7e1f0d0f7a98b06248.squirrel@mungewell.org>
    <CAGXu5jKTcV9m70tgsxrBhUXWp5eXdXRJkCdYJDhpdOtB16b=6w@mail.gmail.com>
    <796aa99e55f8812aa6422d35610d4ed3.squirrel@mungewell.org>
    <CAGXu5jL4H2ukqQDV4syME148bbD3wcSqM0NscvOujnMYtW5w1g@mail.gmail.com>
    <20140417173723.GC10689@mail.corp.redhat.com>
    <CAGXu5jKVCme=a8EVg1BOrB+5enpjT5aABy3QB=div-t230+NSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:50519 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929AbaDWOuF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Apr 2014 10:50:05 -0400
In-Reply-To: <CAGXu5jKVCme=a8EVg1BOrB+5enpjT5aABy3QB=div-t230+NSA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Elias Vanderstuyft <elias.vds@gmail.com>


> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 9e8064205bc7..5205ebb76cd2 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -840,6 +840,15 @@ struct hid_report *hid_validate_values(struct
> hid_device *h
>          * drivers go to access report values.
>          */
>         report = hid->report_enum[type].report_id_hash[id];
> +       if (!report && id == 0) {
> +               /*
> +                * Requesting id 0 means we should fall back to the first
> +                * report in the list.
> +                */
> +               report = list_entry(
> +                               hid->report_enum[type].report_list.next,
> +                               struct hid_report, list);
> +       }
>         if (!report) {
>                 hid_err(hid, "missing %s %u\n", hid_report_names[type],
> id);
>                 return NULL;
>
> Alternatively, should hid_register_report add a default to the hash
> instead, so no change to hid_validate_values is needed?
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 9e8064205bc7..5d07124457ba 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -80,6 +80,8 @@ struct hid_report *hid_register_report(struct hid_device
> *devi
>         report->size = 0;
>         report->device = device;
>         report_enum->report_id_hash[id] = report;
> +       if (!report_enum->report_id_hash[0])
> +               report_enum->report_id_hash[0] = report;
>
>         list_add_tail(&report->list, &report_enum->report_list);
>
>
>
> -Kees

I tried this patch last night and saw Kernel Panics on controller
insertion and/or removal....

And just noticed that you have another more recent one, so I'll try that
tonight. My bad :-(

Simon.

