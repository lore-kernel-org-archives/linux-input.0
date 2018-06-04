From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V2] cros_ec_keyb: Mark cros_ec_keyb driver as wake
 enabled device.
Date: Mon, 4 Jun 2018 07:18:56 +0100
Message-ID: <20180604061856.GF25455@dell>
References: <20180524234213.GE177107@dtor-ws>
 <20180526011440.102417-1-ravisadineni@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180526011440.102417-1-ravisadineni@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ravi Chandra Sadineni <ravisadineni@chromium.org>
Cc: dmitry.torokhov@gmail.com, ravisadineni@google.com, dtor@google.com, briannorris@chromium.org, tbroch@google.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, rajatja@google.com, bleung@google.com
List-Id: linux-input@vger.kernel.org

On Fri, 25 May 2018, Ravi Chandra Sadineni wrote:

> Mark cros_ec_keyb has wake enabled by default. If we see a MKBP event
> related to keyboard,  call pm_wakeup_event() to make sure wakeup
> triggers are accounted to keyb during suspend resume path.
> 
> Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> ---
> V2: Marked the ckdev as wake enabled instead of input devices.
> 
>  drivers/input/keyboard/cros_ec_keyb.c | 21 +++++++++++++++++----

>  drivers/mfd/cros_ec.c                 | 19 +++++++------------

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
