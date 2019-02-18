From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 1/4] dt-bindings: input: touchscreen: goodix: Document
 regulator properties
Date: Mon, 18 Feb 2019 09:45:40 -0600
Message-ID: <20190218154540.GC28558@bogus>
References: <20190217091436.3702-1-jagan@amarulasolutions.com>
 <20190217091436.3702-2-jagan@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190217091436.3702-2-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, linux-amarula@amarulasolutions.com, Michael Trimarchi <michael@amarulasolutions.com>
List-Id: linux-input@vger.kernel.org

On Sun, Feb 17, 2019 at 02:44:33PM +0530, Jagan Teki wrote:
> Goodix CTP controllers support analog, digital and gpio regulator
> supplies on relevant controller pin configurations.
> 
> Out of which AVDD28 regulator is mandatory supplied regulator in most
> of the board designs, so document AVDD28 as required property and
> rest marked as optional regulators.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  .../devicetree/bindings/input/touchscreen/goodix.txt       | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
