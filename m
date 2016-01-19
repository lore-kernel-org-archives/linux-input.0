From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: uinput on headless system ...
Date: Tue, 19 Jan 2016 14:56:24 -0800
Message-ID: <CAKdAkRSsj=e5dMSwVoEczQh_UjcNvrFMQUOCPUTtGvAmk6KLAA@mail.gmail.com>
References: <56965CFB.3020401@icid.cu>
	<20160113222151.GE39593@dtor-ws>
	<CAN+gG=FirVq_MrXDkFe8K=7TEVzif9MSHvov4SyZE1M_Z5N=8g@mail.gmail.com>
	<5697AB41.3070001@icid.cu>
	<CAN+gG=Fcz7riLQPhmwZWF8X9xGCQ346rhcOH-Qu5rH-oEkj-xw@mail.gmail.com>
	<5697BBBD.4050003@icid.cu>
	<569E4E44.4030906@icid.cu>
	<20160119213647.GB31589@dtor-ws>
	<569EB1A2.5000907@icid.cu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:35008 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757914AbcASW4Z (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Jan 2016 17:56:25 -0500
Received: by mail-oi0-f41.google.com with SMTP id p187so185640541oia.2
        for <linux-input@vger.kernel.org>; Tue, 19 Jan 2016 14:56:24 -0800 (PST)
In-Reply-To: <569EB1A2.5000907@icid.cu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roberto Alejandro Espi Munoz <raespi@icid.cu>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>

On Tue, Jan 19, 2016 at 1:58 PM, Roberto Alejandro Espi Munoz
<raespi@icid.cu> wrote:
> The error is produced when the write operation doesn't return the same
> number of bytes as the one requested to write.  Is there any other way of
> checking a specific error message on files associated with devices?
>
> if (write( uinputDev, &event, sizeof(struct input_event)) != sizeof( struct
> input_event) )
> {
>     fprintf(stderr, "Error on send_event");
>     return -1;
>  }

1. Could you please stop top-posting
2. man errno; man strerror
3. I wonder what was the return value from write() and what is
sizeof(struct inptu_event) on your system.
4. Please do take care when describing your problem. In your original
email you said that "... the uinput device fails to open".
5. Is it system with 64 bit kernel and 32 bit userspace by any chance?

Thanks.

 >
> On 01/19/2016 04:36 PM, Dmitry Torokhov wrote:
>>
>> On Tue, Jan 19, 2016 at 09:55:00AM -0500, Roberto Alejandro Espi Munoz
>> wrote:
>>>
>>> Bump ... any other insights or suggestions I could try?
>>>
>> You can check what error you are getting when trying to open the device
>> and that might give you idea.
>>
>> Thanks.
>>
>
>

-- 
Dmitry
