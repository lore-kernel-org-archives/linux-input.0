From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH] identify firmware version
Date: Thu, 02 Sep 2010 10:03:24 +0200
Message-ID: <4C7F5A4C.5040700@gmail.com>
References: <20100901020634.GD23585@core.coreip.homeip.net> <1283334517-15121-1-git-send-email-rafi@seas.upenn.edu> <4C7EB3A3.7050402@gmail.com> <4C7EEBEE.5030203@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59015 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098Ab0IBID2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 Sep 2010 04:03:28 -0400
In-Reply-To: <4C7EEBEE.5030203@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: dmitry.torokhov@gmail.com, jkosina@suse.cz, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, micki@n-trig.com, rydberg@euromail.se, chatty@enac.fr

On 09/02/2010 02:12 AM, Rafi Rubin wrote:
> 
> 
> On 09/01/2010 04:12 PM, Jiri Slaby wrote:
>> On 09/01/2010 11:48 AM, Rafi Rubin wrote:
>>> --- a/drivers/hid/hid-ntrig.c
>>> +++ b/drivers/hid/hid-ntrig.c
>>> @@ -90,6 +90,26 @@ struct ntrig_data {
>>>   };
>>>
>>>
>>> +/*
>>> + * This function converts the 4 byte raw firmware code into
>>> + * a string containing 5 comma separated numbers.
>>> + */
>>> +static int ntrig_version_string(unsigned char *raw, char *buf)
>>> +{
>>> +    __u8 a =  (raw[1]&  0b00001110)>>  1;
>>> +    __u8 b =  (raw[0]&  0b00111100)>>  2;
>>> +    __u8 c = ((raw[0]&  0b00000011)<<  3) | ((raw[3]& 
>>> 0b11100000)>>  5);
>>> +    __u8 d = ((raw[3]&  0b00000111)<<  3) | ((raw[2]& 
>>> 0b11100000)>>  5);
>>> +    __u8 e =   raw[2]&  0b00000111;
>>
>> This won't compile with gcc 3.4 which we still support. Maybe time to
>> kill the support?
>>
>> ...
> 
> Why not?

Beacuse it's a gnu extension added in gcc 4.3. (I though it's in gcc 4.0
initially, but it's not. So you cannot use it in the kernel code at all.)

regards,
-- 
js
