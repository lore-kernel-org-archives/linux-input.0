From: "Nori, Sekhar" <nsekhar@ti.com>
Subject: RE: [PATCH 2/2] DaVinci: DM365: Add the device_enable for the
 DaVinci	Keyscan
Date: Fri, 13 Nov 2009 23:22:50 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE4C4AC8@dbde02.ent.ti.com>
References: <1258132786-23321-1-git-send-email-miguel.aguilar@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44954 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755215AbZKMRxC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Nov 2009 12:53:02 -0500
In-Reply-To: <1258132786-23321-1-git-send-email-miguel.aguilar@ridgerun.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "miguel.aguilar@ridgerun.com" <miguel.aguilar@ridgerun.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, Narnakaje, Snehaprabh
Cc: "santiago.nunez@ridgerun.com" <santiago.nunez@ridgerun.com>, "todd.fischer@ridgerun.com" <todd.fischer@ridgerun.com>, "clark.becker@ridgerun.com" <clark.becker@ridgerun.com>

On Fri, Nov 13, 2009 at 22:49:46, miguel.aguilar@ridgerun.com wrote:
> From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
>
> Adds the device_enable function to the DaVinci Keyscan platform data
> to setup the PINMUX configuration.
>
> It also removes #ifdef from the DM365 EVM board in order to load it
> properly as a module.
>
> Signed-off-by: Miguel Aguilar <miguel.aguilar@ridgerun.com>
> ---
>  arch/arm/mach-davinci/board-dm365-evm.c |   11 ++++++-----
>  arch/arm/mach-davinci/dm365.c           |    1 -
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
> index 8d23972..5abf89d 100644
> --- a/arch/arm/mach-davinci/board-dm365-evm.c
> +++ b/arch/arm/mach-davinci/board-dm365-evm.c
> @@ -195,7 +195,11 @@ static struct davinci_i2c_platform_data i2c_pdata = {
>       .bus_delay      = 0     /* usec */,
>  };
>
> -#ifdef CONFIG_KEYBOARD_DAVINCI
> +void dm365evm_keyscan_enable(struct device *dev)
> +{
> +     davinci_cfg_reg(DM365_KEYSCAN);

This could probably return a useful error (later)
so, its better to make a provision to propagate
the error.

> +}
> +
>  static unsigned short dm365evm_keymap[] = {
>       KEY_KP2,
>       KEY_LEFT,
> @@ -217,6 +221,7 @@ static unsigned short dm365evm_keymap[] = {
>  };
>
>  static struct davinci_ks_platform_data dm365evm_ks_data = {
> +     .device_enable  = dm365evm_keyscan_enable,

Maybe it's a personal choice, but simply calling it
'init' instead of 'device_enable' should be sufficient.

Thanks,
Sekhar

