From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] usbhid: Check HID report descriptor contents after
 USB device reset
Date: Tue, 3 Apr 2012 15:12:21 -0700 (PDT)
Message-ID: <alpine.LNX.2.00.1204031510040.9041@pobox.suse.cz>
References: <1333465455-17089-1-git-send-email-simon.haggett@realvnc.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59093 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754133Ab2DCWMW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 3 Apr 2012 18:12:22 -0400
In-Reply-To: <1333465455-17089-1-git-send-email-simon.haggett@realvnc.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Haggett <simon.haggett@realvnc.com>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 3 Apr 2012, Simon Haggett wrote:

> When a USB device reset occurs, usbcore will refetch the device and configuration
> descriptors and compare them with those retrieved before the reset to ensure
> that they have not changed. For USB HID devices, this implicitly includes the
> HID class descriptor (as this is fetched with the configuration descriptor).
> However, the HID report descriptor is not checked again.
> 
> Whilst a change in the size of the HID report descriptor will be detected (as
> this is held in the class descriptor), content changes to the report descriptor
> which do not result in a change in its size will be missed. If a firmware update
> were applied to a USB HID device which resulted in such a change to the report
> descriptor after device reset, then this would not be picked up by usbhid.

Simon,

thanks for the patch. Actually the firmware update is not the only option 
how this could happen -- there are HID bus drivers which actually patch 
the report descriptor of the device before it is fed to the parser.

Your patch fixes the issue for those as well.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
