From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 1/4] dt-bindings: input: touchscreen: goodix: Document
 regulator properties
Date: Fri, 22 Feb 2019 10:43:46 -0600
Message-ID: <20190222164346.GA26256@bogus>
References: <20190219101629.15977-1-jagan@amarulasolutions.com>
 <20190219101629.15977-2-jagan@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190219101629.15977-2-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, linux-amarula@amarulasolutions.com, Michael Trimarchi <michael@amarulasolutions.com>, Jagan Teki <jagan@amarulasolutions.com>
List-Id: linux-input@vger.kernel.org

On Tue, 19 Feb 2019 15:46:26 +0530, Jagan Teki wrote:
> Goodix CTP controllers support analog, digital and gpio regulator
> supplies on relevant controller pin configurations.
> 
> Out of which AVDD28 and VDDIO regulators are required in few goodix CTP
> chips during power-on sequence.
> 
> AVDD22, DVDD12 regulators have no relevant functionality described from
> datasheet [1].
> 
> So, document both AVDD28, VDDIO regulators into optional properties since
> few of the goodix chip do work without these regulator power-on sequence.
> 
> [1] GT5663 Datasheet_English_20151106_Rev.01
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
