From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH] Input: keyboard - add device tree bindings for simple
 key matrixes
Date: Wed, 28 Dec 2011 22:16:59 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17755DC8D2@HQMAIL01.nvidia.com>
References: <1325112771-31941-1-git-send-email-olof@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1325112771-31941-1-git-send-email-olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "Simon Glass (sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org)" <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rakesh Iyer <riyer-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Olof Johansson wrote at Wednesday, December 28, 2011 3:53 PM:
> From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> This adds a basic device tree binding for simple key matrix data.
> 
> Signed-off-by: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
> ---
> 
> Based on email exchange this morning, this is a first cut at a shared
> definition and helper function to parse and fill in the keymap data.
> 
> Instead of doing the direct parsing into the final keymap format, I
> chose to fill in the pdata-equivalent since that is how the OF pdata
> fillers work right now if code is to be kept common with the legacy
> platform_device probe interface.
> 
> This is a prerequisite for a revised version of the tegra-kbc device
> tree support that I will repost separately once this interface is stable.
...
> diff --git a/Documentation/devicetree/bindings/input/matrix-keymap.txt
...
> +For simple keyboards with just a few buttons, you can specify each key
> +as a subnode of the keyboard controller, with the following
> +properties:
> +
> +- keypad,row: the row number to which the key is connected.
> +- keypad,column: the column number to which the key is connected.
> +- linux,code: the key-code to be reported when the key is pressed
> +  and released.
> +
> +Example:
> +
> +	key_1 {
> +		keypad,row = <0>;
> +		keypad,column = <3>;
> +		linux,code = <2>;
> +	};
> +
> +
> +For a more complex keyboard, such as a full laptop, a more compact
> +binding can be used instead, with the following property directly in
> +the keyboard controller node:
> +
> +- linux,keymap: an array of 3-cell entries containing the equivalent
> +  of the three separate properties above: row, column and linux
> +  key-code.

Why allow two completely different bindings? Is there some deficiency
to the compact binding that means it isn't suitable for all cases?

The binding proposed by Simon Glass for U-Boot was just a matrix
of keycodes, with any unused locations containing zero, e.g. see:

http://patchwork.ozlabs.org/patch/129825/

... which is yet another option. We obviously don't want U-Boot and the
kernel to expect different DT content either.

-- 
nvpublic
