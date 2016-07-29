From: Daniel Wagner <daniel.wagner-98C5kh4wR6ohFhg+JK9F0w@public.gmane.org>
Subject: Re: [RFC v0 3/8] firmware: Factor out firmware load helpers
Date: Fri, 29 Jul 2016 08:08:50 +0200
Message-ID: <956c030c-1847-eb58-c31b-06ad15c551f0@bmw-carit.de>
References: <1469692512-16863-1-git-send-email-wagi@monom.org>
 <1469692512-16863-4-git-send-email-wagi@monom.org>
 <20160728175706.GB16852@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160728175706.GB16852@dtor-ws>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Wagner <wagi-kQCPcA+X3s7YtjvyW6yDsg@public.gmane.org>
Cc: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Johannes Berg <johannes.berg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kselftest-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 07/28/2016 07:57 PM, Dmitry Torokhov wrote:
> On Thu, Jul 28, 2016 at 09:55:07AM +0200, Daniel Wagner wrote:
>> +int __firmware_stat_wait(struct firmware_stat *fwst,
>> +				long timeout)
>> +{
>> +	int err;
>> +	err = swait_event_interruptible_timeout(fwst->wq,
>> +				is_fw_sync_done(READ_ONCE(fwst->status)),
>> +				timeout);
>> +	if (err == 0 && fwst->status == FW_STATUS_ABORT)
>> +		return -ENOENT;
>> +
>> +	return err;
>> +}
>> +EXPORT_SYMBOL(__firmware_stat_wait);
>> +
>> +void __firmware_stat_set(struct firmware_stat *fwst, unsigned long status)
>> +{
>> +	WRITE_ONCE(fwst->status, status);
>> +	swake_up(&fwst->wq);
>
> Do we need to notify everyone for FW_STATUS_LOADING status?

Hmm, I don't think so. In the end drivers are probably only interested 
in the final result which is either success or fail.

cheers,
daniel
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
