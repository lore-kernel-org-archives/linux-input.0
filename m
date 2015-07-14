From: Antonio Borneo <borneo.antonio@gmail.com>
Subject: Re: [PATCH v2] HID: cp2112: fix I2C_SMBUS_BYTE write
Date: Tue, 14 Jul 2015 16:46:44 +0800
Message-ID: <CAAj6DX3oZtJGftbcWbWCRZN1fPuwCWiegQXQXekYRf9C2Oq-SQ@mail.gmail.com>
References: <1436826234-2447-1-git-send-email-ellen@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:33456 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021AbbGNIqp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jul 2015 04:46:45 -0400
In-Reply-To: <1436826234-2447-1-git-send-email-ellen@cumulusnetworks.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ellen Wang <ellen@cumulusnetworks.com>
Cc: David Barksdale <dbarksdale@uplogix.com>, Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, linux-i2c@vger.kernel.org

On Tue, Jul 14, 2015 at 6:23 AM, Ellen Wang <ellen@cumulusnetworks.com> wrote:
>
> When doing an I2C_SMBUS_BYTE write (one byte write, no address),
> the data to be written is in "command" not "data->byte".
>
> Signed-off-by: Ellen Wang <ellen@cumulusnetworks.com>
> ---
> Forgot signed-off-by tag last time, sorry.
> ---
>  drivers/hid/hid-cp2112.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
> index a3703b8..7afc3fc 100644
> --- a/drivers/hid/hid-cp2112.c
> +++ b/drivers/hid/hid-cp2112.c
> @@ -606,7 +606,7 @@ static int cp2112_xfer(struct i2c_adapter *adap, u16 addr,
>                 if (I2C_SMBUS_READ == read_write)
>                         count = cp2112_read_req(buf, addr, read_length);
>                 else
> -                       count = cp2112_write_req(buf, addr, data->byte, NULL,
> +                       count = cp2112_write_req(buf, addr, command, NULL,
>                                                  0);
>                 break;
>         case I2C_SMBUS_BYTE_DATA:


Correct!

E.g. in drivers/i2c/i2c-core.c we have:

s32 i2c_smbus_write_byte(const struct i2c_client *client, u8 value)
{
       return i2c_smbus_xfer(client->adapter, client->addr, client->flags,
                             I2C_SMBUS_WRITE, value, I2C_SMBUS_BYTE, NULL);
}

that passes NULL for data, so data->byte will dereference the NULL ptr.
The value is passed in "command".

Jiri,
I agree with Ellen that this driver is not commonly used, so no rush
to push the fix upstream.
But the fix should be marked for stable.

If you need, you can add
Reviewed-by: Antonio Borneo <borneo.antonio@gmail.com>

BR
Antonio
