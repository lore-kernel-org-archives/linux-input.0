From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] usb: Remove Vernier devices from lsusb and
 hid_ignore_list
Date: Thu, 28 May 2015 16:58:54 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1505281657330.13817@pobox.suse.cz>
References: <555DEEFB.50604@eqware.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <555DEEFB.50604@eqware.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dennis O'Brien <dennis.obrien@eqware.net>
Cc: gregkh@linuxfoundation.org, jminor@vernier.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 21 May 2015, Dennis O'Brien wrote:

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

Given that the only thing this patch is in principle doing is dropping 
device support from ldusb driver, I am not applying it before getting Ack 
from Greg (or even seeing Greg merging it himself through his tree).

Greg ... ?

Thanks,

-- 
Jiri Kosina
SUSE Labs
