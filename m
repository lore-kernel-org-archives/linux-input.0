From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: "soft" USB keyboard and mouse driver
Date: Thu, 23 Apr 2009 11:33:09 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0904231130460.29235@wotan.suse.de>
References: <49ED8857.9010809@manoweb.com> <alpine.LRH.2.00.0904221319520.18261@twin.jikos.cz> <49EF3F62.6020300@manoweb.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38617 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752960AbZDWJdL (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Apr 2009 05:33:11 -0400
In-Reply-To: <49EF3F62.6020300@manoweb.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alessio Sangalli <alesan@manoweb.com>
Cc: linux-input@vger.kernel.org

On Wed, 22 Apr 2009, Alessio Sangalli wrote:

> > Currently there are implementations for USB and Bluetooth which you 
> > can look at.
> Could you point me to a more specific example?

There is a generic HID layer, which implements the HID specification 
(parsin of report descriptor, passing and interpretation of reports, 
interaction with input subsystem, etc), independently on the underlying 
physical protocol being used, in drivers/hid/hid-core.c and 
drivers/hid/hid-input.c

Then, there are the transport-dependent parts of the implementation. For 
USB this is in driver/hid/usbhid/hid-core.c, which contains all the 
USB-specific protocol handling and interaction with HID core.

For Bluetooth, this is in net/bluetooth/hidp/core.c.

-- 
Jiri Kosina
SUSE Labs
