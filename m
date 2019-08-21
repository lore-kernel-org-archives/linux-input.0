From: Jiada Wang <jiada_wang@mentor.com>
Subject: Re: [PATCH v1 01/63] Input: introduce input_mt_report_slot_inactive
Date: Wed, 21 Aug 2019 18:13:18 +0900
Message-ID: <9359e5aa-0121-7165-1699-f62aecd1c583@mentor.com>
References: <20190816082952.17985-1-jiada_wang@mentor.com>
 <20190816082952.17985-2-jiada_wang@mentor.com>
 <20190816171226.GE121898@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190816171226.GE121898@dtor-ws>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: nick@shmanahar.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, george_davis@mentor.com
List-Id: linux-input@vger.kernel.org

Hi Dmitry

On 2019/08/17 2:12, Dmitry Torokhov wrote:
> Hi Jiada,
> 
> On Fri, Aug 16, 2019 at 05:28:50PM +0900, Jiada Wang wrote:
>> input_mt_report_slot_state() ignores the tool when the slot is closed.
>> which has caused a bit of confusion.
>> This patch introduces input_mt_report_slot_inactive() to report slot
>> inactive state.
>> replaces all input_mt_report_slot_state() with input_mt_report_slot_inactive()
>> in case of close of slot, also some other related changes.
> 
> This seems to actually contain 2 changes:
> 
> - switching to use return value of input_mt_report_slot_state()
> - actually introducing and using input_mt_report_slot_inactive()
> 
> Please split them.
> 
will split this patch into two in v2 patchset

>>   
>> +/**
>> + * input_mt_report_slot_inactive() - report contact inactive state
>> + * @dev: input device with allocated MT slots
>> + *
>> + * Reports the contact inactive state via ABS_MT_TRACKING_ID
>> + *
>> + */
>> +void input_mt_report_slot_inactive(struct input_dev *dev)
>> +{
>> +	input_event(dev, EV_ABS, ABS_MT_TRACKING_ID, -1);
>> +}
>> +EXPORT_SYMBOL(input_mt_report_slot_inactive);
> 
> I think this should be a static inline, there is no need to have out of
> line implementation for a 1-liner.
>
will change to a inline function in v2 patchset.

Thanks,
Jiada

> Thanks.
> 
