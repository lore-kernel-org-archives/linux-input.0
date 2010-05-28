From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC PATCH] Quickstart Button ACPI driver to serve PNP0C32
	ACPI devices
Date: Fri, 28 May 2010 22:11:56 +0100
Message-ID: <20100528211156.GA3883@srcf.ucam.org>
References: <201005281940.09925.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:38334 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753689Ab0E1VMD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 May 2010 17:12:03 -0400
Content-Disposition: inline
In-Reply-To: <201005281940.09925.trenn@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Angelo Arrifano <miknix@gmail.com>

On Fri, May 28, 2010 at 07:40:09PM +0200, Thomas Renninger wrote:

> The idea of these buttons is that they are undefined from BIOS/kernel
> point of view. Userspace has to map a functionality to them.
> Therefore the idea to modify the input event keycode via sysfs file.
> There should be 2 situations that perfectly are triggered via userspace:

They're logically buttons, so the right mechanism is for them to be 
configured via the standard keymap ioctls. There's already 
infrastructure for setting this via udev - see /lib/udev/keymaps on 
recent systems. That should let you avoid the need to 
unregister/reregister.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
