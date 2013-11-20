From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/31] ARM: tegra: use common reset and DMA bindings
Date: Wed, 20 Nov 2013 16:37:36 +0100
Message-ID: <201311201637.36733.arnd@arndb.de>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, Marc Dietrich <marvin24@gmx.de>, Bjorn Helgaas <bhelgaas@google.com>, linux-i2c@vger.kernel.org, ac100@lists.launchpad.net, devel@driverdev.osuosl.org, Stephen Warren <swarren@nvidia.com>, Mike Turquette <mturquette@linaro.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Alan Stern <stern@rowland.harvard.edu>, linux-serial@vger.kernel.org, linux-input@vger.kernel.org, treding@nvidia.com, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Julian Andres Klode <jak@jak-linux.org>, Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@kernel.org>, linux-tegra@vger.kernel.org, Terje
List-Id: linux-input@vger.kernel.org

On Friday 15 November 2013, Stephen Warren wrote:
> This series implements a common reset framework driver for Tegra, and
> updates all relevant Tegra drivers to use it. It also removes the custom
> DMA bindings and replaced them with the standard DMA DT bindings.

The series is rather long, so I may have missed it, but I think you need one
more patch to the apbdma binding to document the use of #dma-cells, what
value it has, and what the format of the dma specifiers in slave drivers
needs to be.

	Arnd
