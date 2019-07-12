From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: input: Convert Allwinner LRADC to a schema
Date: Fri, 12 Jul 2019 07:21:00 -0600
Message-ID: <20190712132100.GA6212@bogus>
References: <20190711093835.20663-1-maxime.ripard@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190711093835.20663-1-maxime.ripard@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Maxime Ripard <maxime.ripard@bootlin.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On Thu, 11 Jul 2019 11:38:35 +0200, Maxime Ripard wrote:
> The Allwinner SoCs have an LRADC used to report keys and supported in
> Linux, with a matching Device Tree binding.
> 
> Now that we have the DT validation in place, let's convert the device tree
> bindings for that controller over to a YAML schemas.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  .../input/allwinner,sun4i-a10-lradc-keys.yaml | 95 +++++++++++++++++++
>  .../bindings/input/sun4i-lradc-keys.txt       | 65 -------------
>  2 files changed, 95 insertions(+), 65 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml
>  delete mode 100644 Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
> 

Applied, thanks.

Rob
