From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Adesso SmartCat USB Synaptics touchpad
Date: Wed, 2 Jun 2010 00:29:47 -0700
Message-ID: <20100602072947.GF3713@core.coreip.homeip.net>
References: <1275349728.11045.2.camel@willow.eelf.ddts.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:53754 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056Ab0FBH3x (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Jun 2010 03:29:53 -0400
Received: by pwj2 with SMTP id 2so1565691pwj.19
        for <linux-input@vger.kernel.org>; Wed, 02 Jun 2010 00:29:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1275349728.11045.2.camel@willow.eelf.ddts.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David B Harris <dbharris@eelf.ddts.net>
Cc: linux-input <linux-input@vger.kernel.org>

On Mon, May 31, 2010 at 07:48:48PM -0400, David B Harris wrote:
> Hello again all,
> 
> This time we have an "Adesso Smart Cat USB" touchpad, which is
> unrecognized (I believe) by the kernel.
> 
> Here's the relevant /proc/bus/input/devices entry:
> 
>         I: Bus=0003 Vendor=0488 Product=0022 Version=0100
>         N: Name="Cirque Corporation USB GlidePoint"
>         P: Phys=usb-0000:00:02.1-10.4.2/input0
>         S: Sysfs=/devices/pci0000:00/0000:00:02.1/usb1/1-10/1-10.4/1-10.4.2/1-10.4.2:1.0/input/input6
>         U: Uniq=
>         H: Handlers=mouse2 event6 
>         B: EV=1f
>         B: KEY=70000 0 0 0 0
>         B: REL=103
>         B: ABS=70000000000
>         B: MSC=10
>         
> Can anybody provide some pointers on how to start tracking this down?
> i8032.debug seems to do little.
> 

Right, because it is USB touchpad and not PS/2 one. It might be driver
by an out-of-tree Synaptics USB driver.

*sigh* Yes, I want to merge the driver, I even have hardware to test
(Tejun sent me a device), what I don't have is time to clean it up :(

-- 
Dmitry
