From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 3/4] dt-bindings: input: touchscreen: goodix: Add
 GT5663 compatible
Date: Wed, 13 Feb 2019 15:52:14 -0600
Message-ID: <20190213215214.GA12927@bogus>
References: <20190212112439.2025-1-jagan@amarulasolutions.com>
 <20190212112439.2025-4-jagan@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190212112439.2025-4-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Jagan Teki <jagan@amarulasolutions.com>
List-Id: linux-input@vger.kernel.org

On Tue, 12 Feb 2019 16:54:38 +0530, Jagan Teki wrote:
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
