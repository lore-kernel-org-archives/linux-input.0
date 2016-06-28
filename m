From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 3/8] Input: synaptics-rmi4: Add dribble and palm
 gesture parameters to device tree
Date: Tue, 28 Jun 2016 15:56:06 -0500
Message-ID: <20160628205606.GL3737@rob-hp-laptop>
References: <1466813917-15841-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1466813917-15841-1-git-send-email-aduggan@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Nick Dyer <nick.dyer@itdev.co.uk>, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-input@vger.kernel.org

On Fri, Jun 24, 2016 at 05:18:37PM -0700, Andrew Duggan wrote:
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> ---
>  .../devicetree/bindings/input/rmi4/rmi_2d_sensor.txt          |  4 ++++
>  drivers/input/rmi4/rmi_2d_sensor.c                            | 11 +++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt b/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
> index f2c30c8..86cb8e3 100644
> --- a/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
> +++ b/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
> @@ -37,6 +37,10 @@ Optional Properties:
>  				disable reporing absolute position data.
>  - syna,rezero-wait-ms: Time in miliseconds to wait after issuing a rezero
>  				command.
> +- syna,dribble-enable: Enable reporting of dribble packets in the firmware.
> +- syna,dribble-disable: Disable reporting of dribble packets in the firmware.
> +- syna,palm-detect-enable: Enable reporting the palm detect gesture in the firmware.
> +- syna,palm-detect-disable: Disable reporting the palm detect gesture in the firmware.

No need for enable and disable. Make the common case be no property and 
the property is the opposite.

Rob
