From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: hid-pidff bug: fails to find all required reports of saitek
 gamepad
Date: Wed, 11 Feb 2009 18:27:37 +0200
Message-ID: <4992FC79.80106@gmail.com>
References: <78f5d6bf0901301145g591a713agc8aafa66fe27b19f@mail.gmail.com>	 <49871663.4060605@gmail.com>	 <78f5d6bf0902021029g7e53f16ble27500b52f9498ba@mail.gmail.com>	 <498D7E81.4060007@gmail.com>	 <78f5d6bf0902092146x2abaf45an79e4546e75a80356@mail.gmail.com>	 <4991A622.7020101@gmail.com> <78f5d6bf0902110112o434d43d3ycd473c7b803e8297@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gw03.mail.saunalahti.fi ([195.197.172.111]:33891 "EHLO
	gw03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755926AbZBKQ1s (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Feb 2009 11:27:48 -0500
In-Reply-To: <78f5d6bf0902110112o434d43d3ycd473c7b803e8297@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitriy Geels <dmitriy.geels@gmail.com>
Cc: linux-input@vger.kernel.org

Dmitriy Geels wrote:
> 2009/2/10 Anssi Hannula <anssi.hannula@gmail.com>:
>>> But, looking into pidff_set_effect_report(), I think, it's possible to
>>> add two if's to check if these fields present. And need to make check
>>> for these fields optional somehow.
>>> These two usages are not fully utilized anyway, gain is always set to
>>> it's logical_maximum (actually it's used only in pidff_autocenter())
>>> and direction is always set to 1.
>> Direction enable is set to 1. However, the direction value itself is
>> required for the force direction.
>>
>> I really can't see how the direction could be transmitted, as the Axis
>> Enable fields (alternative way of specifying direction) are missing as well.
>> Unless you can figure it out with some creative testing, I guess we need a
>> usb dump of constant force with a windows driver.
> I did that already, you can also see described constant effect report
> using links, I posted earlier. There is no direction at all. Constant
> report has only effect block index and magnitude (3 bytes total: id,
> bi, mag). Device doesn't support direction at all.

(for clarification, I meant here an actual usb traffic dump when you 
play an effect in windows)

Constant force makes no sense without a direction. What kind of force 
effect does it actually produce?

>> For Effect Type, that can also be made optional in set_effect_report() (it
>> has already been sent in the upload request, so it is redundant).
>>
>>> There is also some problem with pidff_find_special_fields() ("effect
>>> lists not found"), i'll add more debug messages and tell about that
>>> later.
>> See above, it is because of the missing Effect Type field.
> I found that out already and made this ugly fix:
> http://paste.org.ru/index.pl?oer4rl
> - make pidff->set_effect_type optional
> - make pidff->effect_direction optional
> - change call to PIDFF_FIND_FIELDS(set_effect...) to non-strict (this
> is bad, I know)
> After that, driver almost initializes: http://paste.org.ru/index.pl?008sgm
> It fails in pidff_check_autocenter(). According to descriptor, effect
> 1 is constant force. The problem is that block load report receive
> fails.
> I have no idea yet, why it fails, need to do some debug.

Well, actually pidff_check_autocenter should check for support of Spring 
effect, and skip tests if it is not supported (your device doesn't 
support it, which suggests that the autocenter is managed in a different 
way; windows dump would help finding this out as well).

However, pidff_request_effect_upload should still not fail, as it is 
needed for uploading effects. Try changing the effect type, make it e.g.
error = pidff_request_effect_upload(pidff, 2);

You could also try adding some delays after usbhid_wait_io() calls in 
pidff_request_effect_upload(), with e.g. msleep(200) (you should also 
lower the iterations limit 60 when adding such delays).

If nothing else helps, I guess we need a dump from windows for this as well.

> Can you tell,
> is there some way to monitor reports in kernel?

You can set debug=2 for hid module, but it will produce very much output.

> And, I think, the main question: Anssi, how do you think, what would
> be better way to implement support for Saitek devices: make separate
> driver for them (which will be copy if pidff or will contain hardcoded
> report info) or make more relaxed specification specification support
> (like I did in this fix)?

I prefer the relaxed support.

FYI, I may be unavailable until next Tuesday.

-- 
Anssi Hannula

