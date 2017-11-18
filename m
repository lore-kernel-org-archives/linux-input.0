From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 5/10 v2] Input: cpcap-pwrbutton: Handle return value of
 platform_get_irq
Date: Sat, 18 Nov 2017 08:21:22 +0000
Message-ID: <20171118082122.GB31757@n2100.armlinux.org.uk>
References: <ae8e2bcc48ceeb7cf04f4ec19e7cc76d51fcf58f.1510952504.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ae8e2bcc48ceeb7cf04f4ec19e7cc76d51fcf58f.1510952504.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: dmitry.torokhov@gmail.com, maxime.ripard@free-electrons.com, wens@csie.org, linux@roeck-us.net, wsa@the-dreams.de, daniel.thompson@linaro.org, mcuos.com@gmail.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, Nov 18, 2017 at 02:36:53AM +0530, Arvind Yadav wrote:
> platform_get_irq() can fail here and we must check its return value.

The test should be <= 0, and you need to return an error code for the
0 case.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
