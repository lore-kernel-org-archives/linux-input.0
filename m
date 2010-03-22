From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: i8042: 10 second lag/timeout with no AUX
Date: Sun, 21 Mar 2010 21:39:24 -0700
Message-ID: <20100322043924.GD31621@core.coreip.homeip.net>
References: <20100319103450.56c6e278@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.211.172]:42409 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997Ab0CVEj3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Mar 2010 00:39:29 -0400
Received: by ywh2 with SMTP id 2so1639609ywh.33
        for <linux-input@vger.kernel.org>; Sun, 21 Mar 2010 21:39:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100319103450.56c6e278@destiny.ordissimo>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anisse Astier <anisse@astier.eu>
Cc: linux-input@vger.kernel.org

Hi Anisse,

On Fri, Mar 19, 2010 at 10:34:50AM +0100, Anisse Astier wrote:
> Hi,
> 
> I have a computer that will take a ten second hit at kernel boot if not passed
> the option "i8042.noaux" on kernel cmdline.:
> [    2.460706] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [   12.078279] Failed to disable AUX port, but continuing anyway... Is this a SiS?
> [   12.082637] If AUX port is really absent please use the 'i8042.noaux' option.
> [   23.472591] serio: i8042 KBD port at 0x60,0x64 irq 1
> 
> 
> It does not have any external PS2 port. It's an MSI AE2220.
> Dmi identification gives:
> 	Manufacturer: MICRO-STAR INTERNATIONAL CO., LTD
> 	Product Name: MS-6657
> 
> 
> Is there a way to add a quirk of some sort for this computer? I didn't find
> anything related to i8042.noaux in drivers/input/serio/i8042-x86ia64io.h.
> 

Currently we do not have noaux quirks. Could I get full dmesg with i8042.debug?

-- 
Dmitry
