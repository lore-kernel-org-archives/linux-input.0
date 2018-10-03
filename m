From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: i2c-hid: Add a small delay after powering on/off
 the device
Date: Wed, 3 Oct 2018 11:10:02 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1810031109200.14430@cbobk.fhfr.pm>
References: <20181001035313.21453-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181001035313.21453-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: benjamin.tissoires@redhat.com, hdegoede@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 1 Oct 2018, Kai-Heng Feng wrote:

> Raydium touchpanel (2386:4B33) sometimes does not workin desktop session
> although it works in display manager.
> 
> During user logging, the display manager exits, close the HID device,
> then the device gets runtime suspended and powered off. The desktop
> session begins shortly after, opens the HID device, then the device gets
> runtime resumed and powered on.
> 
> If the trasition from display manager to desktop sesesion is fast, the
> touchpanel cannot switch from powered off to powered on in short
> timeframe. So add a small delay to workaround the issue.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/hid/i2c-hid/i2c-hid.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index f3076659361a..ff5682cc1bce 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -409,6 +409,8 @@ static int i2c_hid_set_power(struct i2c_client *client, int power_state)
>  
>  	if (ret)
>  		dev_err(&client->dev, "failed to change power setting.\n");
> +	else
> +		msleep(20);

In case there really is no other way around it, at least please add 
comment explaining why this ugly msleep() is there. Thanks,

-- 
Jiri Kosina
SUSE Labs
