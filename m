From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RESEND] [PATCHv6 4/4] hwmon: da9052: add support for TSI channel
Date: Tue, 22 Aug 2017 08:47:00 +0100
Message-ID: <20170822074700.yfscqocgespuopx5@dell>
References: <20170821145404.18902-1-sebastian.reichel@collabora.co.uk>
 <20170821145404.18902-5-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170821145404.18902-5-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 21 Aug 2017, Sebastian Reichel wrote:

> TSI channel has a 4 channel mux connected to it and is normally
> used for touchscreen support. The hardware may alternatively
> use it as general purpose adc.
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
>  drivers/hwmon/da9052-hwmon.c | 249 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 245 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
