From: Daniel Wagner <daniel.wagner-98C5kh4wR6ohFhg+JK9F0w@public.gmane.org>
Subject: Re: [RFC v0 7/8] Input: ims-pcu: use firmware_stat instead of
 completion
Date: Fri, 29 Jul 2016 08:13:01 +0200
Message-ID: <c05a7b98-5ada-701f-9a77-65d81b841c17@bmw-carit.de>
References: <1469692512-16863-1-git-send-email-wagi@monom.org>
 <1469692512-16863-8-git-send-email-wagi@monom.org>
 <20160728183343.GD16852@dtor-ws> <20160728190151.GV13516@tuxbot>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160728190151.GV13516@tuxbot>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Daniel Wagner <wagi-kQCPcA+X3s7YtjvyW6yDsg@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Johannes Berg <johannes.berg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kselftest-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 07/28/2016 09:01 PM, Bjorn Andersson wrote:
> On Thu 28 Jul 11:33 PDT 2016, Dmitry Torokhov wrote:
>
>> On Thu, Jul 28, 2016 at 09:55:11AM +0200, Daniel Wagner wrote:
>>> From: Daniel Wagner <daniel.wagner-98C5kh4wR6ohFhg+JK9F0w@public.gmane.org>
>>>
> [..]
>>
>> Do not quite like it... I'd rather asynchronous request give out a
>> firmware status pointer that could be used later on.
>>
>> 	pcu->fw_st = request_firmware_async(IMS_PCU_FIRMWARE_NAME,
>> 					    pcu,
>> 					    ims_pcu_process_async_firmware);
>> 	if (IS_ERR(pcu->fw_st))
>> 		return PTR_ERR(pcu->fw_st);
>>
>> 	....
>>
>> 	fw_loading_wait(pcu->fw_st);
>>
>
> In the remoteproc case (patch 6) this would clean up the code, rather
> than replacing the completion API 1 to 1. I like it!

IIRC most drivers do it the same way. So request_firmware_async() indeed 
would be good thing to have. Let me try that.

Thanks for the excellent feedback.

cheers,
daniel
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
