From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: How do you keep input from a USB Mag card reader from going to
 STDIN?
Date: Tue, 23 Jun 2009 16:22:57 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0906231621230.7457@wotan.suse.de>
References: <6C2434209962DC46B88345CA85C334A240E19D7CE2@Courier.syntech.org> <alpine.LRH.2.00.0906231600510.31685@twin.jikos.cz> <4A40E46D.80303@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:45288 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753323AbZFWOWz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Jun 2009 10:22:55 -0400
In-Reply-To: <4A40E46D.80303@tis.icnet.pl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Mark Butsch <mbutsch@syntech-fuelmaster.com>, "'linux-input@vger.kernel.org'" <linux-input@vger.kernel.org>

On Tue, 23 Jun 2009, Janusz Krzysztofik wrote:

> > You can either unbind HID driver from the device completely, and write your
> > own userspace driver using libusb.
> > Or you can patch the HID driver not to attach this device to inpu subsystem,
> > and only trigger creation of /dev/hidraw (or /dev/hiddev respectively), and
> > write user-space application that will process the HID events from these
> > device nodes, and process them in your application as needed.
> I thouhgt this could be done from userspace without any kernel modification,
> just the way "input-events -g" does it. Am I missing anything?

Calling ioctl(EVIOCGRAB) is of course another possibility, if you are 
perfectly fine with the work HID driver does and don't need any 
modifications there (i.e. no changes in usage parsing, etc).

-- 
Jiri Kosina
SUSE Labs
