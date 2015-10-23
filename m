From: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 06/19] input: tegra-kbc: enable support for the standard
 "wakeup-source" property
Date: Fri, 23 Oct 2015 11:23:51 +0100
Message-ID: <562A0AB7.3080607@arm.com>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
 <1445422216-29375-7-git-send-email-sudeep.holla@arm.com>
 <20151023063946.GA38047@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151023063946.GA38047@dtor-ws>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org



On 23/10/15 07:39, Dmitry Torokhov wrote:
> On Wed, Oct 21, 2015 at 11:10:03AM +0100, Sudeep Holla wrote:
>> Though the mmc core driver should/will continue to support the legacy
>> "nvidia,wakeup-source" property to enable SDIO as the wakeup source, we
>> need to add support for the new standard property "wakeup-source".
>>
>> This patch adds support for "wakeup-source" property in addition to the
>> existing "nvidia,wakeup-source" property.
>>
>> Cc: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Signed-off-by: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
>
> Applied, thank you.
>

Thanks, but I think I sent out a old copy which had unrelated commit
message because of copy-paste. *Sorry for that*. Can you update it
something like:

"
Though the tegra-kbc driver should/will continue to support the legacy
"nvidia,wakeup-source" property to enable keyboard as the wakeup source,
we need to add support for the new standard property "wakeup-source".

This patch adds support for "wakeup-source" property in addition to the
existing "nvidia,wakeup-source" property.
"
-- 
Regards,
Sudeep
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
