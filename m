From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: hid-pidff bug: fails to find all required reports of saitek
 gamepad
Date: Thu, 12 Feb 2009 20:42:02 +0200
Message-ID: <49946D7A.408@gmail.com>
References: <78f5d6bf0901301145g591a713agc8aafa66fe27b19f@mail.gmail.com>	 <49871663.4060605@gmail.com>	 <78f5d6bf0902021029g7e53f16ble27500b52f9498ba@mail.gmail.com>	 <498D7E81.4060007@gmail.com>	 <78f5d6bf0902092146x2abaf45an79e4546e75a80356@mail.gmail.com>	 <4991A622.7020101@gmail.com>	 <78f5d6bf0902110112o434d43d3ycd473c7b803e8297@mail.gmail.com>	 <4992FC79.80106@gmail.com> <78f5d6bf0902121006r460ba8d6m61126af161358c19@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gw03.mail.saunalahti.fi ([195.197.172.111]:36019 "EHLO
	gw03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759768AbZBLSmM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Feb 2009 13:42:12 -0500
In-Reply-To: <78f5d6bf0902121006r460ba8d6m61126af161358c19@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitriy Geels <dmitriy.geels@gmail.com>
Cc: linux-input@vger.kernel.org

Dmitriy Geels wrote:
> 2009/2/11 Anssi Hannula <anssi.hannula@gmail.com>:
>> Dmitriy Geels wrote:
>>> I did that already, you can also see described constant effect report
>>> using links, I posted earlier. There is no direction at all. Constant
>>> report has only effect block index and magnitude (3 bytes total: id,
>>> bi, mag). Device doesn't support direction at all.
>> (for clarification, I meant here an actual usb traffic dump when you play an
>> effect in windows)
> Ok, here is usb sniffer report:
> http://dmitriy.geels.googlepages.com/HIDtrafficdump.html
> Only reports data is raw, everything else decoded.
> What is there: I opened control panel applet for game devices, there
> is a test page, each effect played after button was pressed. All
> effects are periodic. There is pretty much information there.
> Here is just constant effect dump:
> http://dmitriy.geels.googlepages.com/constanteffectdump.html
> I changed magnitude and direction in test program. Changing direction
> doesn't send anything to device.
> 
>> Constant force makes no sense without a direction. What kind of force effect
>> does it actually produce?
> Just rumble. There is only one motor inside. For constant effect motor
> spins with constant speed, as I understood, this speed is controlled
> by magnitude. Also it is a place for report fixup: magnitude logical
> values are -127/127, but actually 1/255 -- 255 is strongest.

Hmm, so it is just rumble ( = periodic), not constant force. But what do 
the periodic effects do then, if constant is rumble? Normally periodic 
effects represent various types of rumble.

>>> After that, driver almost initializes: http://paste.org.ru/index.pl?008sgm
>>> It fails in pidff_check_autocenter(). According to descriptor, effect
>>> 1 is constant force. The problem is that block load report receive
>>> fails.
>>> I have no idea yet, why it fails, need to do some debug.
> ...
>> However, pidff_request_effect_upload should still not fail, as it is needed
>> for uploading effects. Try changing the effect type, make it e.g.
>> error = pidff_request_effect_upload(pidff, 2);
> Actually I tried to comment out check_autocenter() - then driver
> initializes successfully. But fftest fails to upload effect with io
> error.
> 
>> You could also try adding some delays after usbhid_wait_io() calls in
>> pidff_request_effect_upload(), with e.g. msleep(200) (you should also lower
>> the iterations limit 60 when adding such delays).
> I tried this, no result.
> I think, this problem is connected somehow to log message about
> maxusage and report_count do not match.

It is not related to those. I see two likely reasons:
1) Device needs more initialization; in the dump we see a "Actuators 
Enable" command sent first, and then the vendor report 64 three times 
with various data.
2) Reports 21+22 are transmitted as control transfers in the dump. I'll 
have to check whether we are doing the same.

>> If nothing else helps, I guess we need a dump from windows for this as well.
>>
>>> Can you tell,
>>> is there some way to monitor reports in kernel?
>> You can set debug=2 for hid module, but it will produce very much output.
> I found where to get outgoing data, added 2 dbg_hid() loggers, now
> have to find right place for incoming reports.
> 


-- 
Anssi Hannula

