From: "Shem Multinymous" <multinymous@gmail.com>
Subject: ThinkPad input device IDs
Date: Wed, 8 Oct 2008 00:44:02 -0400
Message-ID: <41840b750810072144g6e6becfby1c960eb24249869c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:30510 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbYJHEoE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Oct 2008 00:44:04 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1999530wah.21
        for <linux-input@vger.kernel.org>; Tue, 07 Oct 2008 21:44:03 -0700 (PDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry and Henrique,

We seem to have a bit of a mess in regard to input device
identification on ThinkPad-specific devices.

thinkpad-acpi does essentially the following (Henrique's commit
7f5d1cd62 from July 2007, after macro expansion):

        tpacpi_inputdev->name = "ThinkPad Extra Buttons";
        tpacpi_inputdev->phys = "thinkpad_acpi/input0";
        tpacpi_inputdev->id.bustype = BUS_HOST;
        tpacpi_inputdev->id.vendor = PCI_VENDOR_ID_IBM or PCI_VENDOR_ID_LENOVO;
        tpacpi_inputdev->id.product = 0x5054 /* "TP" */;
        tpacpi_inputdev->id.version = 0x4101;

But mainline hdaps uses a different convention (Dmitry's commit
d2fc60d692 from May 2008):

        idev->name = "hdaps";
        idev->phys = "isa1600/input0";
        idev->id.bustype = BUS_ISA;

What's the rationale for the different bus and phys convention?
Also, where does the "isa1600" come from, and why BUS_ISA? As far as I
can tell, the input device polls the ThinkPad embedded controller via
the LPC bus interface of the chipset, so no ISA-like bus is involved.

More concretely:
The out-of-tree tp_smapi version of hdaps followed the thinkpad-acpi
convention so it now conflicts with mainline hdaps. Which should I
follow?

  Shem
