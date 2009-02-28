From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: DragonRise Inc. game controller force feedback
	support
Date: Sat, 28 Feb 2009 14:15:50 -0800
Message-ID: <20090228141046.ZZRA012@mailhub.coreip.homeip.net>
References: <167575d80902261744h3d133416g1afeb5b68d760cbf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.243]:38707 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754297AbZB1WQE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Feb 2009 17:16:04 -0500
Received: by an-out-0708.google.com with SMTP id c2so1298323anc.1
        for <linux-input@vger.kernel.org>; Sat, 28 Feb 2009 14:16:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <167575d80902261744h3d133416g1afeb5b68d760cbf@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard Walmsley <richwalm@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Richard,

On Fri, Feb 27, 2009 at 02:44:11PM +1300, Richard Walmsley wrote:
> Adds force feedback support for USB DragonRise Inc. game controllers.
> These devices are mass produced in China and distributed under several vendors.
> 

Looks pretty good, however it shoudl go through Jiri Kosina (CCed).

> +
> +static int drff_init(struct hid_device *hid)
> +{
> +	struct drff_device *drff;
> +	struct hid_report *report;
> +	struct hid_input *hidinput = list_entry(hid->inputs.next,
> +						struct hid_input, list);

list_first_entry()?

> +	struct list_head *report_list =
> +			&hid->report_enum[HID_OUTPUT_REPORT].report_list;
> +	struct list_head *report_ptr = report_list;
> +	struct input_dev *dev = hidinput->input;
> +	int error;
> +
> +	if (list_empty(report_list)) {
> +		dev_err(&hid->dev, "no output reports found\n");
> +		return -ENODEV;
> +	}
> +
> +	report_ptr = report_ptr->next;
> +
> +	report = list_entry(report_ptr, struct hid_report, list);

You might want to simply use list_first_entry() for this.

-- 
Dmitry
