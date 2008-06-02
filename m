From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: RESEND: [PATCH 3/3] Misc: Add HP WMI laptop extras driver
Date: Mon, 2 Jun 2008 16:30:37 -0700
Message-ID: <20080602163037.a7044f68.akpm@linux-foundation.org>
References: <20080528132152.GB32646@srcf.ucam.org>
	<20080528132900.GC32646@srcf.ucam.org>
	<20080529082356.GE16444@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20080529082356.GE16444@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-input@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, carlos@strangeworlds.co.uk
List-Id: linux-input@vger.kernel.org

On Thu, 29 May 2008 09:23:56 +0100
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> This driver adds support for reading and configuring certain information 
> on modern HP laptops with WMI BIOS interfaces. It supports enabling and 
> disabling the ambient light sensor, querying attached displays and hard 
> drive temperature, sending events on docking and querying the state of 
> the dock and toggling the state of the wifi, bluetooth and wwan hardware 
> via rfkill. It also makes the little "(i)" button work on machines that 
> send that via WMI rather than via the keyboard controller.

I should upgrade everyone to checkpatch-0.19...

WARNING: consider using strict_strtoul in preference to simple_strtoul
#300: FILE: drivers/misc/hp-wmi.c:244:
+       u32 tmp = simple_strtoul(buf, NULL, 10);

The reason for this is that simple_strtoul(() will treat "42foo" as
valid input (ie: 42).  Whereas strict_strtoul() will report an error,
which is neater of us.


