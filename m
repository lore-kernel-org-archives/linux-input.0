From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 08/10] dt-bindings: iio: adc: at91-sama5d2_adc: add
 channel specific consumer info
Date: Mon, 9 Apr 2018 13:47:43 -0500
Message-ID: <20180409184743.zu7ihom6tvi7aino@rob-hp-laptop>
References: <1522153963-1121-1-git-send-email-eugen.hristev@microchip.com>
 <1522153963-1121-9-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1522153963-1121-9-git-send-email-eugen.hristev@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: jic23@kernel.org, ludovic.desroches@microchip.com, alexandre.belloni@bootlin.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, nicolas.ferre@microchip.com, dmitry.torokhov@gmail.com
List-Id: linux-input@vger.kernel.org

On Tue, Mar 27, 2018 at 03:32:41PM +0300, Eugen Hristev wrote:
> Added defines for channel consumer device-tree binding
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  .../devicetree/bindings/iio/adc/at91-sama5d2_adc.txt     |  9 +++++++++
>  include/dt-bindings/iio/adc/at91-sama5d2_adc.h           | 16 ++++++++++++++++
>  2 files changed, 25 insertions(+)
>  create mode 100644 include/dt-bindings/iio/adc/at91-sama5d2_adc.h

Reviewed-by: Rob Herring <robh@kernel.org>
