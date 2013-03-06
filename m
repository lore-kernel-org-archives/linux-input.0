From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Mar 6 (hid)
Date: Wed, 06 Mar 2013 11:26:01 -0800
Message-ID: <51379849.6040903@infradead.org>
References: <20130306115052.2b1969acb7b7a0fa35975984@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:55100 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753956Ab3CFTZe (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Mar 2013 14:25:34 -0500
In-Reply-To: <20130306115052.2b1969acb7b7a0fa35975984@canb.auug.org.au>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

On 03/05/13 16:50, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20130305:
> 

on i386 and x86_64:

ERROR: "usb_control_msg" [drivers/hid/hid-multitouch.ko] undefined!
ERROR: "usb_ifnum_to_if" [drivers/hid/hid-holtek-kbd.ko] undefined!

when CONFIG_USB_SUPPORT is not enabled.

Should these drivers depend on USB_HID?


-- 
~Randy
