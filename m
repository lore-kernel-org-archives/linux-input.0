From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: add the regulator optional properties
Date: Mon, 12 Sep 2016 11:16:55 -0500
Message-ID: <20160912161655.GA12672@rob-hp-laptop>
References: <1473027116-13892-1-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1473027116-13892-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-rockchip@lists.infradead.org, dbasehore@chromium.org, Douglas Anderson <dianders@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Brian Norris <briannorris@chromium.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-input@vger.kernel.org

On Mon, Sep 05, 2016 at 06:11:55AM +0800, Caesar Wang wrote:
> Add the regulator properties that will be used to power on/off
> the regulator.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: linux-input@vger.kernel.org
> ---
> 
>  Documentation/devicetree/bindings/input/hid-over-i2c.txt | 3 +++
>  1 file changed, 3 insertions(+)

I find this binding a bit questionable. The compatible should describe 
the actual device, not just the protocol it uses.

> diff --git a/Documentation/devicetree/bindings/input/hid-over-i2c.txt b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
> index 488edcb..e648e44 100644
> --- a/Documentation/devicetree/bindings/input/hid-over-i2c.txt
> +++ b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
> @@ -17,6 +17,9 @@ Required properties:
>  - interrupt-parent: the phandle for the interrupt controller
>  - interrupts: interrupt line
>  
> +Optional properties:
> +- power-supply: phandle of the regulator that provides the supply voltage.

This needs to be actual supplies for devices. What if a device has 2 
supplies?

Add a device compatible string and make this property specific to that 
device, then it's fine.

Rob
