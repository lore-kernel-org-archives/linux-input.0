From: =?UTF-8?B?VGVyamUgQmVyZ3N0csO2bQ==?= <tbergstrom@nvidia.com>
Subject: Re: [PATCH 00/31] ARM: tegra: use common reset and DMA bindings
Date: Mon, 18 Nov 2013 10:24:26 +0200
Message-ID: <5289CEBA.3070502@nvidia.com>
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
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, David Airlie <airlied@linux.ie>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Marc Dietrich <marvin24@gmx.de>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "ac100@lists.launchpad.net" <ac100@lists.launchpad.net>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, Stephen Warren <swarren@nvidia.com>, Alan Stern <stern@rowland.harvard.edu>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Thierry Reding <treding@nvidia.com>, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 15.11.2013 22:53, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> This series implements a common reset framework driver for Tegra, and
> updates all relevant Tegra drivers to use it. It also removes the custom
> DMA bindings and replaced them with the standard DMA DT bindings.
> 
> Historically, the Tegra clock driver has exported a custom API for module
> reset. This series removes that API, and transitions DT and drivers to
> the new reset framework.
> 
> The custom API used a "struct clk" to identify which module to reset, and
> consequently some DT bindings and drivers required clocks to be provided
> where they really needed just a reset identifier instead. Due to this
> known deficiency, I have always considered most Tegra bindings to be
> unstable. This series removes this excuse for instability, although I
> still consider some Tegra bindings unstable due to the need to convert to
> the common DMA bindings.
> 
> Historically, Tegra DMA channels have been represented in DT using a
> custom nvidia,dma-request-selector property. Now that standard DMA DT
> bindings exist, convert all Tegra bindings, DTs, and drivers to use the
> standard instead.
> 
> This series makes a DT-ABI-incompatible change to:
> - Require reset specifiers in DT where relevant.
> - Require standard DMA specifiers.
> - Remove clock specifiers from DT where they were only needed for reset.
> - Remove legacy DMA specifier properties.
> 
> I anticipate merging this whole series into the Tegra and arm-soc trees
> as its own branch, due to internal dependencies. This branch will be
> stable and can then be merged into any other subsystem trees should any
> conflicts arise.
> 
> This series depends on Peter's Tegra clock driver rework, available at
> git://nv-tegra.nvidia.com/user/pdeschrijver/linux tegra-clk-tegra124-0
> (or whatever version of that gets included in 3.14)

Overall, a good change. For host1x part:

Acked-By: Terje Bergstrom <tbergstrom@nvidia.com>

This patch does not change the behavior, but we have in original code
the problem that we don't flush the MC queue when resetting an engine.
This can cause some memory writes to not hit memory. There was an
earlier discussion on that, but we seem to have lost track of the issue.

Terje
