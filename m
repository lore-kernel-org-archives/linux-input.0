From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: wacom: Stop mapping touch usages after processing
 HID_DG_CONTACTCOUNT
Date: Tue, 12 Jul 2016 09:32:50 +0200
Message-ID: <20160712073250.GE4663@mail.corp.redhat.com>
References: <20160711175950.17121-1-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50181 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750748AbcGLHcz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Jul 2016 03:32:55 -0400
Content-Disposition: inline
In-Reply-To: <20160711175950.17121-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

Hi Jason,

On Jul 11 2016 or thereabouts, Jason Gerecke wrote:
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
> To prevent this from occuring, we stop mapping usages after having seen
> HID_DG_CONTACTCOUNT. This usage is only present in multitouch reports,
> so the format of any following single-touch reports will have no effect.

I had a quick look at the driver, and it looks like the Cintiq Companion
2 has more than one multitouch collection (see 499522c "HID: wacom: Tie
cached HID_DG_CONTACTCOUNT indices to report ID").

So if this doesn't break the cintiq companion 2, you have my
reviewed-by, but I'd rather be sure (and please see if we really need to
keep 499522c then).

Cheers,
Benjamin

> 
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> ---
>  drivers/hid/wacom_wac.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index fcf2264..e499cdb 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -1560,6 +1560,11 @@ static void wacom_wac_finger_usage_mapping(struct hid_device *hdev,
>  	struct input_dev *input = wacom_wac->touch_input;
>  	unsigned touch_max = wacom_wac->features.touch_max;
>  
> +	/* stop processing after the first multitouch report */
> +	if (wacom_wac->hid_data.cc_report &&
> +	    wacom_wac->hid_data.cc_report != field->report->id)
> +		return;
> +
>  	switch (usage->hid) {
>  	case HID_GD_X:
>  		features->last_slot_field = usage->hid;
> -- 
> 2.9.0
> 
