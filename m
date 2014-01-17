From: Frank Praznik <frank.praznik@gmail.com>
Subject: Re: [PATCH 4/4] HID: sony: Map gyroscopes and accelerometers to axes
Date: Fri, 17 Jan 2014 12:19:21 -0500
Message-ID: <52D96619.7000209@gmail.com>
References: <alpine.DEB.2.10.1401162137400.15779@franz-virtual-machine> <20140117125137.ad402d6be31de52a25fedd4a@studenti.unina.it> <alpine.LNX.2.00.1401171319500.23018@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yh0-f43.google.com ([209.85.213.43]:57170 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752778AbaAQR1f (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jan 2014 12:27:35 -0500
Received: by mail-yh0-f43.google.com with SMTP id z20so74918yhz.2
        for <linux-input@vger.kernel.org>; Fri, 17 Jan 2014 09:27:34 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1401171319500.23018@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Antonio Ospite <ospite@studenti.unina.it>
Cc: Frank Praznik <frank.praznik@oh.rr.com>, linux-input@vger.kernel.org

On 1/17/2014 07:21, Jiri Kosina wrote:
> On Fri, 17 Jan 2014, Antonio Ospite wrote:
>
>>> Use a modified HID descriptor for the Dualshock 4 to assign the gyroscope
>>> sensors and accelerometers to axes.
>>>
>> What about putting the descriptor fixup on hold for now?
>> Jiri, have you already pushed these patches?
>>
>> Once the ABS2 stuff from David Hermann is done then proper mapping
>> following the Gamepad API[1] and the Motion-Tracking API[2] could be
>> added.
>>
>> [1] Documentation/input/gamepad.txt
>> [2] Documentation/input/motion-tracking.txt
>>
>> We could even have the DS3 and DS4 expose the same mapping.
>>
>> Just a suggestion.
> Hi,
>
> yes, I have already pushed it, but we can of course discuss not including
> it into pull for Linus if necessary.
>
> My understanding is that once ABS2 stuff is done, this can just be
> switched to using it in a backwards-compatible way, and the report fixup
> could be dropped, no?
>
The default descriptor doesn't map the accelerometers or gyros to 
anything.  It's just a 'user defined' page that causes the HID system to 
skip over the bytes in the report.  My changes to the descriptor map the 
accelerometers to usage 0x40, 0x41 and 0x42 and the gyroscope values to 
0x43, 0x44 and 0x45.  These are the proper HID usage values for 
accelerometers and gyros according to the HID spec and according to the 
updated motion-tracking.txt this is exactly what they need to be mapped 
to to work with the ABS2 changes.  Unless I'm missing something,  these 
descriptor changes should be forward-compatible.

If I recall, the Dualshock 3 maps it's accelerometers and gyros to the 
same set of usage values as well.
