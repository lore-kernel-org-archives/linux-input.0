From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 12340] New: [regression] USB keyboard no
 longer recognised
Date: Thu, 1 Jan 2009 01:12:23 -0800
Message-ID: <20090101011223.6a10dd66.akpm@linux-foundation.org>
References: <bug-12340-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55539 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751808AbZAAJMo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 1 Jan 2009 04:12:44 -0500
In-Reply-To: <bug-12340-10286@http.bugzilla.kernel.org/>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-input@vger.kernel.org
Cc: bugme-daemon@bugzilla.kernel.org, nm127@freemail.hu


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Thu,  1 Jan 2009 00:52:59 -0800 (PST) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=12340
> 
>            Summary: [regression] USB keyboard no longer recognised
>            Product: Drivers
>            Version: 2.5
>      KernelVersion: 2.6.28
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: USB
>         AssignedTo: greg@kroah.com
>         ReportedBy: nm127@freemail.hu
> 
> 
> Latest working kernel version: 2.6.27
> Earliest failing kernel version: 2.6.28
> Distribution: 
> Hardware Environment: ASUS Eee PC 901
> Software Environment:
> Problem Description:
> 
> The USB keyboard was recognised an working with kernel 2.6.27 but not working
> with 2.6.28.
> 
> Steps to reproduce:
> 1. boot kernel with parameters "rw root=/dev/sdb1 log_buf_len=1M init=/bin/
> bash"
> 2. modprobe -k uhci_hcd
> 3. modprobe -k usbhid
> 
> Current result in case of 2.6.27: USB keyboard starts to work
> Current result in case of 2.6.28: USB keyboard does not work
> 

Is it input/HID, or USB?
