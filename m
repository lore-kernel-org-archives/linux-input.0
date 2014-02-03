From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] HID: Add HID transport driver documentation
Date: Mon, 3 Feb 2014 18:02:39 +0100
Message-ID: <CANq1E4TyUKZ+eZWj2Pk8t5gc_Se_tPQhE5VT9U+yQ3mXFzoKMQ@mail.gmail.com>
References: <1391009323-3122-1-git-send-email-frank.praznik@oh.rr.com>
	<CANq1E4TAomD4mKnPYKHBTShV4dynh2dJVQ-bWwAiLJH8g1XFFw@mail.gmail.com>
	<CAN+gG=Gi6XUkRED_Bah63TqT80G5x7wn2L33=BFsMYr94geWxA@mail.gmail.com>
	<CANq1E4QFkBGvqpHwEW135c9Ay9Kv1rbA0etsR=mS_dfEqpQeZQ@mail.gmail.com>
	<CAN+gG=F0fBJ=Ln+4Nc=NTPehwrUhBVYqL4hnYSQhE_4rzP_2oA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:53051 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870AbaBCRCk (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Feb 2014 12:02:40 -0500
Received: by mail-ig0-f182.google.com with SMTP id uy17so4511695igb.3
        for <linux-input@vger.kernel.org>; Mon, 03 Feb 2014 09:02:39 -0800 (PST)
In-Reply-To: <CAN+gG=F0fBJ=Ln+4Nc=NTPehwrUhBVYqL4hnYSQhE_4rzP_2oA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Frank Praznik <frank.praznik@oh.rr.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

Hi

On Mon, Feb 3, 2014 at 5:52 PM, Benjamin Tissoires
<benjamin.tissoires@gmail.com> wrote:
[snip]
>>>>> + - void (*request) (struct hid_device *hdev, struct hid_report *report,
>>>>> +                    int reqtype)
>>>>> +   Send an HID request on the ctrl channel. "report" contains the report that
>>>>> +   should be sent and "reqtype" the request type. Request-type can be
>>>>> +   HID_REQ_SET_REPORT or HID_REQ_GET_REPORT.
>>>>> +   This callback is optional. If not provided, HID core will assemble a raw
>>>>> +   report following the HID specs and send it via the ->raw_request() callback.
>>>
>>> This is not true currently. Aren't we missing a commit in the original series?
>>> But I would love seeing this come true.
>>
>> You're talking about the ->request() to ->raw_request() conversion?
>> Indeed, that hasn't been implemented. But it should be rather easy to
>> do, right? I will prepare a patch for that so we can apply this
>> documentation unchanged.
>
> Don't bother doing it, I have already made it yesterday :)
>
> The documentation would still need to be cleaned to remove
> hid_input_event callback... So I can take it in the next round of
> ll_transport cleanup if you are ok too.

Perfect, all fine with me!

Thanks
David
