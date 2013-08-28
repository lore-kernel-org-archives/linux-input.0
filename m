From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 12/14] HID: sensor-hub: validate feature report details
Date: Wed, 28 Aug 2013 13:42:54 -0700
Message-ID: <521E60CE.6050000@linux.intel.com>
References: <alpine.LNX.2.00.1308282222190.22181@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39118 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753078Ab3H1Ufu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Aug 2013 16:35:50 -0400
In-Reply-To: <alpine.LNX.2.00.1308282222190.22181@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Kees Cook <keescook@chromium.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, srinivas pandruvada <srinivas.pandruvada@intel.com>

On 08/28/2013 01:31 PM, Jiri Kosina wrote:
> From: Kees Cook <keescook@chromium.org>
>
> A HID device could send a malicious feature report that would cause the
> sensor-hub HID driver to read past the end of heap allocation, leaking
> kernel memory contents to the caller.
>
> CVE-2013-2898
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Cc: stable@kernel.org
> ---
>   drivers/hid/hid-sensor-hub.c |    3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> index ca749810..aa34755 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -221,7 +221,8 @@ int sensor_hub_get_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
>   
>   	mutex_lock(&data->mutex);
>   	report = sensor_hub_report(report_id, hsdev->hdev, HID_FEATURE_REPORT);
> -	if (!report || (field_index >=  report->maxfield)) {
> +	if (!report || (field_index >=  report->maxfield) ||
> +	    report->field[field_index]->report_count < 1) {
Is it based on some HID device is sending junk report or just from a 
code review?
>   		ret = -EINVAL;
>   		goto done_proc;
>   	}
Thanks,
Srinivas
