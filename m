From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 03/10] Input: synaptics-rmi4: Add device tree support
 for RMI4 I2C devices
Date: Fri, 12 Feb 2016 09:41:15 -0600
Message-ID: <20160212154115.GA7907@rob-hp-laptop>
References: <1455143041-10159-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455143041-10159-1-git-send-email-aduggan@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Chris Healy <cphealy@gmail.com>, Andrey Gusakov <andrey.gusakov@cogentembedded.com>, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Feb 10, 2016 at 02:24:01PM -0800, Andrew Duggan wrote:
> Add devicetree binding for I2C devices and add bindings for optional
> parameters in the function drivers. Parameters for function drivers are
> defined in child nodes for each of the functions.
> 
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> ---
>  .../devicetree/bindings/input/rmi4/rmi_f01.txt     | 39 ++++++++++++++++
>  .../devicetree/bindings/input/rmi4/rmi_i2c.txt     | 53 ++++++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.txt        |  1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/input/rmi4/rmi_bus.c                       | 35 ++++++++++++++
>  drivers/input/rmi4/rmi_bus.h                       |  4 --
>  drivers/input/rmi4/rmi_driver.c                    | 28 ++++++++++++
>  drivers/input/rmi4/rmi_f01.c                       | 50 ++++++++++++++++++++
>  drivers/input/rmi4/rmi_i2c.c                       | 12 ++++-
>  8 files changed, 217 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt
>  create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt
