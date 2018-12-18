From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: input: Add Raspberry Pi Touchscreen
Date: Tue, 18 Dec 2018 10:52:42 -0600
Message-ID: <20181218165242.GA2809@bogus>
References: <20181211112408.9524-1-nsaenzjulienne@suse.de>
 <20181211112408.9524-2-nsaenzjulienne@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181211112408.9524-2-nsaenzjulienne@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, stefan.wahren@i2se.com, eric@anholt.net, agraf@suse.de, afaerber@suse.com, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 11 Dec 2018 12:23:53 +0100, Nicolas Saenz Julienne wrote:
> Adds device tree documentation for Raspberry Pi's official 7"
> touchscreen.
> 
> This binding is meant to be used as an overlay.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  .../touchscreen/raspberrypi,firmware-ts.txt   | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
