From: Dmitriy Geels <dmitriy.geels@gmail.com>
Subject: Re: hid-pidff bug: fails to find all required reports of saitek
	gamepad
Date: Thu, 12 Feb 2009 21:06:37 +0300
Message-ID: <78f5d6bf0902121006r460ba8d6m61126af161358c19@mail.gmail.com>
References: <78f5d6bf0901301145g591a713agc8aafa66fe27b19f@mail.gmail.com>
	 <49871663.4060605@gmail.com>
	 <78f5d6bf0902021029g7e53f16ble27500b52f9498ba@mail.gmail.com>
	 <498D7E81.4060007@gmail.com>
	 <78f5d6bf0902092146x2abaf45an79e4546e75a80356@mail.gmail.com>
	 <4991A622.7020101@gmail.com>
	 <78f5d6bf0902110112o434d43d3ycd473c7b803e8297@mail.gmail.com>
	 <4992FC79.80106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:43444 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbZBLSGj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Feb 2009 13:06:39 -0500
Received: by fg-out-1718.google.com with SMTP id 16so273742fgg.17
        for <linux-input@vger.kernel.org>; Thu, 12 Feb 2009 10:06:37 -0800 (PST)
In-Reply-To: <4992FC79.80106@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: linux-input@vger.kernel.org

2009/2/11 Anssi Hannula <anssi.hannula@gmail.com>:
> Dmitriy Geels wrote:
>> I did that already, you can also see described constant effect report
>> using links, I posted earlier. There is no direction at all. Constant
>> report has only effect block index and magnitude (3 bytes total: id,
>> bi, mag). Device doesn't support direction at all.
>
> (for clarification, I meant here an actual usb traffic dump when you play an
> effect in windows)
Ok, here is usb sniffer report:
http://dmitriy.geels.googlepages.com/HIDtrafficdump.html
Only reports data is raw, everything else decoded.
What is there: I opened control panel applet for game devices, there
is a test page, each effect played after button was pressed. All
effects are periodic. There is pretty much information there.
Here is just constant effect dump:
http://dmitriy.geels.googlepages.com/constanteffectdump.html
I changed magnitude and direction in test program. Changing direction
doesn't send anything to device.

> Constant force makes no sense without a direction. What kind of force effect
> does it actually produce?
Just rumble. There is only one motor inside. For constant effect motor
spins with constant speed, as I understood, this speed is controlled
by magnitude. Also it is a place for report fixup: magnitude logical
values are -127/127, but actually 1/255 -- 255 is strongest.

>> After that, driver almost initializes: http://paste.org.ru/index.pl?008sgm
>> It fails in pidff_check_autocenter(). According to descriptor, effect
>> 1 is constant force. The problem is that block load report receive
>> fails.
>> I have no idea yet, why it fails, need to do some debug.
...
> However, pidff_request_effect_upload should still not fail, as it is needed
> for uploading effects. Try changing the effect type, make it e.g.
> error = pidff_request_effect_upload(pidff, 2);
Actually I tried to comment out check_autocenter() - then driver
initializes successfully. But fftest fails to upload effect with io
error.

> You could also try adding some delays after usbhid_wait_io() calls in
> pidff_request_effect_upload(), with e.g. msleep(200) (you should also lower
> the iterations limit 60 when adding such delays).
I tried this, no result.
I think, this problem is connected somehow to log message about
maxusage and report_count do not match.

> If nothing else helps, I guess we need a dump from windows for this as well.
>
>> Can you tell,
>> is there some way to monitor reports in kernel?
>
> You can set debug=2 for hid module, but it will produce very much output.
I found where to get outgoing data, added 2 dbg_hid() loggers, now
have to find right place for incoming reports.
