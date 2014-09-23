From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: input: Finish TransducerSerialNumber implementation
Date: Tue, 23 Sep 2014 11:12:24 -0400
Message-ID: <20140923151224.GB3110@mail.corp.redhat.com>
References: <1411405130-1663-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:4269 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752593AbaIWPMd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Sep 2014 11:12:33 -0400
Content-Disposition: inline
In-Reply-To: <1411405130-1663-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, pinglinux@gmail.com, Jason Gerecke <jason.gerecke@wacom.com>

Hi Jason,

On Sep 22 2014 or thereabouts, Jason Gerecke wrote:
> The commit which introduced TransducerSerialNumber (368c966) is missing
> two crucial implementation details. Firstly, the commit does not set the
> type/code/bit/max fields as expected later down the code which can cause
> the driver to crash when a tablet with this usage is connected. Secondly,
> the code to send a MSC_SERIAL event to userspace when this usage is seen
> in a report is nowhere to be found. This commit addresses both issues.
> 
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> ---
>  drivers/hid/hid-input.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 2619f7f..abed624 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -690,6 +690,10 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>  
>  		case 0x5b: /* TransducerSerialNumber */
>  			set_bit(MSC_SERIAL, input->mscbit);
> +			usage->type = EV_MSC;
> +			usage->code = MSC_SERIAL;
> +			bit = input->mscbit;
> +			max = MSC_MAX;
>  			break;
>  
>  		default:  goto unknown;
> @@ -1041,6 +1045,11 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
>  		input_event(input, EV_KEY, BTN_TOUCH, value > a + ((b - a) >> 3));
>  	}
>  
> +	if (usage->hid == (HID_UP_DIGITIZER | 0x005b)) { /* TransducerSerialNumber */
> +		input_event(input, EV_MSC, MSC_SERIAL, value);
> +		return;
> +	}
> +

Are you sure that the generic call to 
"input_event(input, usage->type, usage->code, value);" in the end of
hidinput_hid_event() is not sufficient enough?

As long as the usage/code are set in the hid_usage struct, you should be
fine.

Cheers,
Benjamin

>  	if (usage->hid == (HID_UP_PID | 0x83UL)) { /* Simultaneous Effects Max */
>  		dbg_hid("Maximum Effects - %d\n",value);
>  		return;
> -- 
> 2.1.0
> 
