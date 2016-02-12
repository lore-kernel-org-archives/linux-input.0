From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 05/10] Input: synaptics-rmi4: Add device tree support
 for 2d sensors and F11
Date: Fri, 12 Feb 2016 09:47:54 -0600
Message-ID: <20160212154427.GA8795@rob-hp-laptop>
References: <1455143074-10259-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59230 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751079AbcBLPr7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Feb 2016 10:47:59 -0500
Content-Disposition: inline
In-Reply-To: <1455143074-10259-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Chris Healy <cphealy@gmail.com>, Andrey Gusakov <andrey.gusakov@cogentembedded.com>, devicetree@vger.kernel.org

On Wed, Feb 10, 2016 at 02:24:34PM -0800, Andrew Duggan wrote:
> 2D sensors have several parameter which can be set in the platform data.
> This patch adds support for getting those values from devicetree.
> 
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> ---
>  .../bindings/input/rmi4/rmi_2d_sensor.txt          |  56 +++++++++++
>  .../bindings/input/touchscreen/touchscreen.txt     |   2 +
>  drivers/input/rmi4/rmi_2d_sensor.c                 | 108 +++++++++++++++++++++
>  drivers/input/rmi4/rmi_2d_sensor.h                 |   3 +
>  drivers/input/rmi4/rmi_f11.c                       |   7 +-
>  5 files changed, 175 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt

[...]

> diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
> index ac23caf..d6674de 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
> @@ -18,6 +18,8 @@ Optional properties for Touchscreens:
>   - touchscreen-inverted-y	: Y axis is inverted (boolean)
>   - touchscreen-swapped-x-y	: X and Y axis are swapped (boolean)
>  				  Swapping is done after inverting the axis
> + - touchscreen-mm-x		: horizontal length in mm of the touchscreen
> + - touchscreen-mm-y		: vertical length in mm of the touchscreen

As I mentioned on v3, put the units on the end.

Rob
