From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: Re: [PATCH] hid: sony: Use kernel allocated buffers for HID reports
Date: Wed, 12 Nov 2014 10:18:43 -0500
Message-ID: <CAH+9E3rxza-Mie+18CUpjKZTap_pDB+Zjnb2C0XxnmWVt-106Q@mail.gmail.com>
References: <1415728913-2679-1-git-send-email-frank.praznik@oh.rr.com>
	<20141111190412.GC27720@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:48071 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617AbaKLPSo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Nov 2014 10:18:44 -0500
Received: by mail-ie0-f181.google.com with SMTP id rp18so13256815iec.26
        for <linux-input@vger.kernel.org>; Wed, 12 Nov 2014 07:18:43 -0800 (PST)
In-Reply-To: <20141111190412.GC27720@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "open list:HID CORE LAYER <linux-input@vger.kernel.org>, Jiri Kosina" <linux-input@vger.kernel.org>, "open list:HID CORE LAYER <linux-input@vger.kernel.org>, Jiri Kosina" <jkosina@suse.cz>

On Tue, Nov 11, 2014 at 2:04 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Frank,
>>  static spinlock_t sony_dev_list_lock;
>>  static LIST_HEAD(sony_device_list);
>>  static DEFINE_IDA(sony_device_id_allocator);
>> @@ -811,6 +814,7 @@ struct sony_sc {
>>       struct work_struct state_worker;
>>       struct power_supply battery;
>>       int device_id;
>> +     __u8 *output_report_dmabuf;
>
> Just to confirm as I haven't looked at the entire driver: there is no
> possibility of 2 requests being submitted at the same time so that one
> will overwrite other's data?
>
> --
> Dmitry

Output reports are sent using a work request submitted to the kernel
work queue with schedule_work(), so using one buffer is safe since the
work_struct can't be scheduled multiple times or simultaneously
execute across multiple cores.

The other comments you had are addressed in v2 of the patch.
