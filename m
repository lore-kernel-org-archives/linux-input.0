From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: ThinkPad input device IDs
Date: Wed, 8 Oct 2008 10:44:02 -0300
Message-ID: <20081008134402.GA15645@khazad-dum.debian.net>
References: <41840b750810072144g6e6becfby1c960eb24249869c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:40927 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751284AbYJHNoJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 8 Oct 2008 09:44:09 -0400
Content-Disposition: inline
In-Reply-To: <41840b750810072144g6e6becfby1c960eb24249869c@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shem Multinymous <multinymous@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Wed, 08 Oct 2008, Shem Multinymous wrote:
> We seem to have a bit of a mess in regard to input device
> identification on ThinkPad-specific devices.

Heh :-)

> thinkpad-acpi does essentially the following (Henrique's commit
> 7f5d1cd62 from July 2007, after macro expansion):
> 
>         tpacpi_inputdev->name = "ThinkPad Extra Buttons";
>         tpacpi_inputdev->phys = "thinkpad_acpi/input0";
>         tpacpi_inputdev->id.bustype = BUS_HOST;
>         tpacpi_inputdev->id.vendor = PCI_VENDOR_ID_IBM or PCI_VENDOR_ID_LENOVO;
>         tpacpi_inputdev->id.product = 0x5054 /* "TP" */;
>         tpacpi_inputdev->id.version = 0x4101;
> 
> But mainline hdaps uses a different convention (Dmitry's commit
> d2fc60d692 from May 2008):
> 
>         idev->name = "hdaps";
>         idev->phys = "isa1600/input0";
>         idev->id.bustype = BUS_ISA;

I am not too surprised, mainline HDAPS is a ugly hack with no thought on
design.

HDAPS:

I guess it used "isa1600" because it talks to the EC over LPC3B port IO, and
the ports are in the 1600-161F range, over the LPC bus.  LPC is considered
to be ISA (mostly because it exists to emulate a restricted set of ISA, just
enough to get IRQs, port I/O and mem I/O). That also explains BUS_ISA.

Now, for thinkpad-acpi:

thinkpad-acpi talks to the ACPI interpretor and the ACPI EC (through the
standard Linux ACPI/ACPICA API), which are considered platform devices (thus
BUS_HOST).  In that case, the phys designator is sort of arbitrary.  I used
thinkpad_acpi/input#, and I will keep that constant as if it were an ABI,
even if I break thinkpad_acpi into various modules later.

> More concretely:
> The out-of-tree tp_smapi version of hdaps followed the thinkpad-acpi
> convention so it now conflicts with mainline hdaps. Which should I
> follow?

I think it is better to use the BUS_HOST convention for this, since HDAPS
really is just one of the services on LPC3B even if LPC3B really *is*
BUS_ISA, ports 1600-161F.  Dmitry would know better, though.  Dmitry?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
