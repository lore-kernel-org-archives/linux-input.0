From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] Input: mark expected switch fall-through
Date: Mon, 11 Feb 2019 16:50:36 -0600
Message-ID: <2d9cc622-5ff5-e1cf-bd92-50a1336d16ec@embeddedor.com>
References: <20190211222555.GA5472@embeddedor>
 <20190211224816.GE149505@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190211224816.GE149505@dtor-ws>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
List-Id: linux-input@vger.kernel.org



On 2/11/19 4:48 PM, Dmitry Torokhov wrote:
> On Mon, Feb 11, 2019 at 04:25:55PM -0600, Gustavo A. R. Silva wrote:
>> In preparation to enabling -Wimplicit-fallthrough, mark switch
>> cases where we are expecting to fall through.
>>
>> This patch fixes the following warning:
>>
>> drivers/input/joystick/db9.c: In function ‘db9_saturn_read_packet’:
>> drivers/input/joystick/db9.c:256:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>    if (tmp == 0xff) {
>>       ^
>> drivers/input/joystick/db9.c:263:2: note: here
>>   default:
>>   ^~~~~~~
>>
>> Notice that, in this particular case, the code comment is modified
>> in accordance with what GCC is expecting to find.
>>
>> This patch is part of the ongoing efforts to enable
>> -Wimplicit-fallthrough.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Applied, thank you.
> 

Thanks, Dmitry.

--
Gustavo
