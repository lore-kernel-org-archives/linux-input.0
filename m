From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH] hid-ntrig.c Multitouch cleanup and fix
Date: Tue, 09 Mar 2010 17:12:59 -0500
Message-ID: <4B96C7EB.2000801@seas.upenn.edu>
References: <4B75E14A.2050602@seas.upenn.edu> <1266027185-5311-1-git-send-email-rafi@seas.upenn.edu> <4B760D60.6020907@seas.upenn.edu> <alpine.LNX.2.00.1002161349470.30967@pobox.suse.cz> <4B96B740.7020208@euromail.se> <4B96BAF1.5070209@seas.upenn.edu> <alpine.LNX.2.00.1003092218530.17799@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stag.seas.upenn.edu ([158.130.70.79]:46366 "EHLO
	stag.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755397Ab0CIWNL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Mar 2010 17:13:11 -0500
In-Reply-To: <alpine.LNX.2.00.1003092218530.17799@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, chatty@enac.fr

On 03/09/2010 04:19 PM, Jiri Kosina wrote:
> On Tue, 9 Mar 2010, Rafi Rubin wrote:
>
>> Since you're considering protocol clarification, what's your opinion on
>> splitting the multi-touch and single touch (possibly emulated) to
>> separate input devices?
>
> What would be the advantages?

With the N-Trig device it would more closely match the device rdesc.  At 
least for the firmwares I've had a chance to examine.  hid device 
describes 3 input devices: 1. pen, 2. multi touch, 3. single touch.

Depending on the mode, the hardware sends single touch events to either 
the mt report (mt modes) or single touch report.

If mt/st multiplexing is preferred, perhaps it would be better to adjust 
the device naming, and possibly collapse the second and third devices 
into a single device.

Either way, I think it would be more aesthetically pleasing to keep the 
behavior of the input devices as consistent as possible and not having 
events jump from dev to dev based on the direction of the wind.


The only real reason I see to argue in favor of splitting the two 
streams is as a crutch to inadequate user space tools.  So perhaps 
that's not even worth discussing.


So how can I prevent the third input from being allocated without 
eliminating the second?

Rafi
