From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] Input/Touchscreen Driver: add support AD7877 touchscreen driver
Date: Mon, 15 Oct 2007 13:33:31 -0400
Message-ID: <d120d5000710151033u44df579fr82588a7a6c7065d@mail.gmail.com>
References: <600D5CB4DFD93545BF61FF01473D11AC0F2B13C2@limkexm2.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <600D5CB4DFD93545BF61FF01473D11AC0F2B13C2@limkexm2.ad.analog.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Cc: Bryan Wu <bryan.wu@analog.com>, linux-input@atrey.karlin.mff.cuni.cz, linux-joystick@atrey.karlin.mff.cuni.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-input@vger.kernel.org

Hi Michael,

On 10/15/07, Hennerich, Michael <Michael.Hennerich@analog.com> wrote:
> >
> >> +
> >> +static int ad7877_read(struct device *dev, u16 reg)
> >> +{
> >> +       struct spi_device       *spi = to_spi_device(dev);
> >> +       struct ser_req          *req = kzalloc(sizeof *req,
> GFP_KERNEL);
> >
> >How many reads can happen at once? Maybe allocate 1 ser_req per
> >touchcsreen when creating it?
>
> ad7877_read_adc, ad7877_read and ad7877_write are just used by the sysfs
> hooks. Touchscreen samples are read by the kthread using a different
> message struct. So far each sysfs invocation got its own storage for the
> spi message, which then is handed over to the SPI bus driver.
> The SPI bus driver serializes transfers in a kthread.
>
> Two different processes could access the drivers sysfs hooks.
>
> Using one ser_req per touch screen could require additional locking?
> Things at is, looks pretty safe to me.
>

OK, fair enough.

-- 
Dmitry
