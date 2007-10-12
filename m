From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: Re: [PATCH try #2] Input/Joystick Driver: add support AD7142 joystick driver
Date: Fri, 12 Oct 2007 18:41:31 +0200
Message-ID: <20071012164131.GA12559@Ahmed>
References: <1192174727.6247.20.camel@roc-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <1192174727.6247.20.camel@roc-laptop>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Bryan Wu <bryan.wu@analog.com>
Cc: dmitry.torokhov@gmail.com, linux-input@atrey.karlin.mff.cuni.cz, linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-input@vger.kernel.org

On Fri, Oct 12, 2007 at 03:38:47PM +0800, Bryan Wu wrote:
>
> Signed-off-by: Bryan Wu <bryan.wu@analog.com>
> ---

Hi Bryan,

Why creating module's own kthread to call ad7142_decode and process keycodes 
instead of using a tasklet ?

Isn't disabling device interrupts from the begining of the ISR "ad7142_interrupt"
till the kthread "ad7142_thread" got waked-up and scheduled a long time,
espicially if there's a high load on the userspace side ?

Minor issues below.

> +
> +/* R    ADC stage 0 - 11 result (uncompensated) actually located in SRAM */
> +#define ADCRESULT_S0		0x0B
> +#define ADCRESULT_S1		0x0C
> +#define ADCRESULT_S2		0x0D
> +#define ADCRESULT_S3		0x0E
> +#define ADCRESULT_S4		0x0F
> +#define ADCRESULT_S5		0x10
> +#define ADCRESULT_S6		0x11
> +#define ADCRESULT_S7		0x12
> +#define ADCRESULT_S8		0x13
> +#define ADCRESULT_S9		0x14
> +#define ADCRESULT_S10		0x15
> +#define ADCRESULT_S11		0x16
> +

Keeping last two lines aligned with their above counterparts ?

> +static int
> +ad7142_probe(struct i2c_adapter *adap, int addr, int kind)
> +{
> +	struct i2c_client *client;
> +	int rc;
> +
> +	client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
> +	if (!client)
> +		return -ENOMEM;
> +	memset(client, 0, sizeof(struct i2c_client));

kzalloc.

Regards,

-- 
Ahmed S. Darwish
HomePage: http://darwish.07.googlepages.com
Blog: http://darwish-07.blogspot.com
