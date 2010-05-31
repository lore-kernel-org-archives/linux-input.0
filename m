From: David B Harris <dbharris@eelf.ddts.net>
Subject: Adesso SmartCat USB Synaptics touchpad
Date: Mon, 31 May 2010 19:48:48 -0400
Message-ID: <1275349728.11045.2.camel@willow.eelf.ddts.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from defiant.circainformation.com ([64.5.53.35]:53499 "EHLO
	defiant.circainformation.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750930Ab0EaXtA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 31 May 2010 19:49:00 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>

Hello again all,

This time we have an "Adesso Smart Cat USB" touchpad, which is
unrecognized (I believe) by the kernel.

Here's the relevant /proc/bus/input/devices entry:

        I: Bus=0003 Vendor=0488 Product=0022 Version=0100
        N: Name="Cirque Corporation USB GlidePoint"
        P: Phys=usb-0000:00:02.1-10.4.2/input0
        S: Sysfs=/devices/pci0000:00/0000:00:02.1/usb1/1-10/1-10.4/1-10.4.2/1-10.4.2:1.0/input/input6
        U: Uniq=
        H: Handlers=mouse2 event6 
        B: EV=1f
        B: KEY=70000 0 0 0 0
        B: REL=103
        B: ABS=70000000000
        B: MSC=10
        
Can anybody provide some pointers on how to start tracking this down?
i8032.debug seems to do little.

Thanks,

Dave

-- 
     Arguing with an engineer is like wrestling with a pig in mud.
           After a while, you realise the pig is enjoying it.

                   OpenPGP v4 key ID: 4096R/59DDCB9F
    Fingerprint: CC53 F124 35C0 7BC2 58FE  7A3C 157D DFD9 59DD CB9F
                     Retrieve from subkeys.pgp.net

