From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 13/14] HID: i2c-hid: also call i2c_hid_free_buffers in
 i2c_hid_remove
Date: Wed, 5 Dec 2012 11:32:18 +0100
Message-ID: <20121205113218.3518878e@endymion.delvare>
References: <1354634875-5182-1-git-send-email-benjamin.tissoires@gmail.com>
	<1354634875-5182-14-git-send-email-benjamin.tissoires@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1354634875-5182-14-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue,  4 Dec 2012 16:27:54 +0100, Benjamin Tissoires wrote:
> In the case where the hid driver in charge of handling the hid part
> of the device (hid-generic for instance) fails at probe, neither
> i2c_hid_start nor i2c_hid_stop are called.
> Thus, the buffers allocated in i2c_hid_probe are never freed.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
> ---
>  drivers/hid/i2c-hid/i2c-hid.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index bea4b13..62988f1 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -891,6 +891,9 @@ static int __devexit i2c_hid_remove(struct i2c_client *client)
>  
>  	free_irq(client->irq, ihid);
>  
> +	if (ihid->bufsize)
> +		i2c_hid_free_buffers(ihid);
> +
>  	kfree(ihid);
>  
>  	return 0;

Reviewed-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare
