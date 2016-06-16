From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH v2] HID: rmi: Make hid-rmi a transport driver for
 synaptics-rmi4
Date: Wed, 15 Jun 2016 17:05:41 -0700
Message-ID: <5761ED55.4090502@synaptics.com>
References: <1464979306-2771-1-git-send-email-aduggan@synaptics.com>
 <alpine.LNX.2.00.1606150923310.6874@cbobk.fhfr.pm>
 <20160615094137.GY24234@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx1.synaptics.com ([192.147.44.131]:38193 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724AbcFPAFn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Jun 2016 20:05:43 -0400
In-Reply-To: <20160615094137.GY24234@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Vincent Huang <vincent.huang@tw.synaptics.com>, Nick Dyer <nick.dyer@itdev.co.uk>

On 06/15/2016 02:41 AM, Benjamin Tissoires wrote:
> On Jun 15 2016 or thereabouts, Jiri Kosina wrote:
>> On Fri, 3 Jun 2016, Andrew Duggan wrote:
>>
>>> The Synaptics RMI4 driver provides support for RMI4 devices. Instead of
>>> duplicating the RMI4 processing code, make hid-rmi a transport driver
>>> and register it with the Synaptics RMI4 core.
>>>
>>> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
>> Is there any update on the Input series please?
> FWIW, I just reviewed it. Now the ball is in Dmitry's hand (I don't
> think it needs a resubmission).

Linus had some suggestions regarding the naming of the device tree 
properties in patch 3. I can either resubmit the series with those 
changes plus what Benjamin identified. Or I can resubmit the patch 3 as 
a standalone patch later so that the rest of the series can be applied. 
I'll do which ever option is less of a burden on the reviewers.

Andrew

> Cheers,
> Benjamin
>
>> Thanks,
>>
>> -- 
>> Jiri Kosina
>> SUSE Labs
>>

