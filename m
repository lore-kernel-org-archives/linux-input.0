From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: Re: [PATCH] hid: hid-core: Fix a sleep-in-atomic-context bug in
 __hid_request()
Date: Thu, 6 Sep 2018 10:35:14 +0800
Message-ID: <6ec3d032-6d33-d2af-965f-7f3457dc8311@gmail.com>
References: <20180901121659.1257-1-baijiaju1990@gmail.com>
 <nycvar.YFH.7.76.1809051026540.15880@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <nycvar.YFH.7.76.1809051026540.15880@cbobk.fhfr.pm>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org



On 2018/9/5 16:29, Jiri Kosina wrote:
> On Sat, 1 Sep 2018, Jia-Ju Bai wrote:
>
>> The driver may sleep with holding a spinlock.
>>
>> The function call paths (from bottom to top) in Linux-4.16 are:
>>
>> [FUNC] hid_alloc_report_buf(GFP_KERNEL)
>> drivers/hid/hid-core.c, 1435:
>> 	hid_alloc_report_buf in __hid_request
>> ./include/linux/hid.h, 1023:
>> 	__hid_request in hid_hw_request
>> drivers/hid/hid-picolcd_core.c, 111:
>> 	hid_hw_request in picolcd_send_and_wait
>> drivers/hid/hid-picolcd_core.c, 100:
>> 	_raw_spin_lock_irqsave in picolcd_send_and_wait
>>
>> [FUNC] hid_alloc_report_buf(GFP_KERNEL)
>> drivers/hid/hid-core.c, 1435:
>> 	hid_alloc_report_buf in __hid_request
>> ./include/linux/hid.h, 1023:
>> 	__hid_request in hid_hw_request
>> drivers/hid/hid-picolcd_core.c, 245:
>> 	hid_hw_request in picolcd_reset
>> drivers/hid/hid-picolcd_core.c, 235:
>> 	_raw_spin_lock_irqsave in picolcd_reset
>>
>> [FUNC] hid_alloc_report_buf(GFP_KERNEL)
>> drivers/hid/hid-core.c, 1435:
>> 	hid_alloc_report_buf in __hid_request
>> ./include/linux/hid.h, 1023:
>> 	__hid_request in hid_hw_request
>> drivers/hid/hid-picolcd_fb.c, 215:
>> 	hid_hw_request in picolcd_fb_reset
>> drivers/hid/hid-picolcd_fb.c, 206:
>> 	_raw_spin_lock_irqsave in picolcd_fb_reset
>>
>> [FUNC] hid_alloc_report_buf(GFP_KERNEL)
>> drivers/hid/hid-core.c, 1435:
>> 	hid_alloc_report_buf in __hid_request
>> ./include/linux/hid.h, 1023:
>> 	__hid_request in hid_hw_request
>> drivers/hid/hid-lg4ff.c, 465:
>> 	hid_hw_request in lg4ff_play
>> drivers/hid/hid-lg4ff.c, 441:
>> 	_raw_spin_lock_irqsave in lg4ff_play
>>
>> To fix this bug, GFP_KERNEL is replaced with GFP_ATOMIC.
>>
>> This bug is found by my static analysis tool DSAC.
> Could you please rewrite the changelog so that it's human readable? The
> above is a bit hard to understand, I think something along the lines of
> "__hid_request() has to be allocating with GFP_ATOMIC because there are
> the following callchains leading to __hid_request() being an atomic
> context: ... a->b->c.._hid_request()" etc.
>

Okay, I will send a new patch.


Best wishes,
Jia-Ju Bai
