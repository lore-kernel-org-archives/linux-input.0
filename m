From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 1/2] HID: input: map digitizer battery usage
Date: Tue, 1 Aug 2017 16:35:33 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1708011631210.30597@cbobk.fhfr.pm>
References: <20170731232104.14708-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170731232104.14708-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jason Gerecke <killertofu@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 31 Jul 2017, Dmitry Torokhov wrote:

> We already mapped battery strength reports from the generic device
> control page, but we did not update capacity from input reports, nor we
> mapped the battery strength report from the digitizer page, so let's
> implement this now.
> 
> Batteries driven by the input reports will now start in "unknown" state,
> and will get updated once we receive first report containing battery
> strength from the device.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/hid/hid-input.c | 181 ++++++++++++++++++++++++++++++++----------------
>  include/linux/hid.h     |   2 +
>  2 files changed, 124 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index ccdff1ee1f0c..5bcd4e4afb54 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -340,13 +340,42 @@ static unsigned find_battery_quirk(struct hid_device *hdev)
>  	return quirks;
>  }
>  
> +static int hidinput_scale_battery_capacity(struct hid_device *dev,
> +					   int value)
> +{
> +	if (dev->battery_min < dev->battery_max &&
> +	    value >= dev->battery_min && value <= dev->battery_max)
> +		value = ((value - dev->battery_min) * 100) /
> +			(dev->battery_max - dev->battery_min);
> +
> +	return value;
> +}
> +
> +static int hidinput_query_battery_capacity(struct hid_device *dev)
> +{
> +	u8 *buf;
> +	int ret;
> +
> +	buf = kmalloc(2, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	ret = hid_hw_raw_request(dev, dev->battery_report_id, buf, 2,
> +				 dev->battery_report_type, HID_REQ_GET_REPORT);
> +	ret = (ret != 2) ? -ENODATA : buf[1];
> +
> +	kfree(buf);
> +
> +	return hidinput_scale_battery_capacity(dev, ret);

Is it intentional that you call hidinput_scale_battery_capacity() here 
even in 'ret == -ENODATA' case?

It wouldn't actually break anything currently, as the 

	value >= dev->battery_min

check in hidinput_scale_battery_capacity() would most likely ensure that 
the value wouldn't get overwritten and then propagated back, but it's 
confusing and error-prone wrt. any future changes.
Or have I missed something?

Thanks,

-- 
Jiri Kosina
SUSE Labs
