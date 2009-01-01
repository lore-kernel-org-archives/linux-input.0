From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [Bugme-new] [Bug 12340] New: [regression] USB keyboard no longer recognised
Date: Thu, 1 Jan 2009 14:37:13 +0100
Message-ID: <200901011437.14061.oliver@neukum.org>
References: <bug-12340-10286@http.bugzilla.kernel.org/> <20090101011223.6a10dd66.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:59820 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756000AbZAANev (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 1 Jan 2009 08:34:51 -0500
In-Reply-To: <20090101011223.6a10dd66.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, bugme-daemon@bugzilla.kernel.org, nm127@freemail.hu

Am Donnerstag, 1. Januar 2009 10:12:23 schrieb Andrew Morton:

> > Steps to reproduce:
> > 1. boot kernel with parameters "rw root=/dev/sdb1 log_buf_len=1M init=/bin/
> > bash"
> > 2. modprobe -k uhci_hcd
> > 3. modprobe -k usbhid
> > 
> > Current result in case of 2.6.27: USB keyboard starts to work
> > Current result in case of 2.6.28: USB keyboard does not work
> > 
> 
> Is it input/HID, or USB?

Dmesg shows no errors. Please post /proc/bus/usb/devices of 2.6.28
(usbfs must be mounted)

	Regards
		Oliver

