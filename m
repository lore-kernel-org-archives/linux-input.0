From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCHv7][ 1/4] Input: tsc2007: Add device tree support.
Date: Thu, 24 Oct 2013 17:47:46 +0100
Message-ID: <20131024164746.3CB36C403B6@trevor.secretlab.ca>
References: <1382618536-25320-1-git-send-email-denis@eukrea.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4487842815786361867=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1382618536-25320-1-git-send-email-denis@eukrea.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <rob.herring@calxeda.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Denis Carikli <denis@eukrea.com>, Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <kernel@pengutronix.de>, linux-input@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

--===============4487842815786361867==
Content-Type: text/plain

On Thu, 24 Oct 2013 14:42:13 +0200, Denis Carikli <denis@eukrea.com> wrote:
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: devicetree@vger.kernel.org
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Lothar Waßmann <LW@KARO-electronics.de>
> Cc: Eric Bénard <eric@eukrea.com>
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
> ChangeLog v6->v7:
> - One small whitespace cleanup.
> - The properties specific to that driver are now prefixed with "ti,".
> - The ti,fuzzy property has now better documentation.
> ---
>  .../bindings/input/touchscreen/tsc2007.txt         |   45 +++++
>  drivers/input/touchscreen/tsc2007.c                |  194 +++++++++++++++-----
>  2 files changed, 198 insertions(+), 41 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
> new file mode 100644
> index 0000000..516b63b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
> @@ -0,0 +1,45 @@
> +* Texas Instruments tsc2007 touchscreen controller
> +
> +Required properties:
> +- compatible: must be "ti,tsc2007".
> +- reg: I2C address of the chip.
> +- ti,x-plate-ohms: X-plate resistance in ohms.
> +
> +Optional properties:
> +- gpios: the interrupt gpio the chip is connected to (trough the penirq pin)
> +  (see GPIO binding[2] for more details).

Hmmm, why is this needed? Is the line used for anything other than
finding the irq number? If it is just an interrupt then an interrupts
property is all that should be specified.

g.



--===============4487842815786361867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4487842815786361867==--
