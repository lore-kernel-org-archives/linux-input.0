From: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v9 2/9] Input: goodix - reset device at init
Date: Wed, 14 Oct 2015 14:18:20 +0300
Message-ID: <20151014111820.GV1492@lahna.fi.intel.com>
References: <1444663477-30062-1-git-send-email-irina.tirdea@intel.com>
 <1444663477-30062-3-git-send-email-irina.tirdea@intel.com>
 <20151012164819.GA4010@dtor-ws>
 <1F3AC3675D538145B1661F571FE1805F2F0FE432@irsmsx105.ger.corp.intel.com>
 <20151013070824.GA22304@dtor-ws>
 <1F3AC3675D538145B1661F571FE1805F2F0FE683@irsmsx105.ger.corp.intel.com>
 <20151013100724.GG1492@lahna.fi.intel.com>
 <20151014062303.GC20406@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:15304 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751904AbbJNLUd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Oct 2015 07:20:33 -0400
Content-Disposition: inline
In-Reply-To: <20151014062303.GC20406@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Tirdea, Irina" <irina.tirdea@intel.com>, Bastien Nocera <hadess@hadess.net>, Aleksei Mamlin <mamlinav@gmail.com>, Karsten Merker <merker@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Purdila, Octavian" <octavian.purdila@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Tue, Oct 13, 2015 at 11:23:03PM -0700, Dmitry Torokhov wrote:
> I understand why one might use acpi_dev_add_driver_gpios() to augment
> data in ACPI, however here we have completely different issue: driver
> that expects named gpios gets returned gpio that has nothing to do with
> what it requested, because gpiolib acpi code always falls back to
> unnamed gpio if it does not find named gpio. That can be acceptable if
> driver uses the same con_id for all requests to gpiolib, but is not
> working when driver supplies different con_ids.

Right, the ACPI fallback ignores con_id completely and uses only the
index.

AFAIK there is only one driver using ACPI _CRS index method:
sdhci-[acpi|pci].c. If we can convert that to use acpi_dev_add_driver_gpios()
to feed names for card detection GPIOs, I think we can remove the
fallback alltogether in favor of named GPIOs for ACPI.
