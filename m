From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v2 00/10] Split i2c_lock_adapter into i2c_lock_root and
 i2c_lock_segment
Date: Thu, 12 Jul 2018 18:59:44 -0300
Message-ID: <20180712185944.62219cf6@coco.lan>
References: <20180620051803.12206-1-peda@axentia.se>
 <20180626023735.xj7aqhvw7ta2lq6s@ninjato>
 <20180712212850.axi3rrfwivqymqh5@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180712212850.axi3rrfwivqymqh5@ninjato>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Crt Mori <cmo@melexis.com>, linux-iio@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, linux-i2c@vger.kernel.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Peter Huewe <peterhuewe@gmx.de>, Michael Krufky <mkrufky@linuxtv.org>, Lee Jones <lee.jones@linaro.org>, Antti Palosaari <crope@iki.fi>, linux-samsung-soc@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>, Chunyan Zhang <zhang.lyra@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Kukjin Kim <kgene@kernel.org>, bcm-kernel-feedback-list@broadcom.com, linux-input@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>, Guenter Roeck <linux@roeck-us.net>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-media@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Gregory
List-Id: linux-input@vger.kernel.org

Em Thu, 12 Jul 2018 23:28:51 +0200
Wolfram Sang <wsa@the-dreams.de> escreveu:

> On Tue, Jun 26, 2018 at 11:37:36AM +0900, Wolfram Sang wrote:
> > On Wed, Jun 20, 2018 at 07:17:53AM +0200, Peter Rosin wrote:  
> > > Hi!
> > > 
> > > With the introduction of mux-locked I2C muxes, the concept of
> > > locking only a segment of the I2C adapter tree was added. At the
> > > time, I did not want to cause a lot of extra churn, so left most
> > > users of i2c_lock_adapter alone and apparently didn't think enough
> > > about it; they simply continued to lock the whole adapter tree.
> > > However, i2c_lock_adapter is in fact wrong for almost every caller
> > > (there is naturally an exception) that is itself not a driver for
> > > a root adapter. What normal drivers generally want is to only
> > > lock the segment of the adapter tree that their device sits on.
> > > 
> > > In fact, if a device sits behind a mux-locked I2C mux, and its
> > > driver calls i2c_lock_adapter followed by an unlocked I2C transfer,
> > > things will deadlock (since even a mux-locked I2C adapter will lock
> > > its parent at some point). If the device is not sitting behind a
> > > mux-locked I2C mux (i.e. either directly on the root adapter or
> > > behind a (chain of) parent-locked I2C muxes) the root/segment
> > > distinction is of no consequence; the root adapter is locked either
> > > way.
> > > 
> > > Mux-locked I2C muxes are probably not that common, and putting any
> > > of the affected devices behind one is probably even rarer, which
> > > is why we have not seen any deadlocks. At least not that I know
> > > of...
> > > 
> > > Since silently changing the semantics of i2c_lock_adapter might
> > > be quite a surprise, especially for out-of-tree users, this series
> > > instead removes the function and forces all users to explicitly
> > > name I2C_LOCK_SEGMENT or I2C_LOCK_ROOT_ADAPTER in a call to
> > > i2c_lock_bus, as suggested by Wolfram. Yes, users will be a teensy
> > > bit more wordy, but open-coding I2C locking from random drivers
> > > should be avoided, so it's perhaps a good thing if it doesn't look
> > > too neat?
> > > 
> > > I suggest that Wolfram takes this series through the I2C tree and
> > > creates an immutable branch for the other subsystems. The series
> > > is based on v4.18-r1.  
> > 
> > Applied to a seperate branch named "i2c/precise-locking-names" which I
> > will merge into for-next, so it will get proper testing already. Once we
> > get the missing acks from media, MFD, and IIO maintainers, I will merge
> > it into for-4.19.  
> 
> Ping for media related acks.

For the media-related ones:

Acked-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> 
> Thanks,
> 
>    Wolfram
> 



Thanks,
Mauro
