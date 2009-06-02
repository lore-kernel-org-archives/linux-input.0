From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 13411] New: Barscanner (USB HID Keyboard)
 stopped functioning in kernels >= 2.6.28
Date: Mon, 1 Jun 2009 20:25:09 -0700
Message-ID: <20090601202509.87f57ef9.akpm@linux-foundation.org>
References: <bug-13411-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38546 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753714AbZFBD01 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 1 Jun 2009 23:26:27 -0400
In-Reply-To: <bug-13411-10286@http.bugzilla.kernel.org/>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-usb@vger.kernel.org
Cc: bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org, bugzilla.kernel.org@starbase12.cjb.net


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Sun, 31 May 2009 12:21:58 GMT bugzilla-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=13411
> 
>            Summary: Barscanner (USB HID Keyboard) stopped functioning in
>                     kernels >= 2.6.28
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: >= 2.6.28
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Input Devices
>         AssignedTo: drivers_input-devices@kernel-bugs.osdl.org
>         ReportedBy: bugzilla.kernel.org@starbase12.cjb.net
>         Regression: Yes

Does anyone want to claim this regression?  USB, HID or Input??

Thanks.

> 
> Created an attachment (id=21656)
>  --> (http://bugzilla.kernel.org/attachment.cgi?id=21656)
> Additional information (lsusb, lspci, ioports, iomem, kernel configs)
> 
> My K__nig CMP-BARSCAN 10 (being reported as ID 1130:0001 Tenx Technology, Inc.)
> stopped working in kernels upwards from 2.6.28. I'm running a Gentoo 64-bits
> system. 
> 
> The device is still being detected, however, no input-node is being created.
> Dmesg reports (under a 2.6.28 kernel):
> 
> usb 6-2: new low speed USB device using uhci_hcd and address 2
> usb 6-2: configuration #1 chosen from 1 choice
> usb 6-2: New USB device found, idVendor=1130, idProduct=0001
> usb 6-2: New USB device strings: Mfr=0, Product=2, SerialNumber=0
> usb 62: Product: USB-TMU
> 
> 
> Under 2.6.27.24 it does work as expected. Dmesg reports:
> 
> usb 6-2: new low speed USB device using uhci_hcd and address 2
> usb 6-2: configuration #1 chosen from 1 choice
> input: USB-TMU as /class/input/input6
> input: USB HID v1.10 Keyboard [USB-TMU] on usb-0000:00:1d.0-2
> usb 6-2: New USB device found, idVendor=1130, idProduct=0001
> usb 6-2: New USB device strings: Mfr=0, Product=2, SerialNumber=0
> usb 6-2: Product: USB-TMU
> 
> 
> Trying several kernels, I can conclude the following:
> 
> 2.6.25-Gentoo-r9     --> Works
> 2.6.27-Gentoo-r8     --> Works
> 2.6.28-Gentoo-r5     --> Broken
> 
> 2.6.27.10 (Vanilla)  --> Works
> 2.6.27.24 (Vanilla)  --> Works
> 2.6.28 (Vanilla)     --> Broken
> 2.6.28.9 (Vanilla)   --> Broken
> 2.6.29.4 (Vanilla)   --> Broken
> 2.6.30 RC7 (Vanilla) --> Broken
> 
> 
> Additional information is attached in the attached text file, containing:
> * lsusb -vv output
> * Kernel 2.6.27 configuration
> * Kernel 2.6.29 configuration
> * /proc/ioports
> * /proc/iomem
> * lspci -vvv


