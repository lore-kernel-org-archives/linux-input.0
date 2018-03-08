From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: input: Add binding for RAVE SP input
 driver
Date: Wed, 7 Mar 2018 20:04:47 -0600
Message-ID: <20180308020447.rkpfcyeoh2b255bg@rob-hp-laptop>
References: <20180307020134.26293-1-andrew.smirnov@gmail.com>
 <20180307020134.26293-2-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180307020134.26293-2-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
List-Id: linux-input@vger.kernel.org

On Tue, Mar 06, 2018 at 06:01:34PM -0800, Andrey Smirnov wrote:
> Add Device Tree bindings for RAVE SP input drvier - an MFD cell of
> parent RAVE SP driver (documented in
> Documentation/devicetree/bindings/mfd/zii,rave-sp.txt).
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Acked-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
> 
> Changes since [v2]:
> 
> 	- Collected Acked-by from Lucas
> 
> 	- Removed unnecessary status="okay"
> 
> No changes between v1 and v2, so v1 is not referenced here.
> 
> [v2] lkml.kernel.org/r/20180301165527.22274-2-andrew.smirnov@gmail.com
> 
>  .../bindings/input/zii,rave-sp-pwrbutton.txt       | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/zii,rave-sp-pwrbutton.txt

Reviewed-by: Rob Herring <robh@kernel.org>
