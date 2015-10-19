From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: Regression since commit 92bac83
Date: Mon, 19 Oct 2015 19:21:59 +0200
Message-ID: <562526B7.1000701@redhat.com>
References: <5624327B.7080906@lwfinger.net> <5624A503.7090609@redhat.com>
 <56251268.2060203@lwfinger.net> <20151019165128.GB7006@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151019165128.GB7006@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Larry Finger <Larry.Finger@lwfinger.net>
Cc: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Masaki Ota <masaki.ota@jp.alps.com>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi,

On 19-10-15 18:51, Dmitry Torokhov wrote:
> On Mon, Oct 19, 2015 at 10:55:20AM -0500, Larry Finger wrote:
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
>> Thanks for the quick response. Removing the two lines mentioned
>> above restored correct touchpad operation with kernel 4.2.0. It
>> seems that the Latitude D600 is different than other Dell models.
>
> I wonder if we should not revert all these patches splitting what once
> was one relative input device into separate trackstick/external mouse.
> They seem to cause a lot of troubles for little benefit. Pali?

This is unrelated to this splitting, on v2 devices (which we are talking
about here) we always combine all button status, and report the buttons
on the device from which we are actually getting packets atm (only one
sends packets at a time on these specific laptops) and then do some
magic to make sure we send the release on the right device, this all
works well.

The problem is that when using the touchpad (so the touchpad and not
the stick is generating packets) combined with the trackpoint buttons,
the buttons get reported in a different place in the touchpad packet
then when using the touchpad buttons themselves, which is what
commit 92bac83 fixes.

AFAICT we've had the bug which commit 92bac83 fixes since more or less
day 1 of the alps driver, but no one noticed and/or reported the problem
since reproducing the problem is somewhat hard.

Another reason why this problem was likely not noticed until recently
is because it seems it affects only a limited number of models. At first
I thought it would affect all non-interleaved dualpoint v2 devices, then
when we got bug reports of commit 92bac83 causing issues for some non
Dell laptops, I added the DELL flag and limited the fix to only Dell
laptops, and now it seems the separate reporting of the trackpoint buttons
in the touchpad packets only happens on some model Dells.

TL;DR: this is not caused by Pali's patches, if you want to blame anyone
it would be me. In hindsight the fix commit 92bac83 introduces should
have been behind a quirk flag which is only set on specific models.

I will write a patch this week actually changing the fix to use such
a quirk flag.

Regards,

Hans
