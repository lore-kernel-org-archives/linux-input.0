From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: hid-pidff bug: fails to find all required reports of saitek
 gamepad
Date: Tue, 10 Feb 2009 18:06:58 +0200
Message-ID: <4991A622.7020101@gmail.com>
References: <78f5d6bf0901301145g591a713agc8aafa66fe27b19f@mail.gmail.com>	 <49871663.4060605@gmail.com>	 <78f5d6bf0902021029g7e53f16ble27500b52f9498ba@mail.gmail.com>	 <498D7E81.4060007@gmail.com> <78f5d6bf0902092146x2abaf45an79e4546e75a80356@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gw03.mail.saunalahti.fi ([195.197.172.111]:55525 "EHLO
	gw03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753452AbZBJQPG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Feb 2009 11:15:06 -0500
In-Reply-To: <78f5d6bf0902092146x2abaf45an79e4546e75a80356@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitriy Geels <dmitriy.geels@gmail.com>
Cc: linux-input@vger.kernel.org

Dmitriy Geels wrote:
> Thanks Anssi!
> 
> Your patch helped, device is passing pidff_find_reports().
> 
> Now stuck in pidff_find_fields(), with "unknown set_effect report layout".
> Looks like, device doesn't implement PID specs completely, as there is
> no gain and direction usages in set_effect report:
>> The minimal Effect parameter block must contain (Effect) Parameter Block Index, Effect Type, Duration,
>> Sample Period, Gain, Trigger Button, Trigger Repeat Interval, Axis Direction, and Type Specific Block
>> Handle values.

There is also no Sample Period nor Effect Type values.

> But, looking into pidff_set_effect_report(), I think, it's possible to
> add two if's to check if these fields present. And need to make check
> for these fields optional somehow.
> These two usages are not fully utilized anyway, gain is always set to
> it's logical_maximum (actually it's used only in pidff_autocenter())
> and direction is always set to 1.

Direction enable is set to 1. However, the direction value itself is 
required for the force direction.

I really can't see how the direction could be transmitted, as the Axis 
Enable fields (alternative way of specifying direction) are missing as 
well. Unless you can figure it out with some creative testing, I guess 
we need a usb dump of constant force with a windows driver.

For Effect Type, that can also be made optional in set_effect_report() 
(it has already been sent in the upload request, so it is redundant).

> There is also some problem with pidff_find_special_fields() ("effect
> lists not found"), i'll add more debug messages and tell about that
> later.

See above, it is because of the missing Effect Type field.

-- 
Anssi Hannula

