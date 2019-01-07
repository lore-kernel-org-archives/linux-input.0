From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: input: touchscreen: goodix: Document
 AVDD28-supply property
Date: Mon, 7 Jan 2019 22:58:10 +0000
Message-ID: <20190107225810.ggmkkbrnkoy2ykx5@penguin>
References: <20181215151802.18592-1-jagan@amarulasolutions.com>
 <20181215151802.18592-2-jagan@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181215151802.18592-2-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jagan Teki <jagan@amarulasolutions.com>, robh@kernel.org
Cc: Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Trimarchi <michael@amarulasolutions.com>, linux-amarula@amarulasolutions.com
List-Id: linux-input@vger.kernel.org

On Sat, Dec 15, 2018 at 08:47:59PM +0530, Jagan Teki wrote:
> Most of the Goodix CTP controllers are supply with AVDD28 pin.
> which need to supply for controllers like GT5663 on some boards
> to trigger the power.
> 
> So, document the supply property so-that the require boards
> that used on GT5663 can enable it via device tree.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> index f7e95c52f3c7..c4622c983e08 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> @@ -23,6 +23,7 @@ Optional properties:
>   - touchscreen-inverted-y  : Y axis is inverted (boolean)
>   - touchscreen-swapped-x-y : X and Y axis are swapped (boolean)
>                               (swapping is done after inverting the axis)
> + - AVDD28-supply	: Analog power supply regulator on AVDD28 pin

I think we normally use lower case in DT bindings and rarely encode
voltage in the supply name unless we are dealing with several supplies
of the same kind, but I'll let Ron comment on this.

Thanks.

-- 
Dmitry
