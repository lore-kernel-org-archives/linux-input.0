From: Tvrtko Ursulin <tvrtko.ursulin@onelan.co.uk>
Subject: Re: Baantoo multi-touch screen trouble
Date: Fri, 13 Apr 2012 09:02:51 +0100
Message-ID: <201204130902.51885.tvrtko.ursulin@onelan.co.uk>
References: <201204111629.59916.tvrtko.ursulin@onelan.co.uk> <201204121547.29206.tvrtko.ursulin@onelan.co.uk> <CAN+gG=GzVSzQpEV0bFMTn0H_vj+yKHHSZpyL4dBCFTE7To0=-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from claranet-outbound-smtp02.uk.clara.net ([195.8.89.35]:50005 "EHLO
	claranet-outbound-smtp02.uk.clara.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754687Ab2DMIC6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Apr 2012 04:02:58 -0400
In-Reply-To: <CAN+gG=GzVSzQpEV0bFMTn0H_vj+yKHHSZpyL4dBCFTE7To0=-A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On Thursday 12 Apr 2012 17:05:34 Benjamin Tissoires wrote:
> Hi Tvrtko,
> 
> I misread your first mail, sorry for that. I did not saw that your
> device was a Hid one detected as a multitouch one. Under 3.3, just do:
> $ sudo modprobe hid-multitouch
> 
> And the device should be handled by hid-multitouch.
> 
> The 3.3 kernel, detects that your device should be handled by
> hid-multitouch, but it does not load it automatically. You may add
> this module in the configuration file.

Unfortunately nothing interesting happened with hid-multitouch loaded. Nonew 
kernel messages, no devices claimed/created.

Are there any tools (couldn't find any) which can probe/analyze this device 
from userspace? Or something that would explain why it works better with 
earlier kernels?

Tvrtko
