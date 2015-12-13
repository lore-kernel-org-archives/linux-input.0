From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: touchscreen: edt-ft5x06: Prevent DMA driver from mapping an area
 on stack
Date: Sat, 12 Dec 2015 20:42:37 -0800
Message-ID: <20151213044237.GA22780@dtor-ws>
References: <e0311a5e79a315814e8678c9ef4a32563c01d1e0.1449913392.git.maitysanchayan@gmail.com>
 <20151212171355.GA7362@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151212171355.GA7362@katana>
Sender: linux-i2c-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Sanchayan Maity <maitysanchayan@gmail.com>, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, maxime.ripard@free-electrons.com, stefan@agner.ch
List-Id: linux-input@vger.kernel.org

On Sat, Dec 12, 2015 at 06:13:55PM +0100, Wolfram Sang wrote:
> 
> > Frankly speaking I do not know where the fix should actually be. I2C IMX
> > driver somehow taking care of this or the users of I2C, touchscreen drivers
> > in this case. In my opinion, the fix should be with the touchscreen driver
> > however I did like to have feedback or hear opinions on what is the accepted
> > solution to this.
> 
> There is no accepted solution to this yet :( DMA is/was still too rare for
> a serious discussion about this. There is also [1] and probably more...
> 
> [1]  http://patchwork.ozlabs.org/patch/220137/

I believe vast majority of i2c client drivers do not expect that the
transfer buffer they supply in i2c messages are supposed to be DMAable
(unlike USB and SPI buses that had that requirement from the beginning).

I won't be applying this patch unless we decide that I2C changes the
rules.

Thanks.

-- 
Dmitry
