From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v4 0/4] OMAP4 Keyboard Controller Support
Date: Thu, 17 Jun 2010 14:06:04 -0700
Message-ID: <87wrtxl683.fsf@deeprootsystems.com>
References: <x0066660@ti.com>
	<1276704485-30486-1-git-send-email-x0066660@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1276704485-30486-1-git-send-email-x0066660@ti.com> (Abraham Arce's message of "Wed\, 16 Jun 2010 11\:08\:05 -0500")
Sender: linux-omap-owner@vger.kernel.org
To: Abraham Arce <x0066660@ti.com>
Cc: linux-input@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Abraham Arce <x0066660@ti.com> writes:

> Keyboard controller for OMAP4 includes
>
>  - built-in scanning algorithm
>  - debouncing feature
>  - handling mechanism up to 9 x 9 keys
>  - wake-up event generation
>

[...]

> v4
>  Felipe.Balbi.01    | rows, cols, base and irq definitions
>  Felipe.Balbi.02    | device_* calls
>  Felipe.Balbi.03    | input device registration before irq enabling
>  Felipe.Balbi.04    | kzalloc allocation never to be freed
>
>  Tony.Lindgren.01   | test in omap2 and omap3
>  Tony.Lindgren.02   | add cpu_is_omap44xx()
>
>  Kevin.Hillman.01   | drop device_* calls
>  Kevin.Hillman.01   | use runtime PM API

I don't see the runtime PM API used anywere in this series.

Kevin
