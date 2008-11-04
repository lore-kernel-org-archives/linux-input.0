From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: cleanup of hiddev
Date: Tue, 04 Nov 2008 23:57:02 +0100
Message-ID: <4910D33E.7050006@gmail.com>
References: <200811031731.38055.oliver@neukum.org> <200811041856.47950.oliver@neukum.org> <4910B1E3.8090908@gmail.com> <200811042351.28526.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:40771 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754229AbYKDW5J (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Nov 2008 17:57:09 -0500
In-Reply-To: <200811042351.28526.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Jiri Kosina <jikos@jikos.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org

On 11/04/2008 11:51 PM, Oliver Neukum wrote:
> If you call usb_register_dev() before you set
> hiddev_table[usbhid->intf->minor - HIDDEV_MINOR_BASE]
> this check in hiddev_open() may fail:
> 	if (i >= HIDDEV_MINORS || i < 0 || !hiddev_table[i])
> 		return -ENODEV;

I think, that's the point. You should also get ENODEV if you don't call
usb_register_dev(), create a node for non-existent minor manually and try to
open it. It behaves the same as if there was a lock you suggested...

Ex.:
# grep 137 /proc/devices
# mknod node c 137 0
# cat node
cat: node: No such device or address
