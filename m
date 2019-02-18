From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 01/11] dt-bindings: mfd: add DT bindings for max77650
Date: Mon, 18 Feb 2019 10:35:07 -0600
Message-ID: <20190218163507.GA16551@bogus>
References: <20190214140022.19201-1-brgl@bgdev.pl>
 <20190214140022.19201-2-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190214140022.19201-2-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

On Thu, 14 Feb 2019 15:00:12 +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Add a DT binding document for max77650 ultra-low power PMIC. This
> describes the core mfd device and the GPIO module.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  .../devicetree/bindings/mfd/max77650.txt      | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/max77650.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
