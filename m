From: xiangfu liu <xiangfu.z@gmail.com>
Subject: Re: how to make KEY_POWER work in terminal system
Date: Sun, 4 Oct 2009 00:42:07 +0800
Message-ID: <bc65a8d50910030942hecf96b2hc06ff18f786a1cc@mail.gmail.com>
References: <bc65a8d50910030813y26138fbet402bdfb3f8321af8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f199.google.com ([209.85.210.199]:48019 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746AbZJCQmq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 3 Oct 2009 12:42:46 -0400
Received: by yxe37 with SMTP id 37so1965635yxe.33
        for <linux-input@vger.kernel.org>; Sat, 03 Oct 2009 09:42:09 -0700 (PDT)
In-Reply-To: <bc65a8d50910030813y26138fbet402bdfb3f8321af8@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

kernel message:
[    1.240000] input: gpio-keys as /devices/platform/gpio-keys/input/input0
[    1.250000] input: matrix-keypad as /devices/platform/matrix-keypad/input/in1

no /dev/event/inputX device
but there is
/sys/devices/platform/gpio-keys/input/input0
the uevent is :
PRODUCT=19/1/1/100
NAME="gpio-keys"
PHYS="gpio-keys/input0"
EV==3
KEY==100000 0 0 0
MODALIAS=input:b0019v0001p0001e0100-e0,1,k74,ramlsfw

from /proc/interrupts
181:         87     GPIO Bank D  Power

when I press the button nothing happen. device not poweroff.

we have a metrix-keypad in out device. all keys work find.
so I try to map the "F1" to KEY_POWER. then I press the "F1" device not pwoeroff

On 10/3/09, xiangfu liu <xiangfu.z@gmail.com> wrote:
> sorry forget the subject. send again
>
> On 10/3/09, xiangfu liu <xiangfu.z@gmail.com> wrote:
>> Hi
>>
>> I try to write gpio-keys driver a POWER button. attach is the patch.
>> but when I press or hold the button. the system not poweroff. do nothing.
>>
>> I have change the KEY_POWER to KEY_A. then I press the button again.
>> the terminal ouptu 'a' , it works. but why KEY_POWER?
>>
>> give me some tips
>>
>> thanks for help
>>
>> Best Regards
>> Xiangfu
>>
>


-- 
Blog: http://www.openmobilefree.net
