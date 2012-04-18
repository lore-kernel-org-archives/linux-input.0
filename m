From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 7/8] ARM: LPC32xx: DTS files for device tree conversion
Date: Wed, 18 Apr 2012 08:36:53 +0000
Message-ID: <201204180836.53268.arnd@arndb.de>
References: <1334682507-15055-1-git-send-email-stigge@antcom.de>
 <1334682507-15055-8-git-send-email-stigge@antcom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1334682507-15055-8-git-send-email-stigge@antcom.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Roland Stigge <stigge@antcom.de>
Cc: devel@driverdev.osuosl.org, srinivas.bakki@nxp.com, linux-usb@vger.kernel.org, broonie@opensource.wolfsonmicro.com, gregkh@linuxfoundation.org, thierry.reding@avionic-design.de, linux-kernel@vger.kernel.org, kevin.wells@nxp.com, marek.vasut@gmail.com, arm@kernel.org, linux-input@vger.kernel.org, axel.lin@gmail.com, dmitry.torokhov@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On Tuesday 17 April 2012, Roland Stigge wrote:
> +	ahb {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "simple-bus";
> +		ranges = <0x20000000 0x20000000 0x30000000>;
> +
> +		slc: flash@20020000 {
> +			compatible = "nxp,nand-slc";
> +			reg = <0x20020000 0x1000>;
> +			status = "disable";
> +		};
> +
> +		mlc: flash@200B0000 {
> +			compatible = "nxp,nand-mlc";
> +			reg = <0x200B0000 0x1000>;
> +			status = "disable";
> +		};

You have the flash chips in here, which seem right, but I would expect
to see the phy3250 file pick this up again and define partitions in
it, at least if there is a well-defined partition layout for that
board.

> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200n81 root=/dev/ram0";
> +	};

I think in general it's better not to list a command line like this,
it should instead get set by the boot loader or using ARM_ATAG_DTB_COMPAT.

	Arnd
