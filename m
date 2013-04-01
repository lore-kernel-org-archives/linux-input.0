From: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v3] sysrq: supplementing reset sequence with timeout functionality
Date: Mon, 01 Apr 2013 13:22:02 -0600
Message-ID: <5159DE5A.4090909@linaro.org>
References: <1363963003-18796-1-git-send-email-mathieu.poirier@linaro.org> <20130331073654.GE7919@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:49648 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759562Ab3DATVw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 1 Apr 2013 15:21:52 -0400
Received: by mail-pa0-f42.google.com with SMTP id kq13so1463814pab.15
        for <linux-input@vger.kernel.org>; Mon, 01 Apr 2013 12:21:51 -0700 (PDT)
In-Reply-To: <20130331073654.GE7919@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: arve@android.com, linux-input@vger.kernel.org, kernel-team@android.com, john.stultz@linaro.org

On 13-03-31 01:36 AM, Dmitry Torokhov wrote:
> @@ -748,10 +758,13 @@ static bool sysrq_handle_keypress(struct sysrq_state *sysrq,
>  		if (was_active)
>  			schedule_work(&sysrq->reinject_work);
>  
> -		if (sysrq_detect_reset_sequence(sysrq, code, value)) {
> -			/* Force emergency reboot */
> -			__handle_sysrq(sysrq_xlate[KEY_B], false);
> -		}
> +		if (!sysrq_detect_reset_sequence(sysrq, code, value))
> +			del_timer(&sysrq->keyreset_timer);

I tested this code and it doesn't work.  When all the keys in a reset
combo are asserted and held down the code and value of the last key
keeps on being generated.  Since the only time
'sysrq_detect_reset_sequence' returns true is when

'++state->reset_seq_cnt == state->reset_seq_len &&
                                                !state->reset_canceled'

the very next input event to come in (after a key combo has been
discovered) cancel the timer.

I will send a 'v4' version of my initial patch that will:
- cancel the timer when more keys are pressed
- trigger a reset right away when no timeout value has been specified.
- deal with the miscellaneous name changes.

> +		else if (sysrq_reset_downtime_ms)
> +			mod_timer(&sysrq->keyreset_timer,
> +				jiffies + msecs_to_jiffies(sysrq_reset_downtime_ms));
> +		else
> +			sysrq_do_reset(0);

