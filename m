From: Nick Bowler <nbowler@draconx.ca>
Subject: Re: PROBLEM: Missing events on thinkpad trackpoint buttons
Date: Wed, 19 Aug 2015 10:10:56 -0400
Message-ID: <CAN_QmVwgPEgXdY7f=tjQdAyfTNDkZQPPps_mESq5oR1D7AgA+A@mail.gmail.com>
References: <CAN_QmVxOaqyZ8fJ29Jtjkb8YnckjQ=q53igOcQuAFmrQG7hiZQ@mail.gmail.com>
	<CAN+gG=GbMrxCUJJJqgROmx6g4jYU+jqW2JKyt3Yz+DL-SMhd8A@mail.gmail.com>
	<CAN+gG=HQ7ViGHSLfBuCSaqPFppOm-9ggEaZFwyXKse7CP_p25A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176]:35584 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbbHSOK4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Aug 2015 10:10:56 -0400
Received: by ykbi184 with SMTP id i184so5905310ykb.2
        for <linux-input@vger.kernel.org>; Wed, 19 Aug 2015 07:10:56 -0700 (PDT)
In-Reply-To: <CAN+gG=HQ7ViGHSLfBuCSaqPFppOm-9ggEaZFwyXKse7CP_p25A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Stephen Chandler Paul <thatslyude@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <andrew.duggan@gmail.com>

On 2015-08-19, Benjamin Tissoires <benjamin.tissoires@gmail.com> wrote:
> On Tue, Aug 18, 2015 at 3:06 PM, Benjamin Tissoires
> <benjamin.tissoires@gmail.com> wrote:
[...]
>> On Mon, Aug 17, 2015 at 10:31 PM, Nick Bowler <nbowler@draconx.ca> wrote:
>>> Here is the evtest result from placing two fingers on the touchpad,
>>> then pressing the left trackpoint button 10 times, counting 1 second
>>> between each press.  As you can see, only 3 presses and 3 release
>>> events total were sent by the kernel, sometimes with many physical
>>> button presses between the press and its corresponding release:
>>
>> OK, so this is definitively weird. My first idea would be a firmware
>> problem. I have asked Chandler to reproduce it on his t450 and see if
>> we observe it on our laptops too.
>
> Update on this one : Chandler reproduced it on the t450, so it's
> likely that all of these sensors are affected. It is still unclear if
> it is a firmware bug or a driver problem, but the chances are huge
> that this is a firmware bug. Anyway, that's one more reason to push
> towards RMI4 over SMBus for these sensors: the bug is not present with
> this protocol :)

Well, that sounds fortunate :)

Do you still want the ps2emu-record log?  I didn't have time to run it
yesterday but should be able to do it this evening.

Regards,
  Nick
