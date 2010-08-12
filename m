From: Stepan Moskovchenko <stepanm@codeaurora.org>
Subject: Re: [PATCH v2] input: mouse: add qci touchpad driver
Date: Thu, 12 Aug 2010 10:25:01 -0700
Message-ID: <4C642E6D.6000908@codeaurora.org>
References: <1281631760-15589-1-git-send-email-nleeder@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:6494 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758654Ab0HLRZC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Aug 2010 13:25:02 -0400
In-Reply-To: <1281631760-15589-1-git-send-email-nleeder@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Neil Leeder <nleeder@codeaurora.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Horace Fu <horace.fu@quantatw.com>, Mandeep Singh Baines <msb@chromium.org>

  On 8/12/2010 9:49 AM, Neil Leeder wrote:
> This driver is for the QCI trackpad used on Quanta smartbooks
>
> Signed-off-by: Horace Fu<horace.fu@quantatw.com>
> Signed-off-by: Mandeep Singh Baines<msb@chromium.org>
> [nleeder@codeaurora.org: cleanup i2c calls, address review comments etc]
> Signed-off-by: Neil Leeder<nleeder@codeaurora.org>
> ---
>   drivers/input/mouse/Kconfig        |   12 ++
>   drivers/input/mouse/Makefile       |    1 +
>   drivers/input/mouse/qci_touchpad.c |  270 ++++++++++++++++++++++++++++++++++++
>   include/linux/input/qci_touchpad.h |   25 ++++
>   4 files changed, 308 insertions(+), 0 deletions(-)
>   create mode 100644 drivers/input/mouse/qci_touchpad.c
>   create mode 100644 include/linux/input/qci_touchpad.h
>
> diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
> index c714ca2..32a88b4 100644
> --- a/drivers/input/mouse/Kconfig
> +++ b/drivers/input/mouse/Kconfig
> @@ -303,6 +303,18 @@ config MOUSE_MAPLE
>   	  To compile this driver as a module choose M here: the module will be
>   	  called maplemouse.
>
> +config MOUSE_QCITP
> +	tristate "Quanta Computer Inc. Touchpad"
> +	depends on I2C
> +	help
> +	  This driver supports the touchpad on Quanta smartbook devices.
> +
> +	  Say Y here if you have a Quanta-based smartboot or notepad
Sorry, very minor point - do you mean "smartbook" here?

A lot of machines are made by Quanta. Should this be given a description 
/ option name that is more specific, ie, "Quanta [chip name] Touchpad" 
or even "Quanta I2C Touchpad" ?  What you have might be fine, however...

Steve

