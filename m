From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: touchscreen: add driver for Pixcir Tango C series capacitive touchscreen
Date: Thu, 19 Sep 2013 19:09:55 -0500
Message-ID: <1600c874-f38a-42b6-bee9-066435031b7b@email.android.com>
References: <1379579911-9763-1-git-send-email-Baohua.Song@csr.com> <20130919161239.GB5731@core.coreip.homeip.net> <CAGsJ_4wLc3aaSZyoEKNiyWhCQHKnv3MLHq6riS_=YZeqNGSeJg@mail.gmail.com> <CAGsJ_4zd0YDDHibBHuARrW7WkzojTpY_rzgjSAO1Y4cGnaeGHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:52233 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566Ab3ITAKO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Sep 2013 20:10:14 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so8933363pbc.7
        for <linux-input@vger.kernel.org>; Thu, 19 Sep 2013 17:10:13 -0700 (PDT)
In-Reply-To: <CAGsJ_4zd0YDDHibBHuARrW7WkzojTpY_rzgjSAO1Y4cGnaeGHA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Lisai Wang <Lisai.Wang@csr.com>, Qipan Li <Qipan.Li@csr.com>, Barry Song <Baohua.Song@csr.com>

Barry Song <21cnbao@gmail.com> wrote:
>>>> +
>>>> +     fingers = ts->touch_data.touch_fingers & 0x07;
>>>> +     if (fingers > 0) {
>>>> +             for (i = 0; i < fingers; i++) {
>>>> +                     /*Get the touch position*/
>>>> +                     input_report_abs(ts->input_dev,
>ABS_MT_POSITION_X,
>>>> +                                    
>ts->touch_data.point[i].posx);
>>>> +                     input_report_abs(ts->input_dev,
>ABS_MT_POSITION_Y,
>>>> +                                    
>ts->touch_data.point[i].posy);
>>>> +
>>>> +                     input_report_key(ts->input_dev,
>ABS_MT_TRACKING_ID,
>>>> +                                     ts->touch_data.point[i].id);
>>>> +                     input_report_abs(ts->input_dev,
>>>> +                                     ABS_MT_TOUCH_MAJOR,
>TOUCH_MAJOR_MAX);
>>>> +                     input_report_abs(ts->input_dev,
>>>> +                                     ABS_MT_WIDTH_MAJOR,
>WIDTH_MAJOR_MAX);
>>>> +                     input_mt_sync(ts->input_dev);
>>>
>>> Any chance we could use the B flavor of MT protocol?
>>
>> i am sorry i missed some, what do you mean for B flavor ?
>
>do you mean API wrappers like input_mt_init_slots(),
>input_mt_report_slot_state() ...?
>

Yes, exactly.


Thanks.

-- 
Dmitry
