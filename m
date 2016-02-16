From: Manuel Reimer <mail+linux-input@m-reimer.de>
Subject: Re: Simple approach to write PS3/PS4 usermode driver?
Date: Tue, 16 Feb 2016 20:45:30 +0100
Message-ID: <56C37C5A.6030303@m-reimer.de>
References: <56C2270E.9080603@m-reimer.de>
 <20160215223436.fc5a3f66f82ee49b161099ea@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:40433 "EHLO mx1.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751478AbcBPTpd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Feb 2016 14:45:33 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.mailbox.org (Postfix) with ESMTPS id 1CD5F40255
	for <linux-input@vger.kernel.org>; Tue, 16 Feb 2016 20:45:32 +0100 (CET)
Received: from smtp1.mailbox.org ([80.241.60.240])
	by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
	with ESMTP id pJoL3lOFdpg2 for <linux-input@vger.kernel.org>;
	Tue, 16 Feb 2016 20:45:31 +0100 (CET)
In-Reply-To: <20160215223436.fc5a3f66f82ee49b161099ea@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

On 02/15/2016 10:34 PM, Antonio Ospite wrote:
> Have you tried loading hid.ko with the ignore_special_drivers=1
> parameter? I guess that will ignore _all_ special drivers tho, even
> mouse and keyboard ones.

Exactly. And so it is not what I planned to do.

> Alan Ott's hidapi[1] is a better alternative to libusb for hid
> devices.

Of course, but just for fun, I'll at least try to use libusb directly. 
There are many examples on the net. I've already collected some code 
snippets to use.

> I reckon a patched kernel is not an option, is it?

The kernel side driver does a great job. It has minor bugs (kernel panic 
when disconnecting controller while in game), but nothing too bad.

My plan is to remap to Xbox gamepad button mapping so games actually 
work with the controller. In fact, I bought a brand new PS4 controller 
just for my driver project. At least so far, I only own the PS3 console.

What I've done so far is to write a daemon which connects to the 
existing event device to get events from there, but this didn't really 
work as games still see the original controller.

That's why my current plan is to connect one layer deeper so the 
original event devices aren't created at all.

My reason for userspace is, that it's easier to debug and for the 
potential end user it is easier to install. I just had too much trouble 
with dkms in the past.

Best regards,

Manuel
