From: Frank Praznik <frank.praznik@gmail.com>
Subject: Re: [PATCH 2/5] hid: sony: Add support for the Sony Motion Controller
Date: Tue, 05 May 2015 19:28:46 -0400
Message-ID: <5549522E.9010107@gmail.com>
References: <1430793272-11545-1-git-send-email-frank.praznik@oh.rr.com> <1430793272-11545-3-git-send-email-frank.praznik@oh.rr.com> <20150505211640.GA10272@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:33100 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666AbbEEX2z (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 May 2015 19:28:55 -0400
Received: by iecrt8 with SMTP id rt8so2025954iec.0
        for <linux-input@vger.kernel.org>; Tue, 05 May 2015 16:28:54 -0700 (PDT)
In-Reply-To: <20150505211640.GA10272@amd>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz

On 5/5/2015 17:16, Pavel Machek wrote:
> Hi!
>
>> Add a fixed-up HID descriptor for the Sony motion controller and enable
>> controls for the LED light as well as force-feedback.
>>
>> The LED is multi-colored (red, green, blue) and has a 'global' control to
>> allow it to be flashed or switched on an off atomically.
>>
>> The motion controller has a single rumble motor so the higher of the left and
>> right values is used to set the speed.
>>
>> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>> Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
>> ---
>>
>>   Pavel, can you please test this and make sure it works?
> I tried (on 4.1-rc2), and got this (full dmesg in attachment)
>
> Best regards,
> 										Pavel
>
<snip>

Ack, sorry about that mistake.  On the plus side, it uncovered a 
mishandled failure path in the initialization function.  I'll add a 
patch for that in v2 of the series.
