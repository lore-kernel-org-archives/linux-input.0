From: Jiada Wang <jiada_wang@mentor.com>
Subject: Re: [PATCH v3 02/49] Input: introduce input_mt_report_slot_inactive
Date: Tue, 24 Sep 2019 16:16:03 +0900
Message-ID: <a66d29fc-50fc-da82-5178-cf349d70a14b@mentor.com>
References: <20190917093320.18134-1-jiada_wang@mentor.com>
 <20190917093320.18134-3-jiada_wang@mentor.com>
 <546c8205-ecb7-1c34-3727-b10c7ff86232@bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <546c8205-ecb7-1c34-3727-b10c7ff86232@bitmath.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.org>, nick@shmanahar.org, dmitry.torokhov@gmail.com, jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Henrik


On 2019/09/18 3:25, Henrik Rydberg wrote:
> Hi Jiada,
> 
>> input_mt_report_slot_state() ignores the tool when the slot is closed.
>> which has caused a bit of confusion.
>> This patch introduces input_mt_report_slot_inactive() to report slot
>> inactive state.
>> replaces all input_mt_report_slot_state() with
>> input_mt_report_slot_inactive() in case of close of slot.
> 
> This patch looks very odd, I am afraid.
> 
> When a driver needs to use input_mt functions, it first calls 
> input_mt_init_slots() during setup. The MT state then remains in effect 
> until the driver is destroyed. Thus, there is no valid case when 
> input_mt_report_slot_state() would fail to execute the line
> 
>     input_event(dev, EV_ABS, ABS_MT_TRACKING_ID, -1)
> 
> when active == false.
> 
> What input_mt_report_slot_state() does do, however, is to ignore the 
> event when no MT state has been set, which does happen for some drivers 
> handling both normal and MT devices. Changing such a driver in the way 
> you suggest would introduce new events in existing, working cases, and 
> possibly break userspace. We should try very hard to avoid it.
> 

thanks for your comment,

Just to make sure, I think your comment is for
patch "[PATCH v3 01/49] Input: switch to use return value of 
input_mt_report_slot_state"
not for "[PATCH v3 02/49] Input: introduce 
input_mt_report_slot_inactive", right?

yes, I agree
by having change:

-    input_mt_report_slot_state(dev, tool_type, active);
-    if (active) {
+        if (input_mt_report_slot_state(dev, tool_type, active)){
              ... ...
      }

the logic of the driver is changed, when (mt == NULL && active == true).
I will drop patch "Input: switch to use return value of" in next version

Thanks,
Jiada

> Thanks,
> 
> Henrik
> 
> 
