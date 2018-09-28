From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Support for Xbox1 PDP Camo series gamepad
Date: Fri, 28 Sep 2018 16:59:53 -0700
Message-ID: <20180928235953.GB182370@dtor-ws>
References: <20180828054812.14428-1-ramzeto@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180828054812.14428-1-ramzeto@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ramses =?iso-8859-1?Q?Ram=EDrez?= <ramzeto@gmail.com>
Cc: Cameron Gutman <aicommander@gmail.com>, Mark Furneaux <mark@furneaux.ca>, Leo Sperling <leosperling97@gmail.com>, Enno Boland <gottox@voidlinux.eu>, Marcus Folkesson <marcus.folkesson@gmail.com>, Francis Therien <frtherien@gmail.com>, Julia Lawall <Julia.Lawall@lip6.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Aug 28, 2018 at 12:48:11AM -0500, Ramses Ramírez wrote:
> The "Xbox One PDP Wired Controller - Camo series" has a different
> product-id than the regular PDP controller and the PDP stealth series,
> but it uses the same initialization sequence. This patch adds the
> product-id of the camo series to the structures that handle the other
> PDP Xbox One controllers.
> 
> Signed-off-by: Ramses Ramírez <ramzeto@gmail.com>

Applied, thank you.

> ---
>  drivers/input/joystick/xpad.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index cd620e009bad..d4b9db487b16 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -231,6 +231,7 @@ static const struct xpad_device {
>  	{ 0x0e6f, 0x0246, "Rock Candy Gamepad for Xbox One 2015", 0, XTYPE_XBOXONE },
>  	{ 0x0e6f, 0x02ab, "PDP Controller for Xbox One", 0, XTYPE_XBOXONE },
>  	{ 0x0e6f, 0x02a4, "PDP Wired Controller for Xbox One - Stealth Series", 0, XTYPE_XBOXONE },
> +	{ 0x0e6f, 0x02a6, "PDP Wired Controller for Xbox One - Camo Series", 0, XTYPE_XBOXONE },
>  	{ 0x0e6f, 0x0301, "Logic3 Controller", 0, XTYPE_XBOX360 },
>  	{ 0x0e6f, 0x0346, "Rock Candy Gamepad for Xbox One 2016", 0, XTYPE_XBOXONE },
>  	{ 0x0e6f, 0x0401, "Logic3 Controller", 0, XTYPE_XBOX360 },
> @@ -530,6 +531,8 @@ static const struct xboxone_init_packet xboxone_init_packets[] = {
>  	XBOXONE_INIT_PKT(0x0e6f, 0x02ab, xboxone_pdp_init2),
>  	XBOXONE_INIT_PKT(0x0e6f, 0x02a4, xboxone_pdp_init1),
>  	XBOXONE_INIT_PKT(0x0e6f, 0x02a4, xboxone_pdp_init2),
> +	XBOXONE_INIT_PKT(0x0e6f, 0x02a6, xboxone_pdp_init1),
> +	XBOXONE_INIT_PKT(0x0e6f, 0x02a6, xboxone_pdp_init2),
>  	XBOXONE_INIT_PKT(0x24c6, 0x541a, xboxone_rumblebegin_init),
>  	XBOXONE_INIT_PKT(0x24c6, 0x542a, xboxone_rumblebegin_init),
>  	XBOXONE_INIT_PKT(0x24c6, 0x543a, xboxone_rumblebegin_init),
> -- 
> 2.17.1
> 

-- 
Dmitry
