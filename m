From: "Tirdea, Irina" <irina.tirdea@intel.com>
Subject: RE: [PATCH v2 0/8]  Goodix touchscreen enhancements
Date: Tue, 23 Jun 2015 13:18:12 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F061614@irsmsx105.ger.corp.intel.com>
References: <1433774273-23103-1-git-send-email-irina.tirdea@intel.com>
 <20150609181706.GL6338@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:18753 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754053AbbFWNSP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Jun 2015 09:18:15 -0400
In-Reply-To: <20150609181706.GL6338@dtor-ws>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>
Cc: Mark Rutland <mark.rutland@arm.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>



> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: 09 June, 2015 21:17
> To: Tirdea, Irina
> Cc: Bastien Nocera; Mark Rutland; linux-input@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Rob
> Herring; Pawel Moll; Ian Campbell; Kumar Gala
> Subject: Re: [PATCH v2 0/8] Goodix touchscreen enhancements
> 
> On Mon, Jun 08, 2015 at 05:37:45PM +0300, Irina Tirdea wrote:
> > Add several enhancements to the Goodix touchscreen driver:
> >  - write configuration data to the device
> >  - power management support
> >  - cleanup and refactoring
> >
> > I have kept the original patch for ESD ("input: goodix: add support
> > for ESD") since it is still under discussion. I have moved it to the
> > end of the patch set so it does not block the other changes. Once I have
> > an answer from DT folks on this I will make the necessary changes for it.
> >
> > For testing the ACPI changes "ACPI: Translate Linux IRQ number directly
> > from GpioInt" patchset is needed [1]. This patchset has been merged in
> > the GPIO tree.
> >
> > This patches are based on Goodix datasheets for GT911 and GT9271 and
> > on Goodix driver gt9xx.c for Android (publicly available in Android kernel
> > trees for various devices). Commit 771d8f1b178e ("Input: goodix - add
> > device tree support") references a set of public datasheets that can
> > be used for reference.
> >
> > [1] https://lkml.org/lkml/2015/5/6/281
> >
> > Changes in v2:
> >  - use request_firmware instead of ACPI/DT property for config
> >  - dropped "input: goodix: add ACPI IDs for GT911 and GT9271" patch
> >  - add ACPI DSDT excerpt in commit message where necessary
> >  - add comments for suspend/resume sleep values
> >  - dropped the checkpatch fixes that did not make sense
> >  - added Bastien's ack to the first patch
> >
> > Irina Tirdea (8):
> >   input: goodix: fix alignment issues
> >   input: goodix: fix variable length array warning
> >   input: goodix: export id and version read from device
> 
> Applied first 3.
> 
> Thanks.
> 

Thanks Dmitry and Bastien for taking a look at the patches!
Sorry for the delay  - I have been on vacation for the last 2 weeks.
I am back in the office now so I will quickly address the issues for the remaining patches.

Thanks,
Irina

> >   input: goodix: reset device at init
> >   input: goodix: write configuration data to device
> >   input: goodix: add power management support
> >   input: goodix: use goodix_i2c_write_u8 instead of i2c_master_send
> >   input: goodix: add support for ESD
> >
> >  .../bindings/input/touchscreen/goodix.txt          |  12 +
> >  drivers/input/touchscreen/goodix.c                 | 467 +++++++++++++++++++--
> >  2 files changed, 449 insertions(+), 30 deletions(-)
> >
> > --
> > 1.9.1
> >
> 
> --
> Dmitry
