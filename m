From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 6/8] Input: dt-bindings: tm2-touchkey: Document new
 keycodes property
Date: Sat, 8 Dec 2018 20:57:35 -0800
Message-ID: <20181209045735.GG211094@dtor-ws>
References: <20181207105811.1831-1-pawel.mikolaj.chmiel@gmail.com>
 <20181207105811.1831-7-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181207105811.1831-7-pawel.mikolaj.chmiel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, xc-racer2@live.ca, simon@lineageos.org
List-Id: linux-input@vger.kernel.org

On Fri, Dec 07, 2018 at 11:58:09AM +0100, Paweł Chmiel wrote:
> From: Jonathan Bakker <xc-racer2@live.ca>
> 
> Document new optional property for setting custom keycodes.
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  .../devicetree/bindings/input/cypress,tm2-touchkey.txt        | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt b/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt
> index dfb3b9f0ee40..3b54d997b8de 100644
> --- a/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt
> +++ b/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt
> @@ -10,6 +10,9 @@ Required properties:
>  - vcc-supply : internal regulator output. 1.8V
>  - vdd-supply : power supply for IC 3.3V
>  
> +Optional properties:
> +- keycodes: array of keycodes (max 4), default KEY_PHONE and KEY_BACK
> +
>  [0]: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>  
>  Example:
> @@ -23,5 +26,6 @@ Example:
>  			interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
>  			vcc-supply=<&ldo32_reg>;
>  			vdd-supply=<&ldo33_reg>;
> +			keycodes = /bits/ 8 <KEY_PHONE KEY_BACK>;

We definitely have key codes bigger than 255. Just keep them normal
ints please.

>  		};
>  	};
> -- 
> 2.17.1
> 

-- 
Dmitry
