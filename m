From: Mark Lord <lkml@rtr.ca>
Subject: Re: Input driver for Twinhan USB 6253:0100 remote control
Date: Wed, 15 Apr 2009 10:10:31 -0400
Message-ID: <49E5EAD7.7000309@rtr.ca>
References: <20090408072935.GA27920@dtor-d630.eng.vmware.com> <200904131931.24009.dmitry.torokhov@gmail.com> <49E4B678.9030508@rtr.ca> <200904140945.14652.dmitry.torokhov@gmail.com> <49E4C9CF.5060504@rtr.ca> <alpine.LNX.2.00.0904151022170.13028@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:55178 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752366AbZDOOKe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Apr 2009 10:10:34 -0400
In-Reply-To: <alpine.LNX.2.00.0904151022170.13028@wotan.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Jiri Kosina wrote:
> On Tue, 14 Apr 2009, Mark Lord wrote:
> 
>>> I think if you take drivers/hid/hid-belkin.c as a template the 
>>> conversion will take you no time.
>> Okay, I can have a look at that one.  Thanks.
> 
> Yes, hid-belking is a good example of trivial driver that sits on a HID 
> bus for you, as it utilizes the ->input_mapping() callback, which is 
> probably the only callback from HID core you'd need.
..

Actually, the input-mapping() alone won't do the job here.

This Twinhan remote control sends single-byte codes for most buttons,
but some buttons send multi-byte codes, and we have to discard the
extraneous bytes somehow.

Cheers
