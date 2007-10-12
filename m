From: Roel Kluin <12o3l@tiscali.nl>
Subject: Re: [PATCH try #2] Input/Joystick Driver: add support AD7142 joystick
 driver
Date: Fri, 12 Oct 2007 11:14:03 +0200
Message-ID: <470F3ADB.2000704@tiscali.nl>
References: <1192174727.6247.20.camel@roc-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <1192174727.6247.20.camel@roc-laptop>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: bryan.wu@analog.com
Cc: dmitry.torokhov@gmail.com, linux-input@atrey.karlin.mff.cuni.cz, linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-input@vger.kernel.org

Bryan Wu wrote:
> +static int ad7142_i2c_read(struct i2c_client *client, unsigned short offset,
> +		unsigned short *data, unsigned int len)
> +{
> +	int ret = -1;
> +	int i;
> +	u8 block_data[32];
> +
> +	if (len < 1 && len > 16) {

you want || here

> +		printk(KERN_ERR "AD7142: read data length error\n");
> +		return ret;
> +	}
> +
> +	/* Do raw I2C, not smbus compatible */
> +	block_data[0] = (offset & 0xFF00) >> 8;
> +	block_data[1] = (offset & 0x00FF);
> +
> +	ret = i2c_master_send(client, block_data, 2);
> +	if (ret < 0) {
> +		printk(KERN_ERR "AD7142: I2C read error\n");
> +		return ret;
> +	}
> +
> +	ret = i2c_master_recv(client, block_data, len * 2);
> +	if (ret < 0) {
> +		printk(KERN_ERR "AD7142: I2C transfer error\n");
> +		return ret;
> +	}
> +
> +	for (i = 0; i < len; i++) {
> +		unsigned short temp;
> +		temp = block_data[2 * i];
> +		temp = (temp << 8) & 0xFF00;
> +		*data++ = temp | block_data[2 * i + 1];
> +	}
> +
> +	return ret;
> +}
