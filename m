From: Frank Praznik <frank.praznik@gmail.com>
Subject: Re: [PATCH v2 2/2] HID: sony: Add output events for the multi-touch
 pad on the Dualshock 4.
Date: Mon, 27 Jan 2014 16:02:31 -0500
Message-ID: <52E6C967.9060704@gmail.com>
References: <1390835857-4523-1-git-send-email-frank.praznik@oh.rr.com>    <1390835857-4523-2-git-send-email-frank.praznik@oh.rr.com> <d3172725c00c3ddcc924d036820b7f5c.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:63665 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754085AbaA0VCj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jan 2014 16:02:39 -0500
Received: by mail-pa0-f54.google.com with SMTP id fa1so6408091pad.13
        for <linux-input@vger.kernel.org>; Mon, 27 Jan 2014 13:02:39 -0800 (PST)
In-Reply-To: <d3172725c00c3ddcc924d036820b7f5c.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org, Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz

On 1/27/2014 15:40, simon@mungewell.org wrote:
>> +	for (n = 0; n < 2; n++) {
>> +		__u16 x, y;
>> +
>> +		x = rd[offset+1] | ((rd[offset+2] & 0xF) << 8);
>> +		y = ((rd[offset+2] & 0xF0) >> 4) | (rd[offset+3] << 4);
>> +
>> +		input_mt_slot(input_dev, n);
>> +		input_mt_report_slot_state(input_dev, MT_TOOL_FINGER,
>> +					!(rd[offset] >> 7));
>> +		input_report_abs(input_dev, ABS_MT_POSITION_X, x);
>> +		input_report_abs(input_dev, ABS_MT_POSITION_Y, y);
>> +
>> +		offset += 4;
>> +	}
> Sorry I have another point/question....
>
> Doesn't this 'spam' the Multitouch interface every incoming report,
> regardless on whether anything has actually change? ie. Should HID-Sony
> track the values, and only send when it detects a change...
>
> Simon
>
No, the HID layer tracks the current state and only sends events when 
something changes so there is no need to shadow it again.  If you watch 
the output in evtest, events are only sent when something changes.  All 
this does is manually parse the touch data for the HID layer.
