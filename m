From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [RFC][PATCH] Input: support the specified input device number
Date: Tue, 13 Oct 2009 10:50:16 +0900
Message-ID: <9c9fda240910121850t4ec8ee96i7517d6a0f0526ae5@mail.gmail.com>
References: <4ACD4A4B.3080200@samsung.com>
	 <20091009162951.GD1092@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f203.google.com ([209.85.212.203]:39743 "EHLO
	mail-vw0-f203.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbZJMBux (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Oct 2009 21:50:53 -0400
Received: by vws41 with SMTP id 41so5038720vws.4
        for <linux-input@vger.kernel.org>; Mon, 12 Oct 2009 18:50:16 -0700 (PDT)
In-Reply-To: <20091009162951.GD1092@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>, linux-input@vger.kernel.org

Hi,

On Sat, Oct 10, 2009 at 1:29 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Joonyoung,
>
> On Thu, Oct 08, 2009 at 11:11:23AM +0900, Joonyoung Shim wrote:
>> Currently, the input device number is decided by order of driver probe.
>> But we need the specified input device number regardless of order of
>> driver probe because the platform or the middleware tends to access
>> using fixed device node of the input devices.
>>
>> This patch supports to use the specified input device number when the
>> input device is registered. If the input device number bigger than zero
>> is registered before by other input device, returns error.
>>
>
> No, I don't think this is a good solution. You can have persistent
> device nodes without hadrcoding it into the driver. See how UDEV creates
> 'by-id' and 'by-path' links.
>

Please let me know how to use udev at input device.

At our system,
input0: h/w keypad
input1: gpio key
input2: touchscreen
input3: jack or others

but in previous system, we always set the touchscreen as input1. Right
we can modify it but it's not easy.
With this patch we always set touchscreen as input1.

How can we do this?

FYI: when launch the X, we set the tsdevice as input1 and keyboard as input0.

Thank you,
Kyungmin Park
