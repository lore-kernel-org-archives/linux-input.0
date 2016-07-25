From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH 1/2] i2c: cros-ec-tunnel: Fix usage of cros_ec_cmd_xfer()
Date: Mon, 25 Jul 2016 15:45:53 -0400
Message-ID: <3bdbfe7b-2d6a-2c12-4771-34760c3215ba@osg.samsung.com>
References: <1469470451-111822-1-git-send-email-briannorris@chromium.org>
 <1469470451-111822-2-git-send-email-briannorris@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1469470451-111822-2-git-send-email-briannorris@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Olof Johansson <olof@lixom.net>, Brian Norris <computersforpeace@gmail.com>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Shawn Nematbakhsh <shawnn@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-input@vger.kernel.org

Hello Brian,

On 07/25/2016 02:14 PM, Brian Norris wrote:
> cros_ec_cmd_xfer returns success status if the command transport
> completes successfully, but the execution result is incorrectly ignored.
> In many cases, the execution result is assumed to be successful, leading
> to ignored errors and operating on uninitialized data.
> 
> We've recently introduced the cros_ec_cmd_xfer_status() helper to avoid these
> problems. Let's use it.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---

Patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
