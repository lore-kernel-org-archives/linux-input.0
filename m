From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 1/2] HID: logitech-hidpp: fix negated returns
Date: Mon, 3 Nov 2014 23:32:30 +0300
Message-ID: <20141103203230.GV6890@mwanda>
References: <1415044253-18734-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:37236 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753355AbaKCUcc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Nov 2014 15:32:32 -0500
Content-Disposition: inline
In-Reply-To: <1415044253-18734-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Nestor Lopez Casado <nlopezcasad@logitech.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Nov 03, 2014 at 02:50:52PM -0500, Benjamin Tissoires wrote:
> @@ -524,8 +541,11 @@ static int hidpp_touchpad_get_raw_info(struct hidpp_device *hidpp,
>  	ret = hidpp_send_fap_command_sync(hidpp, feature_index,
>  		CMD_TOUCHPAD_GET_RAW_INFO, NULL, 0, &response);
>  
> -	if (ret)
> -		return -ret;
> +	if (ret > 0) {
> +		hid_err(hidpp->hid_dev, "%s: received protocol error 0x%02x\n",
> +			__func__, ret);
> +		return -EPROTO;
> +	}

We should handle -ENOMEM and -EINVAL here as well.  Something like:

	if (ret > 0) {
		hid_err(hidpp->hid_dev, "%s: received protocol error 0x%02x\n",
		        __func__, ret);
		ret = -EPROTO;
	}
	if (ret)
		return ret;

regards,
dan carpenter
