From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 3/4] dt-bindings: input: touchscreen: goodix: Add
 GT5663 compatible
Date: Mon, 18 Feb 2019 09:45:26 -0600
Message-ID: <20190218154526.GB28558@bogus>
References: <20190217091436.3702-1-jagan@amarulasolutions.com>
 <20190217091436.3702-4-jagan@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190217091436.3702-4-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, linux-amarula@amarulasolutions.com, Michael Trimarchi <michael@amarulasolutions.com>, Jagan Teki <jagan@amarulasolutions.com>
List-Id: linux-input@vger.kernel.org

On Sun, 17 Feb 2019 14:44:35 +0530, Jagan Teki wrote:
> GT5663 is capacitive touch controller with customized smart
> wakeup gestures, it support chipdata which is similar to
> existing GT1151 and require AVDD28 supply for some boards.
> 
> Document the compatible for the same.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
