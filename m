From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: [PATCH v2 01/10] tpm/tpm_i2c_infineon: switch to
 i2c_lock_bus(..., I2C_LOCK_SEGMENT)
Date: Mon, 25 Jun 2018 13:24:54 +0300
Message-ID: <20180625102454.GA3845@linux.intel.com>
References: <20180620051803.12206-1-peda@axentia.se>
 <20180620051803.12206-2-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180620051803.12206-2-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, bcm-kernel-feedback-list@broadcom.com, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Chunyan Zhang <zhang.lyra@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Guenter Roeck <linux@roeck-us.net>, Crt Mori <cmo@melexis.com>, Jonathan Cameron <jic23@kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, Jun 20, 2018 at 07:17:54AM +0200, Peter Rosin wrote:
> Locking the root adapter for __i2c_transfer will deadlock if the
> device sits behind a mux-locked I2C mux. Switch to the finer-grained
> i2c_lock_bus with the I2C_LOCK_SEGMENT flag. If the device does not
> sit behind a mux-locked mux, the two locking variants are equivalent.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>

Studied enough so that I can give

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Do not have hardware to test this, however.

/Jarkko
