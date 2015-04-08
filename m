From: Hans de Bruin <jmdebruin@xmsnet.nl>
Subject: Re: 4.0.0-rc mouse/keyboard events get stuck
Date: Wed, 08 Apr 2015 21:07:53 +0200
Message-ID: <55257C89.3090309@xmsnet.nl>
References: <5522D2EF.9070505@xmsnet.nl> <CAKdAkRRao8aXYABV0M-KrqPuzrJG_7M2Qq+6hJQoqe7Q32USKg@mail.gmail.com> <55250A0B.6060608@xmsnet.nl> <5525519C.6070304@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-2.concepts.nl ([213.197.30.125]:49777 "EHLO
	smtp-2.concepts.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921AbbDHTH7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Apr 2015 15:07:59 -0400
In-Reply-To: <5525519C.6070304@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org >> Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>, =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>

On 04/08/2015 06:04 PM, Hans de Goede wrote:
> Hi,
>
> On 08-04-15 12:59, Hans de Bruin wrote:
>> On 04/06/2015 11:23 PM, Dmitry Torokhov wrote:
>>> Hi Hans,
>>>
>>> On Mon, Apr 6, 2015 at 11:39 AM, Hans de Bruin <jmdebruin@xmsnet.nl>
>>> wrote:
>>>> Since 4.0.0-rc something mu laptop has some mouse /keyboard problems.
...

>  >
>> Now something to distract you from the issue, something almost
>> completely different. Something which is also present in 3.18 and
>> probably before. Firefox and other programs have scrollbars on the
>> right side. One can click on it, move the slider and release the
>> button. Except with the combination tp and ts-l, It does not work. Al
>> other combinations do.
>
> Attached is a patch which fixes this for me on my d620, please test
> both patches.
>

The patch fixes the bug on my laptop. I have seen no side effects.

-- 
Hans

