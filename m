From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] FIX mask to enable DJ mode
Date: Thu, 2 Feb 2012 10:54:40 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1202021054300.18918@pobox.suse.cz>
References: <1326797411-26520-1-git-send-email-nlopezcasad@logitech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1326797411-26520-1-git-send-email-nlopezcasad@logitech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nestor Lopez Casado <nlopezcasad@logitech.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, ogay@logitech.com, jzanone@logitech.com
List-Id: linux-input@vger.kernel.org

On Tue, 17 Jan 2012, Nestor Lopez Casado wrote:

> 
> Signed-off-by: Nestor Lopez Casado <nlopezcasad@logitech.com>
> ---
> Hi everyone, 
> 
> This is a minor bug I discovered while developing the 'soon to be posted'
> driver for the Logitech Unifying Wireless Touchpad.
> 
> The user can only experience the bug if she pairs 6 devices to a Unifying
> receiver. The sixth paired device would not work.
> 
> The value changed is actually a bitmask that enables reporting from each
> paired device. As the sixth bit was not set, the sixth device reports are
> ignored by the receiver and never get to the driver.
> 
> Jiri, this is a minor change and a real bug fix which might be posted to 
> stable, but as I anticipate that user impact will be really low I would say
> that there is no problem on letting this fix going to your branch only.
> 
> Cheers, 
>     Nestor
> 
>  drivers/hid/hid-logitech-dj.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
> index 38b12e4..2b56efc 100644
> --- a/drivers/hid/hid-logitech-dj.c
> +++ b/drivers/hid/hid-logitech-dj.c
> @@ -445,7 +445,7 @@ static int logi_dj_recv_switch_to_dj_mode(struct dj_receiver_dev *djrcv_dev,
>  	dj_report.report_id = REPORT_ID_DJ_SHORT;
>  	dj_report.device_index = 0xFF;
>  	dj_report.report_type = REPORT_TYPE_CMD_SWITCH;
> -	dj_report.report_params[CMD_SWITCH_PARAM_DEVBITFIELD] = 0x1F;
> +	dj_report.report_params[CMD_SWITCH_PARAM_DEVBITFIELD] = 0x3F;
>  	dj_report.report_params[CMD_SWITCH_PARAM_TIMEOUT_SECONDS] = (u8)timeout;
>  	return logi_dj_recv_send_report(djrcv_dev, &dj_report);

I have applied the fix, thanks Nestor.

-- 
Jiri Kosina
SUSE Labs
