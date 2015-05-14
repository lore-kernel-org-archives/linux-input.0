From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 2/2] HID: wacom: Handle failing HID_DG_CONTACTMAX requests
Date: Thu, 14 May 2015 10:22:48 -0400
Message-ID: <20150514142248.GD23647@mail.corp.redhat.com>
References: <1431120302-13691-1-git-send-email-killertofu@gmail.com>
 <1431120302-13691-2-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44253 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933133AbbENOWy (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 14 May 2015 10:22:54 -0400
Content-Disposition: inline
In-Reply-To: <1431120302-13691-2-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, jono <lejono@gmail.com>, Ping Cheng <pinglinux@gmail.com>, linux-input@vger.kernel.org, Jason Gerecke <jason.gerecke@wacom.com>

On May 08 2015 or thereabouts, Jason Gerecke wrote:
> Hardware may not respond to a request for the HID_DG_CONTACTMAX feature and
> we should be tolerant of such a failure. This is especially true when using
> hid-replay where the hardware doesn't exist, but also for devices attached
> to a flaky bus. This patch increases the number of allowable retries to
> match other calls to 'wacom_get_report' and also provides a fallback which
> forces 'touch_max = 16' (enough for any Wacom device seen so far).
> 
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> ---

Just a small nitpick given that I already asked for a v2 on 1/2:

>  drivers/hid/wacom_sys.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 3cd74d9..c9a7e30 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -125,9 +125,17 @@ static void wacom_feature_mapping(struct hid_device *hdev,
>  				break;
>  			data[0] = field->report->id;
>  			ret = wacom_get_report(hdev, HID_FEATURE_REPORT,
> -						data, 2, 0);
> -			if (ret == 2)
> +						data, 2, WAC_CMD_RETRIES);
> +			if (ret == 2) {
>  				features->touch_max = data[1];
> +			}
> +			else {

the else should be on the line above :)

> +				features->touch_max = 16;
> +				dev_warn(&hdev->dev, "wacom_feature_mapping: "

hid_warn(hdev...

> +					 "could not get HID_DG_CONTACTMAX, "
> +					 "defaulting to %d\n",
> +					  features->touch_max);
> +			}
>  			kfree(data);
>  		}
>  		break;
> -- 
> 2.4.0
> 

Cheers,
Benjamin

