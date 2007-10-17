From: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: [PATCH try #4] Input/Joystick Driver: add support AD7142 joystick  driver
Date: Wed, 17 Oct 2007 15:14:40 -0400
Message-ID: <200710171514.40941.rgetz@blackfin.uclinux.org>
References: <1192605120.7920.15.camel@roc-laptop> <20071017160702.3316fc24@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20071017160702.3316fc24@hyperion.delvare>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jean Delvare <khali@linux-fr.org>
Cc: bryan.wu@analog.com, Andrey Panin <pazke@donpac.ru>, Roel Kluin <12o3l@tiscali.nl>, "Ahmed S. Darwish" <darwish.07@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz, linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-input@vger.kernel.org

On Wed 17 Oct 2007 10:07, Jean Delvare pondered:
> Hi Bryan,
> 
> On Wed, 17 Oct 2007 15:12:00 +0800, Bryan Wu wrote:
> > Subject: [PATCH try #4] Input/Joystick Driver: add support AD7142
> joystick driver
> > +#define AD7142_I2C_ADDR		0x2C
> 
> Not worth a define IMHO, as you use it only once and the context is
> completely clear.

> > +static int ad7142_probe(struct i2c_adapter *adap, int addr, int kind)
> > +{
> > +	struct ad7142_data *data;
> > +	struct i2c_client *client;
> > +	struct input_dev *input_dev;
> > +	int rc;
> > +
> > +	data = kzalloc(sizeof(struct ad7142_data), GFP_KERNEL);
> > +	if (!data)
> > +		return -ENOMEM;
> > +
> > +	client = &data->client;
> > +
> > +	strlcpy(client->name, AD7142_DRV_NAME, I2C_NAME_SIZE);
> > +	client->addr = addr;
> > +	client->adapter = adap;
> > +	client->driver = &ad7142_driver;
> > +
> 
> This is unsafe: you're not doing any kind of detection here. 

I assume that in order to do things "right", all possible addresses should be 
probed (for this part, that is 0x2C, 0x2D, 0x2E, 0x2F)?

And it should read a device ID (register 0x17 == 0xE62n (where n==rev number))

How many values/registers do you need to read before you say "this is the 
one"? rather than a temp sensor with a similar value somewhere. Is there a 
table anywhere that maps this out?

It is pretty difficult just to probe on reset values, since that disallows 
warm resets. This part - like most other I2C parts, has no external reset, 
only software reset.

> The risk is mitigated by the fact
> that your driver is currently built for Blackfin only, but this might
> change in the future. 

The hope is that others can use it - it shouldn't be specific to Blackfin.

> This is a very good reason to switch to a 
> new-style i2c driver.
> 
