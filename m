From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Documentation: cypress,cyapa.txt: correct the I2C
 address of Gen3 touchpads to 0x67
Date: Sat, 19 Sep 2015 10:40:58 -0700
Message-ID: <20150919174058.GD7081@dtor-ws>
References: <1442543864-9712-1-git-send-email-dudl@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1442543864-9712-1-git-send-email-dudl@cypress.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dudley Du <dudl@cypress.com>
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Sep 18, 2015 at 10:37:44AM +0800, Dudley Du wrote:
> All of the Gen3 touchpads are fixed with I2C address 0x67, so correct the
> reg value description from 0x24 to 0x67.
> 
> Signed-off-by: Dudley Du <dudl@cypress.com>

Applied, thank you.

> ---
>  Documentation/devicetree/bindings/input/cypress,cyapa.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/cypress,cyapa.txt b/Documentation/devicetree/bindings/input/cypress,cyapa.txt
> index 635a3b0..8d91ba9 100644
> --- a/Documentation/devicetree/bindings/input/cypress,cyapa.txt
> +++ b/Documentation/devicetree/bindings/input/cypress,cyapa.txt
> @@ -25,7 +25,7 @@ Example:
>  		/* Cypress Gen3 touchpad */
>  		touchpad@67 {
>  			compatible = "cypress,cyapa";
> -			reg = <0x24>;
> +			reg = <0x67>;
>  			interrupt-parent = <&gpio>;
>  			interrupts = <2 IRQ_TYPE_EDGE_FALLING>;	/* GPIO 2 */
>  			wakeup-source;
> -- 
> 1.9.1
> 
> 
> ---------------------------------------------------------------
> This message and any attachments may contain Cypress (or its
> subsidiaries) confidential information. If it has been received
> in error, please advise the sender and immediately delete this
> message.
> ---------------------------------------------------------------
> 

-- 
Dmitry
