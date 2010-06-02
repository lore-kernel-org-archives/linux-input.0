From: David B Harris <dbharris@eelf.ddts.net>
Subject: Re: Adesso SmartCat USB Synaptics touchpad
Date: Wed, 02 Jun 2010 16:06:42 -0400
Message-ID: <1275509202.32129.0.camel@willow.eelf.ddts.net>
References: <1275349728.11045.2.camel@willow.eelf.ddts.net>
	 <20100602072947.GF3713@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from defiant.circainformation.com ([64.5.53.35]:34520 "EHLO
	defiant.circainformation.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933039Ab0FBUGp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 2 Jun 2010 16:06:45 -0400
In-Reply-To: <20100602072947.GF3713@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

Hey, thanks for the response. I was concerned that that was the problem.


On Wed, 2010-06-02 at 00:29 -0700, Dmitry Torokhov wrote:
> On Mon, May 31, 2010 at 07:48:48PM -0400, David B Harris wrote:
> > Hello again all,
> > 
> > This time we have an "Adesso Smart Cat USB" touchpad, which is
> > unrecognized (I believe) by the kernel.
> > 
> > Here's the relevant /proc/bus/input/devices entry:
> > 
> >         I: Bus=0003 Vendor=0488 Product=0022 Version=0100
> >         N: Name="Cirque Corporation USB GlidePoint"
> >         P: Phys=usb-0000:00:02.1-10.4.2/input0
> >         S: Sysfs=/devices/pci0000:00/0000:00:02.1/usb1/1-10/1-10.4/1-10.4.2/1-10.4.2:1.0/input/input6
> >         U: Uniq=
> >         H: Handlers=mouse2 event6 
> >         B: EV=1f
> >         B: KEY=70000 0 0 0 0
> >         B: REL=103
> >         B: ABS=70000000000
> >         B: MSC=10
> >         
> > Can anybody provide some pointers on how to start tracking this down?
> > i8032.debug seems to do little.
> > 
> 
> Right, because it is USB touchpad and not PS/2 one. It might be driver
> by an out-of-tree Synaptics USB driver.
> 
> *sigh* Yes, I want to merge the driver, I even have hardware to test
> (Tejun sent me a device), what I don't have is time to clean it up :(
> 

-- 
     Arguing with an engineer is like wrestling with a pig in mud.
           After a while, you realise the pig is enjoying it.

                   OpenPGP v4 key ID: 4096R/59DDCB9F
    Fingerprint: CC53 F124 35C0 7BC2 58FE  7A3C 157D DFD9 59DD CB9F
                     Retrieve from subkeys.pgp.net

