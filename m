From: Mika Westerberg <mika.westerberg@intel.com>
Subject: Re: About Goodix-TS on Bay Trail, and ACPI and interrupts
Date: Wed, 21 Jan 2015 12:09:57 +0200
Message-ID: <20150121100957.GL1850@lahna.fi.intel.com>
References: <20150117010306.7e32b72524e4c0cf8296bbac@ao2.it>
 <20150119153758.GA18115@mail.corp.redhat.com>
 <20150120100548.GG1850@lahna.fi.intel.com>
 <20150120163152.GB23441@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:62126 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753237AbbAUKKC (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Jan 2015 05:10:02 -0500
Content-Disposition: inline
In-Reply-To: <20150120163152.GB23441@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Antonio Ospite <ao2@ao2.it>, linux-input@vger.kernel.org, linux-acpi@vger.kernel.org, Bastien Nocera <hadess@hadess.net>, Mathias Nyman <mathias.nyman@linux.intel.com>

On Tue, Jan 20, 2015 at 11:31:52AM -0500, Benjamin Tissoires wrote:
> > What makes you think it should use the goodix driver?
> 
> The fact that the 3.19-rc4 log says:
> [    2.424370] i2c_hid i2c-GODX0911:01: unexpected HID descriptor bcdVersion (0x0000)
> 
> Which is rather troublesome and shows that we might have received a 0
> answer when requesting the HID descriptor. Then Antonio tried to poke
> the device with the goodix driver and got a better answer from the
> version point of view.

Right, I missed that from the logs.
