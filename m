From: Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: Re: [PATCH v2 01/10] tpm/tpm_i2c_infineon: switch to
 i2c_lock_bus(..., I2C_LOCK_SEGMENT)
Date: Tue, 26 Jun 2018 12:07:21 +0200
Message-ID: <7703d6a2-b22c-104c-7390-b5143a504725@infineon.com>
References: <20180620051803.12206-1-peda@axentia.se>
 <20180620051803.12206-2-peda@axentia.se>
 <20180625102454.GA3845@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180625102454.GA3845@linux.intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Peter Rosin <peda@axentia.se>
Cc: Crt Mori <cmo@melexis.com>, Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, linux-i2c@vger.kernel.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Peter Huewe <peterhuewe@gmx.de>, Michael Krufky <mkrufky@linuxtv.org>, Lee Jones <lee.jones@linaro.org>, Antti Palosaari <crope@iki.fi>, linux-samsung-soc@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>, Chunyan Zhang <zhang.lyra@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Kukjin Kim <kgene@kernel.org>, bcm-kernel-feedback-list@broadcom.com, linux-input@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>, Guenter Roeck <linux@roeck-us.net>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-media@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Gregory Fong <gregory.0xf0>
List-Id: linux-input@vger.kernel.org

On 25.06.2018 12:24, Jarkko Sakkinen wrote:
> On Wed, Jun 20, 2018 at 07:17:54AM +0200, Peter Rosin wrote:
>> Locking the root adapter for __i2c_transfer will deadlock if the
>> device sits behind a mux-locked I2C mux. Switch to the finer-grained
>> i2c_lock_bus with the I2C_LOCK_SEGMENT flag. If the device does not
>> sit behind a mux-locked mux, the two locking variants are equivalent.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
> 
> Studied enough so that I can give
> 
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> Do not have hardware to test this, however.

I don't have a mux-locked I2C mux either, but at least I can confirm 
that this change did not break my existing test setup (SLB9635/SLB9645 
on Raspberry Pi 2B).

Tested-by: Alexander Steffen <Alexander.Steffen@infineon.com>

Alexander
