From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] Input: libps2 - mark expected switch fall-through
Date: Tue, 7 May 2019 16:37:27 -0500
Message-ID: <bad0e811-8554-082d-7f9b-4ecbe62848ec@embeddedor.com>
References: <20190507182409.GA11027@embeddedor>
 <20190507192744.GA248929@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190507192744.GA248929@dtor-ws>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
List-Id: linux-input@vger.kernel.org



On 5/7/19 2:27 PM, Dmitry Torokhov wrote:
> On Tue, May 07, 2019 at 01:24:09PM -0500, Gustavo A. R. Silva wrote:
>> In preparation to enabling -Wimplicit-fallthrough, mark switch
>> cases where we are expecting to fall through.
>>
>> This patch fixes the following warning:
>>
>> drivers/input/serio/libps2.c: In function ‘ps2_handle_ack’:
>> drivers/input/serio/libps2.c:407:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>    if (ps2dev->flags & PS2_FLAG_NAK) {
>>       ^
>> drivers/input/serio/libps2.c:417:2: note: here
>>   case 0x00:
>>   ^~~~
>>
>> Warning level 3 was used: -Wimplicit-fallthrough=3
>>
>> This patch is part of the ongoing efforts to enable
>> -Wimplicit-fallthrough.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Applied, thank you.
> 

Awesome. :)

Thanks, Dmitry.
--
Gustavo
