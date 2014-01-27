From: Frank Praznik <frank.praznik@gmail.com>
Subject: Re: [PATCH v2 2/2] HID: sony: Add output events for the multi-touch
 pad on the Dualshock 4.
Date: Mon, 27 Jan 2014 16:28:06 -0500
Message-ID: <52E6CF66.7090102@gmail.com>
References: <1390835857-4523-1-git-send-email-frank.praznik@oh.rr.com>    <1390835857-4523-2-git-send-email-frank.praznik@oh.rr.com> <ddf2398947f6323430699b45bc509091.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:43649 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753926AbaA0V2P (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jan 2014 16:28:15 -0500
Received: by mail-pb0-f47.google.com with SMTP id rp16so6343212pbb.6
        for <linux-input@vger.kernel.org>; Mon, 27 Jan 2014 13:28:15 -0800 (PST)
In-Reply-To: <ddf2398947f6323430699b45bc509091.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org, Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz

On 1/27/2014 12:47, simon@mungewell.org wrote:
>> +
>> +	/* The Dualshock 4 multi-touch trackpad data starts at offset 35 on USB.
>> +	 * The first 7 bits of the first byte is a counter and bit 8 is a touch
>> +	 * indicator that is 0 when pressed and 1 when not pressed.
>> +	 * The next 3 bytes are two 12 bit touch coordinates, X and Y.
>> +	 * The data for the second touch is in the same format and immediatly
>> +	 * follows the data for the first.
>> +	 */
> Hi Frank,
> I don't know if it helps multitouch, but there is a second set of data in
> the HID stream, that is present when a figure is moving/swiping on the
> touchpad. This gives us a 'vector' rather than a 'point'.
>
> I previously attempted to describe the format here:
> http://www.spinics.net/lists/linux-input/msg28525.html
>
> Ahead of the 'event counter' is a 'point or vector' byte and what might be
> a 'pressure' measurement (couldn't really tell).
>
> Interspersed with the data you mention is a second set of X1/Y1/X2/Y2
> containing the starting position of the swipe/vector. These are
> differentiated with '02' (rather than '01') in the 34'th byte.
>
> Simon.
>
All the device driver is concerned with is the sending the 'raw' touch 
points to the HID layer (ie. point 1/2 is up/down at position X and Y).  
The HID layer then tracks the IDs for each contact point and sends the 
appropriate events to the user application.  It's then up to the 
application software to track and interpret it.

See this document for information on the multi-touch protocol:
https://www.kernel.org/doc/Documentation/input/multi-touch-protocol.txt
