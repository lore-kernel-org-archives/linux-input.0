From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: Regression since commit 92bac83
Date: Tue, 20 Oct 2015 12:33:41 -0500
Message-ID: <56267AF5.6080205@lwfinger.net>
References: <5624327B.7080906@lwfinger.net> <5624A503.7090609@redhat.com>
 <56251268.2060203@lwfinger.net> <562627D9.6020109@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f196.google.com ([209.85.214.196]:34950 "EHLO
	mail-ob0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbbJTRdj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Oct 2015 13:33:39 -0400
In-Reply-To: <562627D9.6020109@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Masaki Ota <masaki.ota@jp.alps.com>
Cc: linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On 10/20/2015 06:39 AM, Hans de Goede wrote:
> Hi,
>
> On 19-10-15 17:55, Larry Finger wrote:
>> On 10/19/2015 03:08 AM, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 19-10-15 01:59, Larry Finger wrote:
>>>> Hi,
>>>>
>>>> I recently upgraded the kernel in a Dell Latitude D600 and found that the
>>>> touchpad clicks failed. The problem was bisected to commit
>>>> 92bac83dd79e60e65c475222e41a992a70434beb ("Input: alps - non interleaved V2
>>>> dualpoint has separate stick button bits"). The laptop has a combination
>>>> touchpad and control stick. For this device, the following values are found:
>>>>
>>>> priv->protoversion is 0x200 (ALPS_PROTO_V2)
>>>> priv->flags is 0x6 (ALPS_DUALPOINT | ALPS_PASS)
>>>>
>>>> As a result, the new code added in this patch is executed, and left, right,
>>>> and middle are updated. Once this code is introduced, a left click causes some
>>>> event as it will wake a sleeping screen, but not select any windows or do
>>>> anything useful.
>>>>
>>>> Please advise on what information would be needed to help debug this problem.
>>>
>>> Can you build a recent upstream kernel from source, and when building it
>>> comment out these lines in drivers/input/mouse/alps.c, around lines 2555 - 2556
>>>
>>>          if (dmi_name_in_vendors("Dell"))
>>>                  priv->flags |= ALPS_DELL;
>>>
>>> That should fix things, if that fixes things we need to rename the flag
>>> and move to a list of dmi-matched models (rather then vendor) where the new
>>> behavior
>>> introduced by the patch causing you problems is actually necessary.
>>>
>>> Step 1 is confirming that not setting the flag fixes things for you,
>>> if you can get back to us confirming that, then I'll whip up a patch
>>> to switch to model matching (which is not ideal, but seems to be
>>> necessary).
>>
>> Thanks for the quick response. Removing the two lines mentioned above restored
>> correct touchpad operation with kernel 4.2.0. It seems that the Latitude D600
>> is different than other Dell models.
>
> Thanks, can you undo the commenting of those 2 lines, apply the attached
> patch, and then build, install and test, and see if this fixes things ?

Hans,

The patch fixes my problem. Hopefully only the D420, D430, D620 and D630 are the 
only models that need the ALPS_STICK_BITS flag.

Thanks again for the prompt attention.

Larry


