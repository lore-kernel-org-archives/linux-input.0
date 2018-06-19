From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 02/11] tpm/tpm_i2c_infineon: switch to i2c_lock_segment
Date: Tue, 19 Jun 2018 15:05:50 +0200
Message-ID: <eb583028-dfcb-7f1b-c2a1-236ad4c5c2b5@axentia.se>
References: <20180615101506.8012-1-peda@axentia.se>
 <20180615101506.8012-3-peda@axentia.se>
 <20180619125618.GB5609@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180619125618.GB5609@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, bcm-kernel-feedback-list@broadcom.com, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Chunyan Zhang <zhang.lyra@gmail.com>, Laxman Dewangan <ldewangan@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Wo
List-Id: linux-input@vger.kernel.org

On 2018-06-19 14:56, Jarkko Sakkinen wrote:
> On Fri, Jun 15, 2018 at 12:14:57PM +0200, Peter Rosin wrote:
>> Locking the root adapter for __i2c_transfer will deadlock if the
>> device sits behind a mux-locked I2C mux. Switch to the finer-grained
>> i2c_lock_segment. If the device does not sit behind a mux-locked mux,
>> the two locking variants are equivalent.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
> 
> Can you quickly explain (or give a reference) the difference with these
> functions? Not an expert in this area. Thanks.

There are some words in the cover letter. If you need more, there's
always Documentation/i2c/i2c-topology. Hope that helps, otherwise I'll
try to explain better...

Cheers,
Peter
