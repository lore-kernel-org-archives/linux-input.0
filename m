From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v2 10/10] i2c: remove i2c_lock_adapter and use
 i2c_lock_bus directly
Date: Tue, 26 Jun 2018 19:39:43 +0530
Message-ID: <4e0545e3-fee9-cf29-bae1-e442347e3cb8@ti.com>
References: <20180620051803.12206-1-peda@axentia.se>
 <20180620051803.12206-11-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180620051803.12206-11-peda@axentia.se>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
Cc: Crt Mori <cmo@melexis.com>, Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, linux-i2c@vger.kernel.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Peter Huewe <peterhuewe@gmx.de>, Michael Krufky <mkrufky@linuxtv.org>, Lee Jones <lee.jones@linaro.org>, Antti Palosaari <crope@iki.fi>, linux-samsung-soc@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>, Chunyan Zhang <zhang.lyra@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Kukjin Kim <kgene@kernel.org>, bcm-kernel-feedback-list@broadcom.com, linux-input@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>, Guenter Roeck <linux@roeck-us.net>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-media@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Grego
List-Id: linux-input@vger.kernel.org

On Wednesday 20 June 2018 10:48 AM, Peter Rosin wrote:
> The i2c_lock_adapter name is ambiguous since it is unclear if it
> refers to the root adapter or the adapter you name in the argument.
> The natural interpretation is the adapter you name in the argument,
> but there are historical reasons for that not being the case; it
> in fact locks the root adapter. Just remove the function and force
> users to spell out the I2C_LOCK_ROOT_ADAPTER name to indicate what
> is really going on. Also remove i2c_unlock_adapter, of course.
> 
> This patch was generated with
> 
> git grep -l 'i2c_\(un\)\?lock_adapter' \
> | xargs sed -i 's/i2c_\(un\)\?lock_adapter(\([^)]*\))/'\
> 'i2c_\1lock_bus(\2, I2C_LOCK_ROOT_ADAPTER)/g'
> 
> followed by white-space touch-up.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/i2c/busses/i2c-brcmstb.c   |  8 ++++----
>  drivers/i2c/busses/i2c-davinci.c   |  4 ++--

On DM644x and DA850 EVMs applying this series does not seem to break I2C
functionality. So:

Tested-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
