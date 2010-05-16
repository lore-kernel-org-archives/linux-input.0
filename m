From: Robert Schedel <r.schedel@yahoo.de>
Subject: Re: [PATCH 2.6.34-rc7] HID: hid-samsung: add support for Creative
 Desktop Wireless 6000
Date: Sun, 16 May 2010 12:33:41 +0200
Message-ID: <4BEFCA05.8000402@yahoo.de>
References: <4BEF3D1F.6080403@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp128.mail.ukl.yahoo.com ([77.238.184.59]:33697 "HELO
	smtp128.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752593Ab0EPKeJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 16 May 2010 06:34:09 -0400
In-Reply-To: <4BEF3D1F.6080403@yahoo.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dhprince.devel@yahoo.co.uk
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hello,

On 16.05.2010 02:32, Don Prince wrote:
> Add support for the Creative Desktop Wireless 6000 keyboard/mouse
> bundle's multimedia buttons which are not currently handled by
> the default/samsung HID driver.
> 
> Signed-off-by: Don Prince <dhprince-devel@yahoo.co.uk>
> 
> ---
> [...]

As originator of the "old" 0419:0001 IrDA driver parts had a short look at it:
- Merging with old code looks OK. Tested with old 0419:0001 (184) device, still functional.
- 0419:0600 not yet known in usb.ids, might be worth a contribution
- As you merged in a new device, and for explaining why this handling was added, my suggestion is to adapt the existing comments, e.g.:

/*
 * This driver supports several HID devices:
 *
 * [0419:0001] Samsung IrDA remote controller (reports as Cypress USB Mouse).
 *
 * There are several variants:
 *
 * 1. 184 byte report descriptor
[...]
 * [0419:0600] Creative Desktop Wireless 6000 keyboard/mouse combo
 *
 * Several key mappings used from the consumer usage page
 * deviate from the USB HUT 1.12 standard.
 */

Of course some HID maintainer should also review it, for general policy.

Regards,
Robert Schedel
