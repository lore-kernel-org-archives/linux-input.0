From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: intel-lpss: Fix Intel Cannon Lake LPSS I2C input
 clock
Date: Mon, 4 Jun 2018 08:39:46 +0100
Message-ID: <20180604073946.GI25455@dell>
References: <20180518083827.20626-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180518083827.20626-1-jarkko.nikula@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, Jian-Hong Pan <jian-hong@endlessm.com>, Chris Chiu <chiu@endlessm.com>, Daniel Drake <drake@endlessm.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 18 May 2018, Jarkko Nikula wrote:

> Intel Cannon Lake PCH has much higher 216 MHz input clock to LPSS I2C
> than Sunrisepoint which uses 120 MHz. Preliminary information was that
> both share the same clock rate but actual silicon implements elevated
> rate for better support for 3.4 MHz high-speed I2C.
> 
> This incorrect input clock rate results too high I2C bus clock in case
> ACPI doesn't provide tuned I2C timing parameters since I2C host
> controller driver calculates them from input clock rate.
> 
> Fix this by using the correct rate. We still share the same 230 ns SDA
> hold time value than Sunrisepoint.
> 
> Cc: stable@vger.kernel.org
> Fixes: b418bbff36dd ("mfd: intel-lpss: Add Intel Cannonlake PCI IDs")
> Reported-by: Jian-Hong Pan <jian-hong@endlessm.com>
> Reported-by: Chris Chiu <chiu@endlessm.com>
> Reported-by: Daniel Drake <drake@endlessm.com>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
> Hi Jian-Hong, Chris and Daniel. Could you test does this fix your
> touchpad issue?
> ---
>  drivers/mfd/intel-lpss-pci.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
