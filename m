From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 2/2] input: add official Raspberry Pi's touchscreen
 driver
Date: Fri, 21 Dec 2018 00:49:06 -0800
Message-ID: <20181221084906.GJ211587@dtor-ws>
References: <20181211112408.9524-1-nsaenzjulienne@suse.de>
 <20181211112408.9524-3-nsaenzjulienne@suse.de>
 <87r2ecdovo.fsf@anholt.net>
 <2c433e120c2cf375b7d431f79ce6bfbace803c7e.camel@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2c433e120c2cf375b7d431f79ce6bfbace803c7e.camel@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: Eric Anholt <eric@anholt.net>, Henrik Rydberg <rydberg@bitmath.org>, linux-rpi-kernel@lists.infradead.org, stefan.wahren@i2se.com, agraf@suse.de, afaerber@suse.com, Corentin Labbe <clabbe.montjoie@gmail.com>, Mark Jonas <mark.jonas@de.bosch.com>, Masanari Iida <standby24x7@gmail.com>, Heiko Schocher <hs@denx.de>, Hans de Goede <hdegoede@redhat.com>, Eugen Hristev <eugen.hristev@microchip.com>, Zhu Yi <yi.zhu5@cn.bosch.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Dec 20, 2018 at 08:12:23PM +0100, Nicolas Saenz Julienne wrote:
> On Thu, 2018-12-20 at 10:39 -0800, Eric Anholt wrote:
> > Nicolas Saenz Julienne <nsaenzjulienne@suse.de> writes:
> > 
> > > Add's support to Raspberry Pi's 7" Touch device. Instead of using a
> > > conventional bus all information is copied into a memory mapped
> > > area by
> > > RPi's firmware.
> > > 
> > > Based on the driver found in RPi's kernel repository.
> > > 
> > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > 
> > While I wish we could just have a native driver instead, it does make
> > sense to have this driver upstream given the constraints.
> > 
> > Acked-by: Eric Anholt <eric@anholt.net>
> 
> Thanks Eric.
> 
> FYI I did manage to access the touchscreen after altering the native
> driver (edt-ft5x06). That said, as commented in the cover letter, it's
> not good enough as it breaks the camera. I plan on posting the patch
> and an overlay. I'm just waiting to see how these first patches are
> received.

Applied, thank you.

-- 
Dmitry
