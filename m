From: Stephen J <stephenjust@gmail.com>
Subject: Re: [PATCH 2/2] Input - surface3_spi: add surface pen support for
 Surface 3
Date: Tue, 24 May 2016 13:15:34 -0600
Message-ID: <CAOvWGzgVgNCeeRvm9NmF+eZY84PXFifSe1UC0-H8c=pvmYFmQw@mail.gmail.com>
References: <1464011734-18657-1-git-send-email-stephenjust@gmail.com>
 <1464011734-18657-3-git-send-email-stephenjust@gmail.com> <20160524100527.GA980@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:35104 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753832AbcEXTPy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 May 2016 15:15:54 -0400
Received: by mail-io0-f181.google.com with SMTP id p64so18448099ioi.2
        for <linux-input@vger.kernel.org>; Tue, 24 May 2016 12:15:54 -0700 (PDT)
In-Reply-To: <20160524100527.GA980@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>

On Tue, May 24, 2016 at 4:05 AM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> Hi Stephen,
>
> thanks for the submission.
>
> On May 23 2016 or thereabouts, Stephen Just wrote:
>> This change creates a second input device which will handle input from
>> a Surface Pen. The Surface Pen supplies a different packet header than
>> touch events, so it is simple to handle one or the other.
>>
>> This patch handles both the newer Surface Pen with one button, and the
>> older variant with a second button to switch to Eraser mode.
>
> Oh... Would you mind sharing an evemu-record of such older variant with
> the Eraser mode? We might need to deal with that differently in
> libinput...
>

I have uploaded several evemu-record logs to
https://gist.github.com/stephenjust/6f00811a2b9a6eccca506ea3f9f5d870

I think the most notable thing is that the pen seems to be able to
report its position at a further distance than it is able to determine
which buttons are pressed, i.e. if you hold the eraser button down and
bring the pen towards the screen, there will be a point where the pen
is detected, and then as you get closer, it will change tool types.
The same is true for detecting the other stylus button, you need to
get closer for it to be detected.

>> [snip]
>>
>>  static void surface3_spi_process(struct surface3_ts_data *ts_data)
>>  {
>>       const char header[] = {0xff, 0xff, 0xff, 0xff, 0xa5, 0x5a, 0xe7, 0x7e, 0x01};
>> @@ -127,6 +183,8 @@ static void surface3_spi_process(struct surface3_ts_data *ts_data)
>>
>>       if (data[9] == SURFACE3_REPORT_TOUCH)
>>               surface3_spi_process_touch(ts_data, data);
>> +     else if (data[9] == SURFACE3_REPORT_PEN)
>> +             surface3_spi_process_pen(ts_data, data);
>
> nitpicking: a switch/case would present better :)
>

I will send out another revision with a switch/case shortly.

Regards,
Stephen Just
