From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: cp2112: Fix I2C_BLOCK_DATA transactions
Date: Tue, 21 Nov 2017 17:42:54 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1711211742270.11505@cbobk.fhfr.pm>
References: <20171114000358.GA14433@mail.arista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171114000358.GA14433@mail.arista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eudean Sun <eudean@arista.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, David Barksdale <dbarksdale@uplogix.com>
List-Id: linux-input@vger.kernel.org

On Mon, 13 Nov 2017, Eudean Sun wrote:

> The existing driver erroneously treats I2C_BLOCK_DATA and BLOCK_DATA
> commands the same. Fix the logic for I2C_BLOCK_DATA reads and writes.

Addin David, the original author of the driver (and the code in question 
as well) to CC.

> 
> Signed-off-by: Eudean Sun <eudean@arista.com>
> ---
>  drivers/hid/hid-cp2112.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
> index 078026f..0adece2 100644
> --- a/drivers/hid/hid-cp2112.c
> +++ b/drivers/hid/hid-cp2112.c
> @@ -692,8 +692,16 @@ static int cp2112_xfer(struct i2c_adapter *adap, u16 addr,
>  					      (u8 *)&word, 2);
>  		break;
>  	case I2C_SMBUS_I2C_BLOCK_DATA:
> -		size = I2C_SMBUS_BLOCK_DATA;
> -		/* fallthrough */
> +		if (read_write == I2C_SMBUS_READ) {
> +			read_length = data->block[0];
> +			count = cp2112_write_read_req(buf, addr, read_length,
> +						      command, NULL, 0);
> +		} else {
> +			count = cp2112_write_req(buf, addr, command,
> +						 data->block + 1,
> +						 data->block[0]);
> +		}
> +		break;
>  	case I2C_SMBUS_BLOCK_DATA:
>  		if (I2C_SMBUS_READ == read_write) {
>  			count = cp2112_write_read_req(buf, addr,
> @@ -781,6 +789,9 @@ static int cp2112_xfer(struct i2c_adapter *adap, u16 addr,
>  	case I2C_SMBUS_WORD_DATA:
>  		data->word = le16_to_cpup((__le16 *)buf);
>  		break;
> +	case I2C_SMBUS_I2C_BLOCK_DATA:
> +		memcpy(data->block + 1, buf, read_length);
> +		break;
>  	case I2C_SMBUS_BLOCK_DATA:
>  		if (read_length > I2C_SMBUS_BLOCK_MAX) {
>  			ret = -EPROTO;
> -- 
> 2.7.4
> 

-- 
Jiri Kosina
SUSE Labs
