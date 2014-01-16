From: simon@mungewell.org
Subject: Re: [PATCH v2 1/3] HID: sony: Add force-feedback support for the
 Dualshock 4
Date: Thu, 16 Jan 2014 16:53:20 -0500
Message-ID: <74eb2439c78f4b67f920988653a4f0b3.squirrel@mungewell.org>
References: <alpine.DEB.2.10.1401111429090.2563@franz-virtual-machine>
    <alpine.LNX.2.00.1401162246320.23018@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:39761 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887AbaAPVxY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Jan 2014 16:53:24 -0500
In-Reply-To: <alpine.LNX.2.00.1401162246320.23018@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Frank Praznik <frank.praznik@oh.rr.com>, linux-input@vger.kernel.org

> On Sat, 11 Jan 2014, Frank Praznik wrote:
>
>> Adds the Dualshock 4 to the HID device list and enables force-feedback.
>>
>> Adds a Dualshock 4 specific worker function since the Dualshock 4 needs
>> a
>> different report than the Sixaxis.
>>
>> The right motor in the Dualshock 4 is variable so the full rumble value
>> is now passed to the worker function and clamped there if necessary.
>>
>> Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
>
> I have now applied the whole series, thanks Frank.

Thanks.

We are seeing problems with the way that DS4 interacts with Bluez (mostly
importantly how the PC and DS4 'pair'), but I believe that the kernel
stuff is OK.

Simon

