From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v8 0/9] Goodix touchscreen enhancements
Date: Fri, 09 Oct 2015 13:54:50 +0200
Message-ID: <5056173.1qyR0F9zS3@wuerfel>
References: <1444314231-19206-1-git-send-email-irina.tirdea@intel.com> <53318623.Pp8rvnEWr4@wuerfel> <1F3AC3675D538145B1661F571FE1805F2F0FB74F@irsmsx105.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:56108 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbbJILy7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Oct 2015 07:54:59 -0400
In-Reply-To: <1F3AC3675D538145B1661F571FE1805F2F0FB74F@irsmsx105.ger.corp.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Tirdea, Irina" <irina.tirdea@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Aleksei Mamlin <mamlinav@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Purdila, Octavian" <octavian.purdila@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Friday 09 October 2015 11:02:01 Tirdea, Irina wrote:
> > -----Original Message-----
> > From: linux-input-owner@vger.kernel.org [mailto:linux-input-owner@vger.kernel.org] On Behalf Of Arnd Bergmann
> > Sent: 08 October, 2015 17:32
> > To: Tirdea, Irina
> > Cc: Dmitry Torokhov; Bastien Nocera; Aleksei Mamlin; linux-input@vger.kernel.org; Mark Rutland; Purdila, Octavian; linux-
> > kernel@vger.kernel.org; devicetree@vger.kernel.org
> > Subject: Re: [PATCH v8 0/9] Goodix touchscreen enhancements
> > 
> > On Thursday 08 October 2015 17:23:42 Irina Tirdea wrote:
> > > Add several enhancements to the Goodix touchscreen driver.
> > >
> > > The new functionality is only available for devices that
> > > declare named gpio pins for interrupt and reset in their
> > > ACPI/DT configuration.
> > >
> > > Thanks,
> > > Irina
> > >
> > > Changes in v8:
> > >  - only allow new functionality for devices that declare named
> > > gpios (using _DSD properties in ACPI or named DT properties)
> > >
> > >
> > 
> > Looks much cleaner this way, thanks!
> > 
> > One remaining question: how would you handle the case where
> > the hardware doesn't support configuring the int-gpios line
> > as output but you still want to use the named gpios?
> > 
> 
> The only reason to use named gpios is to enable the new functionality
> introduced by this patch set (mainly reset and power management).
> You cannot use only one gpio either (e.g. only reset gpio but not the
> interrupt gpio), you need both for this functionality to work.
> 
> If the hardware does not support using the interrupt gpio pin as output,
> it should not declare the named int-gpio pin in ACPI. It is true that
> we might later run into platforms that declare the int-gpio pin even if it
> does not actually work (just like we now have the indexed gpio pins).
> I could have added an additional property for this as you first suggested,
> but if we can modify the ACPI to add it, we could simply remove the
> named interrupt pin instead (that does not work anyway).

Ok, got it. Thanks,

	Arnd
