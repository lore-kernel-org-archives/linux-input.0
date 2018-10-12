From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: input: pwm-vibrator: correct pwms in
 example
Date: Fri, 12 Oct 2018 14:31:26 -0500
Message-ID: <20181012193126.GA26994@bogus>
References: <20180927004858.32529-1-masneyb@onstation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180927004858.32529-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: robh@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sebastian.reichel@collabora.co.uk, mark.rutland@arm.com, masneyb@onstation.org
List-Id: linux-input@vger.kernel.org

On Wed, 26 Sep 2018 20:48:58 -0400, Brian Masney wrote:
> In the example for the pwm-vibrator bindings, pwm8 is the direction pin,
> and pwm9 is the enable pin. The pwms on the vibrator node has these two
> values swapped so this patch corrects it.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
> Changes since v1:
> - Swapped the pwms values instead of the pwm-names values since enable
>   is required and direction is optional. Based on feedback from
>   Rob Herring.
> 
>  Documentation/devicetree/bindings/input/pwm-vibrator.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
