From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v4 11/20] power_supply: Change ownership from driver to core
Date: Thu, 26 Feb 2015 10:30:00 +0100
Message-ID: <1424943000.27971.7.camel@AMDC1943>
References: <1424692061-30624-1-git-send-email-k.kozlowski@samsung.com>
 <1424692061-30624-12-git-send-email-k.kozlowski@samsung.com>
 <20150226004522.GB885@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-reply-to: <20150226004522.GB885@earth>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@googlemail.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Darren Hart <dvhart@infradead.org>, Support Opensource <support.opensource@diasemi.com>, Milo Kim <milo.kim@ti.com>, Julian Andres Klode <jak@jak-linux.org>, Marc Dietrich <marvin24@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, patches@opensource.wolfsonmicro.com, ac100@lists.launchpad.net, linux-tegra@vger.kernel.org, devel@driverdev.osuosl.org, Linus Walleij <linus.walleij@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Lee
List-Id: linux-input@vger.kernel.org

On czw, 2015-02-26 at 01:45 +0100, Sebastian Reichel wrote:
> Hi,
> 
> On Mon, Feb 23, 2015 at 12:47:32PM +0100, Krzysztof Kozlowski wrote:
> > Change the ownership of power_supply structure from each driver
> > implementing the class to the power supply core.
> > 

(...)

> 
> I would like to merge this via the power supply subsystem. Some of
> the files being patched are not under my maintainence, though. It
> would be nice if I get an Acked-By from their maintainers.
> 
> As far as I can see this patch is currently missing feedback from:
> 
> arch/x86/platform/olpc: x86 Maintainers
> drivers/acpi: Rafael J. Wysocki, Len Brown
> drivers/hid: Jiri Kosina
> drivers/platform/x86: Darren Hart

I'll respin with v5 because new power supply driver appeared in your
tree (DA9150 Charger). However this does not affect other subsystems.

Best regards,
Krzysztof
