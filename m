From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] usb: Remove Vernier devices from lsusb and
 hid_ignore_list
Date: Mon, 1 Jun 2015 14:45:02 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1506011444350.16120@pobox.suse.cz>
References: <555DEEFB.50604@eqware.net> <556B34AF.7050000@eqware.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47525 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752330AbbFAMpF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 1 Jun 2015 08:45:05 -0400
In-Reply-To: <556B34AF.7050000@eqware.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dennis O'Brien <dennis.obrien@eqware.net>
Cc: gregkh@linuxfoundation.org, jminor@vernier.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

On Sun, 31 May 2015, Dennis O'Brien wrote:

> From: Dennis O'Brien <dennis.obrien@eqware.net>
> 
> Removes Vernier Software & Technology devices from the ldusb
> driver and the hid_ignore_list table of the usbhid driver in the
> Linux tree.  These devices will now be supported via the hidraw
> driver.
> 
> A user space driver for these devices will be found in the
> Go! Software Development Kit from Vernier at
> http://www.vernier.com/downloads/software-development-kits/go-sdk/.
> These devices are also be supported by the LabQuest2 standalone
> interface shown at http://www.vernier.com/products/interfaces/labq2/
> and the LoggerPro for Linux software shown at
> http://www.vernier.com/downloads/logger-pro-linux/.
> 
> Signed-off-by: Dennis O'Brien <dennis.obrien@eqware.net>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied to hid.git#for-4.2/upstream.

Thanks,

-- 
Jiri Kosina
SUSE Labs
