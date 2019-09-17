From: Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: [PATCH v3 02/49] Input: introduce input_mt_report_slot_inactive
Date: Tue, 17 Sep 2019 20:25:03 +0200
Message-ID: <546c8205-ecb7-1c34-3727-b10c7ff86232@bitmath.org>
References: <20190917093320.18134-1-jiada_wang@mentor.com>
 <20190917093320.18134-3-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190917093320.18134-3-jiada_wang@mentor.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiada Wang <jiada_wang@mentor.com>, nick@shmanahar.org, dmitry.torokhov@gmail.com, jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Jiada,

> input_mt_report_slot_state() ignores the tool when the slot is closed.
> which has caused a bit of confusion.
> This patch introduces input_mt_report_slot_inactive() to report slot
> inactive state.
> replaces all input_mt_report_slot_state() with
> input_mt_report_slot_inactive() in case of close of slot.

This patch looks very odd, I am afraid.

When a driver needs to use input_mt functions, it first calls 
input_mt_init_slots() during setup. The MT state then remains in effect 
until the driver is destroyed. Thus, there is no valid case when 
input_mt_report_slot_state() would fail to execute the line

    input_event(dev, EV_ABS, ABS_MT_TRACKING_ID, -1)

when active == false.

What input_mt_report_slot_state() does do, however, is to ignore the 
event when no MT state has been set, which does happen for some drivers 
handling both normal and MT devices. Changing such a driver in the way 
you suggest would introduce new events in existing, working cases, and 
possibly break userspace. We should try very hard to avoid it.

Thanks,

Henrik
