From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: Re: [PATCH] input: add EETI eGalax I2C capacitive multi touch driver.
Date: Fri, 29 Jul 2011 14:00:53 +0800
Message-ID: <4E324C95.9020304@cn.fujitsu.com>
References: <1311672354-15453-1-git-send-email-jiejing.zhang@freescale.com> <4E2E8D4E.8070803@cn.fujitsu.com> <CACrgxGDpQw7bdeJYSZg-hgt-NEwhTdbaTFeAWprr-0Qi0WsAbw@mail.gmail.com>
Reply-To: gaowanlong@cn.fujitsu.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:50903 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754508Ab1G2GC1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 29 Jul 2011 02:02:27 -0400
In-Reply-To: <CACrgxGDpQw7bdeJYSZg-hgt-NEwhTdbaTFeAWprr-0Qi0WsAbw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Jiejing.Zhang" <kzjeef@gmail.com>
Cc: Zhang Jiejing <jiejing.zhang@freescale.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

On 07/29/2011 01:28 PM, Jiejing.Zhang wrote:
> Hi Gao,
>
> 2011/7/26 Wanlong Gao<gaowanlong@cn.fujitsu.com>
>>
>> On 07/26/2011 05:25 PM, Zhang Jiejing wrote:
>>>
>>> this patch adds EETI eGalax serial multi touch controller driver.
>>>
>>> EETI eGalax serial touch screen controller is a I2C based multiple
>>> capacitive touch screen controller, it can supports 5 touch events maximum.
>>>
>>> Signed-off-by: Zhang Jiejing<jiejing.zhang@freescale.com>
>>> ---
>>>   drivers/input/touchscreen/Kconfig     |   10 +
>>>   drivers/input/touchscreen/Makefile    |    1 +
>>>   drivers/input/touchscreen/egalax_ts.c |  314 +++++++++++++++++++++++++++++++++
>>>   3 files changed, 325 insertions(+), 0 deletions(-)
>>>   create mode 100644 drivers/input/touchscreen/egalax_ts.c
>>>
>>
>>> +
>>> +       if (down) {
>>> +               /* since egalax only report one of multi touch event,
>>> +                * so we need record pervious event with different id
>>> +                * and report them.*/
>>> +               events[id].valid = valid;
>>> +               events[id].status = down;
>>> +               events[id].x = x;
>>> +               events[id].y = y;
>>> +
>>> +               for (i = 0; i<    MAX_SUPPORT_POINTS; i++) {
>>> +                       if (!events[i].valid)
>>> +                               continue;
>>> +                       dev_dbg(&client->dev, "report id:%d valid:%d x:%d y:%d",
>>> +                               i, valid, x, y);
>>> +
>>> +                       input_report_abs(input_dev,
>>> +                                        ABS_MT_TRACKING_ID, i);
>>> +                       input_report_abs(input_dev,
>>> +                                        ABS_MT_TOUCH_MAJOR, 1);
>>> +                       input_report_abs(input_dev,
>>> +                                        ABS_MT_POSITION_X, events[i].x);
>>> +                       input_report_abs(input_dev,
>>> +                                        ABS_MT_POSITION_Y, events[i].y);
>>> +                       input_mt_sync(input_dev);
>>> +               }
>>> +       } else {
>>> +               dev_dbg(&client->dev, "release id:%d\n", id);
>>> +               events[id].valid = 0;
>>> +               events[id].status = 0;
>>> +               input_report_abs(input_dev, ABS_MT_TRACKING_ID, id);
>>> +               input_event(input_dev, EV_ABS, ABS_MT_TOUCH_MAJOR, 0);
>>> +               input_mt_sync(input_dev);
>>> +       }
>>> +
>>> +       input_sync(input_dev);
>>
>> need re-sync here ?
>
> it's not re-sync, input_mt_sync() is different from input_sync(), the
> mt_sync is used to notify a multi touch event is finish. but a
> input_sync() means a input event is finished.
> eg,
> one input event may have many multi touch event.
> [MT 1,  x, y]
> [mt sync]
> [MT 2, x, y]
> [mt sync]
> [input sync]
> [MT 1,  x, y]
> [mt sync]
> [MT 2, x, y]
> [mt sync]
> [input sync]
> ...
	case SYN_MT_REPORT:
		dev->sync = false;
Yeah, I see, thanks a lot.


> BR,
> Jiejing
>
-- 
Thanks
Best Regards
Wanlong Gao
