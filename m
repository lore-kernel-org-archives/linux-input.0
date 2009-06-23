From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: How do you keep input from a USB Mag card reader from going to
 STDIN?
Date: Tue, 23 Jun 2009 16:19:25 +0200
Message-ID: <4A40E46D.80303@tis.icnet.pl>
References: <6C2434209962DC46B88345CA85C334A240E19D7CE2@Courier.syntech.org> <alpine.LRH.2.00.0906231600510.31685@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:55076 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753442AbZFWOT3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Jun 2009 10:19:29 -0400
In-Reply-To: <alpine.LRH.2.00.0906231600510.31685@twin.jikos.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Mark Butsch <mbutsch@syntech-fuelmaster.com>, "'linux-input@vger.kernel.org'" <linux-input@vger.kernel.org>

Jiri Kosina wrote:
> On Wed, 10 Jun 2009, Mark Butsch wrote:
>> How would I disconnect the "kbd" handler from the mag card reader (and 
>> the mag card reader from the "kbd" handler) or is that the wrong 
>> approach?
> 
> You can either unbind HID driver from the device completely, and write 
> your own userspace driver using libusb.
> 
> Or you can patch the HID driver not to attach this device to inpu 
> subsystem, and only trigger creation of /dev/hidraw (or /dev/hiddev 
> respectively), and write user-space application that will process the HID 
> events from these device nodes, and process them in your application as 
> needed.

I thouhgt this could be done from userspace without any kernel 
modification, just the way "input-events -g" does it. Am I missing anything?

Janusz

