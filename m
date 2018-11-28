From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 1/4] mfd: stmpe: Move ADC related defines to header of
 mfd
Date: Wed, 28 Nov 2018 09:15:32 +0000
Message-ID: <20181128091532.GU4272@dell>
References: <20181123142411.8921-1-dev@pschenker.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181123142411.8921-1-dev@pschenker.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Philippe Schenker <dev@pschenker.ch>
Cc: jic23@kernel.org, marcel.ziswiler@toradex.com, stefan@agner.ch, Philippe Schenker <philippe.schenker@toradex.com>, Max Krummenacher <max.krummenacher@toradex.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On Fri, 23 Nov 2018, Philippe Schenker wrote:

> Move defines that are ADC related to the header of the overlying mfd,
> so they can be used from multiple sub-devices.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> ---
> 
> Changes in v3:
>  - None
> 
> Changes in v2:
>  - This is a new added commit. Separate commit for moving the defines out of
>    drivers/input/touchscreen/stmpe-ts.c to overlying mfd-device drivers/mfd/stmpe.c
>  - Pre-fix defines with STMPE_
> 
>  drivers/input/touchscreen/stmpe-ts.c | 34 +++++++++++-----------------
>  include/linux/mfd/stmpe.h            | 11 +++++++++

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
