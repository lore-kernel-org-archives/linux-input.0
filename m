From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH try #2] Input/Joystick Driver: add support AD7142 joystick driver
Date: Fri, 12 Oct 2007 13:29:31 -0400
Message-ID: <d120d5000710121029q400d05d8s38ae8769f2f44b15@mail.gmail.com>
References: <1192174727.6247.20.camel@roc-laptop>
	 <20071012164131.GA12559@Ahmed>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20071012164131.GA12559@Ahmed>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc: Bryan Wu <bryan.wu@analog.com>, linux-input@atrey.karlin.mff.cuni.cz, linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-input@vger.kernel.org

Hi Ahmed,

On 10/12/07, Ahmed S. Darwish <darwish.07@gmail.com> wrote:
> On Fri, Oct 12, 2007 at 03:38:47PM +0800, Bryan Wu wrote:
> >
> > Signed-off-by: Bryan Wu <bryan.wu@analog.com>
> > ---
>
> Hi Bryan,
>
> Why creating module's own kthread to call ad7142_decode and process keycodes
> instead of using a tasklet ?
>

Yo can't access i2c from a tasklet context.

> Isn't disabling device interrupts from the begining of the ISR "ad7142_interrupt"
> till the kthread "ad7142_thread" got waked-up and scheduled a long time,
> espicially if there's a high load on the userspace side ?
>

It is OK - you disable a specific interrupt line preventing it from
raising any more IRQs until current one is serviced. This is different
from disabling interrupts on CPU.

> Minor issues below.
>
> > +
> > +/* R    ADC stage 0 - 11 result (uncompensated) actually located in SRAM */
> > +#define ADCRESULT_S0         0x0B
> > +#define ADCRESULT_S1         0x0C
> > +#define ADCRESULT_S2         0x0D
> > +#define ADCRESULT_S3         0x0E
> > +#define ADCRESULT_S4         0x0F
> > +#define ADCRESULT_S5         0x10
> > +#define ADCRESULT_S6         0x11
> > +#define ADCRESULT_S7         0x12
> > +#define ADCRESULT_S8         0x13
> > +#define ADCRESULT_S9         0x14
> > +#define ADCRESULT_S10                0x15
> > +#define ADCRESULT_S11                0x16
> > +
>
> Keeping last two lines aligned with their above counterparts ?

I believe they are aligned if you aplly the patch.

-- 
Dmitry
