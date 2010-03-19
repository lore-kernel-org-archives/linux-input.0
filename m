From: Anisse Astier <anisse@astier.eu>
Subject: i8042: 10 second lag/timeout with no AUX
Date: Fri, 19 Mar 2010 10:34:50 +0100
Message-ID: <20100319103450.56c6e278@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f196.google.com ([209.85.223.196]:40575 "EHLO
	mail-iw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855Ab0CSJfg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Mar 2010 05:35:36 -0400
Received: by iwn34 with SMTP id 34so2550608iwn.15
        for <linux-input@vger.kernel.org>; Fri, 19 Mar 2010 02:35:36 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi,

I have a computer that will take a ten second hit at kernel boot if not passed
the option "i8042.noaux" on kernel cmdline.:
[    2.460706] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   12.078279] Failed to disable AUX port, but continuing anyway... Is this a SiS?
[   12.082637] If AUX port is really absent please use the 'i8042.noaux' option.
[   23.472591] serio: i8042 KBD port at 0x60,0x64 irq 1


It does not have any external PS2 port. It's an MSI AE2220.
Dmi identification gives:
	Manufacturer: MICRO-STAR INTERNATIONAL CO., LTD
	Product Name: MS-6657


Is there a way to add a quirk of some sort for this computer? I didn't find
anything related to i8042.noaux in drivers/input/serio/i8042-x86ia64io.h.


Regards,

Anisse
