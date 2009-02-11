From: Dmitriy Geels <dmitriy.geels@gmail.com>
Subject: Re: hid-pidff bug: fails to find all required reports of saitek
	gamepad
Date: Wed, 11 Feb 2009 12:12:05 +0300
Message-ID: <78f5d6bf0902110112o434d43d3ycd473c7b803e8297@mail.gmail.com>
References: <78f5d6bf0901301145g591a713agc8aafa66fe27b19f@mail.gmail.com>
	 <49871663.4060605@gmail.com>
	 <78f5d6bf0902021029g7e53f16ble27500b52f9498ba@mail.gmail.com>
	 <498D7E81.4060007@gmail.com>
	 <78f5d6bf0902092146x2abaf45an79e4546e75a80356@mail.gmail.com>
	 <4991A622.7020101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:29073 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbZBKJMH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Feb 2009 04:12:07 -0500
Received: by nf-out-0910.google.com with SMTP id d21so7817nfb.21
        for <linux-input@vger.kernel.org>; Wed, 11 Feb 2009 01:12:05 -0800 (PST)
In-Reply-To: <4991A622.7020101@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: linux-input@vger.kernel.org

2009/2/10 Anssi Hannula <anssi.hannula@gmail.com>:
>> But, looking into pidff_set_effect_report(), I think, it's possible to
>> add two if's to check if these fields present. And need to make check
>> for these fields optional somehow.
>> These two usages are not fully utilized anyway, gain is always set to
>> it's logical_maximum (actually it's used only in pidff_autocenter())
>> and direction is always set to 1.
>
> Direction enable is set to 1. However, the direction value itself is
> required for the force direction.
>
> I really can't see how the direction could be transmitted, as the Axis
> Enable fields (alternative way of specifying direction) are missing as well.
> Unless you can figure it out with some creative testing, I guess we need a
> usb dump of constant force with a windows driver.
I did that already, you can also see described constant effect report
using links, I posted earlier. There is no direction at all. Constant
report has only effect block index and magnitude (3 bytes total: id,
bi, mag). Device doesn't support direction at all.

> For Effect Type, that can also be made optional in set_effect_report() (it
> has already been sent in the upload request, so it is redundant).
>
>> There is also some problem with pidff_find_special_fields() ("effect
>> lists not found"), i'll add more debug messages and tell about that
>> later.
>
> See above, it is because of the missing Effect Type field.
I found that out already and made this ugly fix:
http://paste.org.ru/index.pl?oer4rl
- make pidff->set_effect_type optional
- make pidff->effect_direction optional
- change call to PIDFF_FIND_FIELDS(set_effect...) to non-strict (this
is bad, I know)
After that, driver almost initializes: http://paste.org.ru/index.pl?008sgm
It fails in pidff_check_autocenter(). According to descriptor, effect
1 is constant force. The problem is that block load report receive
fails.
I have no idea yet, why it fails, need to do some debug. Can you tell,
is there some way to monitor reports in kernel?

And, I think, the main question: Anssi, how do you think, what would
be better way to implement support for Saitek devices: make separate
driver for them (which will be copy if pidff or will contain hardcoded
report info) or make more relaxed specification specification support
(like I did in this fix)?
