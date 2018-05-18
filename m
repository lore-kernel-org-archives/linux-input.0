From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] mfd: intel-lpss: Fix Intel Cannon Lake LPSS I2C input
 clock
Date: Fri, 18 May 2018 13:46:38 +0300
Message-ID: <20180518104638.GF15419@lahna.fi.intel.com>
References: <20180518083827.20626-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180518083827.20626-1-jarkko.nikula@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, Jian-Hong Pan <jian-hong@endlessm.com>, Chris Chiu <chiu@endlessm.com>, Daniel Drake <drake@endlessm.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, May 18, 2018 at 11:38:27AM +0300, Jarkko Nikula wrote:
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

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
