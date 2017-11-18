From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 00/10] Handle platform_get_irq's error checking and returns
Date: Sat, 18 Nov 2017 08:18:59 +0000
Message-ID: <20171118081859.GV31757@n2100.armlinux.org.uk>
References: <1510946132-13554-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1510946132-13554-1-git-send-email-arvind.yadav.cs@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: daniel.thompson@linaro.org, mcuos.com@gmail.com, wsa@the-dreams.de, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, wens@csie.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, maxime.ripard@free-electrons.com, linux@roeck-us.net
List-Id: linux-input@vger.kernel.org

On Sat, Nov 18, 2017 at 12:45:22AM +0530, Arvind Yadav wrote:
> The platform_get_irq() function returns negative if an error occurs.
> zero or positive number on success. platform_get_irq() error checking
> for zero is not correct and we must check its return value.

IRQ 0 is not a valid interrupt.  The correct test here is <= 0.
Please rework your patches for this.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
