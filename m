From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 5/8] Input: olpc_apsp: depend on CONFIG_OF
Date: Wed, 10 Oct 2018 10:18:08 -0700
Message-ID: <20181010171808.GF47260@dtor-ws>
References: <20181010142504.233467-1-lkundrak@v3.sk>
 <20181010142504.233467-6-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181010142504.233467-6-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Stephen Boyd <sboyd@kernel.org>, James Cameron <quozl@laptop.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Oct 10, 2018 at 04:25:01PM +0200, Lubomir Rintel wrote:
> This is a device-tree enabled driver. Moreover CONFIG_OLPC is specific
> to the x86 platform code, while the driver is for an ARM-based laptop.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/input/serio/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
> index d90d9f1098ff..a4f70021b53e 100644
> --- a/drivers/input/serio/Kconfig
> +++ b/drivers/input/serio/Kconfig
> @@ -254,7 +254,7 @@ config SERIO_APBPS2
>  
>  config SERIO_OLPC_APSP
>  	tristate "OLPC AP-SP input support"
> -	depends on OLPC || COMPILE_TEST
> +	depends on OF

I do not see anything in the driver that depends on OF. If OLPC is not
right dependency, then let's drop the whole depends.

Are you going to be submitting DTS files for the platform?

Thanks.

-- 
Dmitry
