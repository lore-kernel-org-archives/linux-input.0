From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: Re: [PATCH V2] hid: hid-core: Fix a sleep-in-atomic-context bug in
 __hid_request()
Date: Sat, 29 Sep 2018 17:00:50 +0800
Message-ID: <4c0096c6-3745-963c-5086-5f579792599b@gmail.com>
References: <20180913033432.16336-1-baijiaju1990@gmail.com>
 <nycvar.YFH.7.76.1809241124480.15880@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <nycvar.YFH.7.76.1809241124480.15880@cbobk.fhfr.pm>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org



On 2018/9/24 17:26, Jiri Kosina wrote:
> On Thu, 13 Sep 2018, Jia-Ju Bai wrote:
>
>> hid_alloc_report_buf() has to be called with GFP_ATOMIC in
>> __hid_request(), because there are the following callchains
>> leading to __hid_request() being an atomic context:
>>
>> picolcd_send_and_wait (acquire a spinlock)
>>    hid_hw_request
>>      __hid_request
>>        hid_alloc_report_buf(GFP_KERNEL)
>>
>> picolcd_reset (acquire a spinlock)
>>    hid_hw_request
>>      __hid_request
>>        hid_alloc_report_buf(GFP_KERNEL)
>>
>> lg4ff_play (acquire a spinlock)
>>    hid_hw_request
>>      __hid_request
>>        hid_alloc_report_buf(GFP_KERNEL)
>>
>> lg4ff_set_autocenter_ffex (acquire a spinlock)
>>    hid_hw_request
>>      __hid_request
>>        hid_alloc_report_buf(GFP_KERNEL)
> Hm, so it's always drivers calling out into core in atomic context. So
> either we take this, and put our bets on being able to allocate the buffer
> without sleeping,

In my opinion, I prefer this way.


Best wishes,
Jia-Ju Bai

> or actually fix the few drivers (it's just lg4ff and
> picolcd at the end of the day) not to do that, and explicitly anotate
> __hid_request() with might_sleep().
>
> Hmm?
>
> Thanks,
>
