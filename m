From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elan_i2c - add ELAN0611 to the ACPI table
Date: Tue, 24 Oct 2017 11:12:29 -0700
Message-ID: <20171024181229.ulukd4edl4rnbcto@dtor-ws>
References: <20171019171252.15365-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171019171252.15365-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: kt.liao@emc.com.tw, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Oct 20, 2017 at 01:12:52AM +0800, Kai-Heng Feng wrote:
> ELAN0611 touchpad uses elan_i2c as its driver. It can be found
> on Lenovo ideapad 320-15IKB.
> 
> So add it to ACPI table to enable the touchpad.
> 
> BugLink: https://bugs.launchpad.net/bugs/1723736
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied, thank you.

> ---
>  drivers/input/mouse/elan_i2c_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> index 0e761d079dc4..6d6b092e2da9 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -1258,6 +1258,7 @@ static const struct acpi_device_id elan_acpi_id[] = {
>  	{ "ELAN0605", 0 },
>  	{ "ELAN0609", 0 },
>  	{ "ELAN060B", 0 },
> +	{ "ELAN0611", 0 },
>  	{ "ELAN1000", 0 },
>  	{ }
>  };
> -- 
> 2.14.1
> 

-- 
Dmitry
