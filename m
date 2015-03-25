From: Filip Ayazi <filipayazi@gmail.com>
Subject: Re: [PATCH] input: synaptics: min_max quirk for Thinkpad E440
Date: Wed, 25 Mar 2015 21:33:24 +0100
Message-ID: <55131B94.1090501@gmail.com>
References: <1427246428-7070-1-git-send-email-filipayazi@gmail.com> <CADscph30SsHY-UxzzixGamALzapbwQ9LoR+az8iYm58jpQxwjw@mail.gmail.com> <CAO7PdF_rBe1UjP3wkxhk5xh80GFFsDceGcEmWNod0zNhrQ=HkQ@mail.gmail.com> <20150325172212.GB40952@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:33400 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752511AbbCYUdj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Mar 2015 16:33:39 -0400
In-Reply-To: <20150325172212.GB40952@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ramiro Morales <cramm0@gmail.com>
Cc: linux-kernel@vger.kernel.org, Daniel Martin <consume.noise@gmail.com>, Linux Input <linux-input@vger.kernel.org>

On 03/25/2015 06:22 PM, Dmitry Torokhov wrote:
> On Wed, Mar 25, 2015 at 09:57:51AM -0300, Ramiro Morales wrote:
>> On Wed, Mar 25, 2015 at 6:04 AM, Daniel Martin <consume.noise@gmail.com> wrote:
>>> On 25 March 2015 at 02:20, Filip Ayazi <filipayazi@gmail.com> wrote:
>>>> Sets min_max_quirk values for LEN2006 touchpad found in Lenovo Thinkpad E440
>>>> (board_id=2691).
>>> Dmitry already applied a patch for the E440:
>>>      http://www.spinics.net/lists/linux-input/msg37497.html
>> There are two great things about this second submission from Filip.
>>
>> First, it confirms the values sent by the hardware in a second laptop
>> as reported by touchpad-edge-detector.
>>
>> Second, it reveals I made a stupid mistake transcribing the y_max
>> value to the quirks able. The correct value is 4832 and my patch
>> wrongly contains 4632.
>>
>> I'm very sorry for this. I see my patch has already been pushed to the
>> 'for-linus' branch and I don't know which process should we follow to
>> fix the issue.
> My 'for-linus' branch is stable so we need a fixup on top on the
> incorrect patch, the same way as if it was already in mainline.
I too have noticed the typo in the commit earlier today and have a patch
to apply on top to fix it, which I will sent in another email.

Sincerely,

Filip Ayazi
