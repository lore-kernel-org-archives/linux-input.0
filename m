From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 00/31] ARM: tegra: use common reset and DMA bindings
Date: Wed, 20 Nov 2013 10:23:50 -0700
Message-ID: <528CF026.5020309@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <201311201637.36733.arnd@arndb.de> <528CE71D.5090300@wwwdotorg.org>
 <201311201803.58393.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <201311201803.58393.arnd@arndb.de>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, Bjorn Helgaas <bhelgaas@google.com>, linux-i2c@vger.kernel.org, ac100@lists.launchpad.net, devel@driverdev.osuosl.org, Stephen Warren <swarren@nvidia.com>, Mike Turquette <mturquette@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, linux-serial@vger.kernel.org, linux-input@vger.kernel.org, treding@nvidia.com, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@kernel.org>, linux-tegra@vger.kernel.org, =?UTF-8?B?VGVyamUgQmVyZ3N0csO2bQ==?= <tbergstrom@nvidia.com>, Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@li
List-Id: linux-input@vger.kernel.org

On 11/20/2013 10:03 AM, Arnd Bergmann wrote:
> On Wednesday 20 November 2013, Stephen Warren wrote:
>>> +- #iommu-cells : Must be <1>. This dictates the length of DMA specifiers in
>>> +  client nodes' dmas properties. The specifier represents the DMA request
>>> +  select value for the peripheral. For more details, consult the Tegra TRM's
>>> +  documentation of the APB DMA channel control register REQ_SEL field.
>>>  
>>>  Examples:
>>>  
>>> @@ -36,4 +40,5 @@ apbdma: dma@6000a000 {
>>>       clocks = <&tegra_car 34>;
>>>       resets = <&tegra_car 34>;
>>>       reset-names = "dma";
>>> +     #iommu-cells = <1>;
> 
> 
> s/iommu/dma/
> 
> Otherwise looks good. The dts files are correct, so I guess it's just
> a typo here.

Thanks, fixed locally.
