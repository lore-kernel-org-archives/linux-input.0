From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH RFT 0/5] iio: mxs-lradc: fix leak and implement PM ops
Date: Mon, 18 Apr 2016 12:44:09 +0200
Message-ID: <5714BA79.40803@denx.de>
References: <1460648909-2657-1-git-send-email-stefan.wahren@i2se.com> <570FF5AF.7010801@denx.de> <57147BEF.4070606@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <57147BEF.4070606-eS4NqCHxEME@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>
Cc: Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 04/18/2016 08:17 AM, Stefan Wahren wrote:
> Am 14.04.2016 um 21:55 schrieb Marek Vasut:
>> On 04/14/2016 05:48 PM, Stefan Wahren wrote:
>>> This patch series fix a memory leak and implements suspend/resume
>>> support for mxs-lradc.
>>>
>>> Patch 1: fix the memory leak
>>> Patch 2-4: refactor mxs-lradc in order to prepare PM implementation
>>> Patch 5: implement suspend/resume support
>>>
>>> These patches has been tested with i.MX23 and i.MX28 but without
>>> a touchscreen. I added only a bogus touchscreen in devicetree.
>>>
>>> It would be nice if someone with a real touchscreen could test it.
>>>
>>> Stefan Wahren (5):
>>>   iio: mxs-lradc: fix memory leak
>>>   iio: mxs-lradc: move TS config into suitable function
>>>   iio: mxs-lradc: move STMP reset out of ADC init
>>>   iio: mxs-lradc: disable only mapped channels in mxs_lradc_hw_stop
>>>   iio: mxs-lradc: implement suspend/resume support
>>>
>>>  drivers/iio/adc/mxs-lradc.c |  116 ++++++++++++++++++++++++++++++-------------
>>>  1 file changed, 82 insertions(+), 34 deletions(-)
>>>
>> On M28EVK:
>>
>> Tested-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
>>
> 
> 
> Thanks. Only one question, does it imply a test with a touchscreen?
> 

Yes, this one [1]. It's an Ampire 800480 display and resistive touch
on top of it.

[1] http://www.denx-cs.de/?q=MxxDK

-- 
Best regards,
Marek Vasut
