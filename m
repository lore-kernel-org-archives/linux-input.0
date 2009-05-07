From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH] input: add support for generic GPIO-based matrix keypad
Date: Thu, 7 May 2009 14:21:29 +0530
Message-ID: <5d5443650905070151s2cba17ecm1f829e2fdfb0d0c9@mail.gmail.com>
References: <f17812d70905070100u406614cag1ea1ea913577bbd8@mail.gmail.com>
	 <5d5443650905070141k2d6e3cb8r9e923c71c5474e43@mail.gmail.com>
	 <f17812d70905070148s47045998mfcbbe65b0d8d07b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f125.google.com ([209.85.221.125]:51531 "EHLO
	mail-qy0-f125.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752232AbZEGIv3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 May 2009 04:51:29 -0400
Received: by qyk31 with SMTP id 31so1129082qyk.33
        for <linux-input@vger.kernel.org>; Thu, 07 May 2009 01:51:29 -0700 (PDT)
In-Reply-To: <f17812d70905070148s47045998mfcbbe65b0d8d07b0@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Marek Vasut <marek.vasut@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>

Hi Eric,

On Thu, May 7, 2009 at 2:18 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Thu, May 7, 2009 at 4:41 PM, Trilok Soni <soni.trilok@gmail.com> wrote:
>> Hi Eric,
>>
>> On Thu, May 7, 2009 at 1:30 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
>>> Original patch by Marek Vasut, modified by Eric in:
>>>
>>> 1. use delayed work to simplify the debouncing
>>> 2. build keycode array for fast lookup
>>> 3. combine col_polarity/row_polarity into a single active_low field
>>> (are there some cases where the GPIOs are externally connected
>>> with an inverter and thus causing two different polarity requirement??)
>>> 4. use a generic bit array based XOR algorithm to detect key press/release,
>>> which should make the column assertion time shorter and code a bit
>>> cleaner
>>> 5. remove the ALT_FN handling, which is no way generic, the ALT_FN
>>> key should be treated as no different from other keys, and translation
>>> will be done by user space by commands like 'loadkeys'.
>>>
>>> Patch tested on Littleton/PXA310 (though PXA310 has a dedicate keypad
>>> controller, I have to configure those pins as generic GPIO to use this
>>> driver, works quite well, though ;-)
>>
>> Any support about removing/clearing ghost/phantom keys? Also we assume
>> that all gpios in the matrix should be able to generate interrupts so
>> no polldev support required.
>>
>
> Is there some info about such ghost/phantom keys? Otherwise I'll
> assume these are something like sticky control keys?
>
> I'm not sure if there're any such support in console tools and in
> input subsystem. Hard to say...
>
> And the comments below are of great value, I'll incorporate these
> suggestions in later submission. Thanks very much.
>

Could you please have look at following gpio_matrix driver?

gpio_matrix.c:
http://android.git.kernel.org/?p=kernel/msm.git;a=blob;f=drivers/input/misc/gpio_matrix.c;h=c1f47651a4937d5c976a9625ca5da389dd7e4a7c;hb=HEAD

gpio_input.c:
http://android.git.kernel.org/?p=kernel/msm.git;a=blob;f=drivers/input/misc/gpio_input.c;h=7e307f267a2a059b64a3fb9c8a379b149016b2f8;hb=HEAD

-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
