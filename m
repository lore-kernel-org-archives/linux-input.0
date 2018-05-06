From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v4 5/9] iio: adc: at91-sama5d2_adc: add support for
 position and pressure channels
Date: Sun, 6 May 2018 19:59:14 +0200
Message-ID: <20180506175914.GL10960@piout.net>
References: <1525084335-11276-1-git-send-email-eugen.hristev@microchip.com>
 <1525084335-11276-6-git-send-email-eugen.hristev@microchip.com>
 <20180506182953.6adad5b5@archlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180506182953.6adad5b5@archlinux>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: Eugen Hristev <eugen.hristev@microchip.com>, ludovic.desroches@microchip.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, nicolas.ferre@microchip.com, dmitry.torokhov@gmail.com, robh@kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

On 06/05/2018 18:29:53+0100, Jonathan Cameron wrote:
> On Mon, 30 Apr 2018 13:32:11 +0300
> Eugen Hristev <eugen.hristev@microchip.com> wrote:
> 
> > This implements the support for position and pressure for the included
> > touchscreen support in the SAMA5D2 SOC ADC block.
> > Two position channels are added and one for pressure.
> > They can be read in raw format, or through a buffer.
> > A normal use case is for a consumer driver to register a callback buffer
> > for these channels.
> > When the touchscreen channels are in the active scan mask,
> > the driver will start the touchscreen sampling and push the data to the
> > buffer.
> > 
> > Some parts of this patch are based on initial original work by
> > Mohamed Jamsheeth Hajanajubudeen and Bandaru Venkateswara Swamy
> > 
> > Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> Looks good to me now.
> 
> I'm assuming that once Dmitry and others are happy, I'll take the
> series through the IIO tree. Will reply to the cover letter if the
> rest of the patches look good to me to let everyone know that without
> having to catch this comment down in here!
> 

I'm planning to take both DT patches through the at91 tree once you take
the DT bindings patches.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
