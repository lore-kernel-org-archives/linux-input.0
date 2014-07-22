From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 04/15] Input: atmel_mxt_ts - implement device tree support
Date: Tue, 22 Jul 2014 14:37:00 -0600
Message-ID: <53CECB6C.2030207@wwwdotorg.org>
References: <1404399697-26484-1-git-send-email-nick.dyer@itdev.co.uk> <1404399697-26484-5-git-send-email-nick.dyer@itdev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1404399697-26484-5-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: nick.dyer@itdev.co.uk
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Yufeng Shen <miletus@google.com>, Daniel Kurtz <djkurtz@chromium.org>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Alan Bowens <Alan.Bowens@atmel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>, Benson Leung <bleung@chromium.org>, Olof Johansson <olofj@chromium.org>, Sekhar Nori <nsekhar@ti.com>, Stephen Warren <swarren@nvidia.com>
List-Id: linux-input@vger.kernel.org

On 07/03/2014 09:01 AM, nick.dyer@itdev.co.uk wrote:
> From: Stephen Warren <swarren@nvidia.com>

> diff --git a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt b/Documentation/devicetree/bindings/input/atmel,maxtouch.txt

> +	touch@4b {
> +		compatible = "atmel,maxtouch";
> +		reg = <0x4b>;
> +		interrupt-parent = <&gpio>;
> +		interrupts = <TEGRA_GPIO(W, 3) GPIO_ACTIVE_HIGH>;

Oops. s/GPIO_ACTIVE_HIGH/IRQ_TYPE_LEVEL_LOW/ there; I evidently typed
something stupid into the doc when I wrote it!
