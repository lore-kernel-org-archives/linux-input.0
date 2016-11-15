From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] HID: udraw-ps3: accel_limits is local to the driver
Date: Tue, 15 Nov 2016 14:38:22 +0100
Message-ID: <1479217102.5750.19.camel@hadess.net>
References: <20161115120205.3364-1-hadess@hadess.net>
         <alpine.LNX.2.00.1611151422371.29400@cbobk.fhfr.pm>
         <alpine.LNX.2.00.1611151425170.29400@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1611151425170.29400@cbobk.fhfr.pm>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 2016-11-15 at 14:26 +0100, Jiri Kosina wrote:
> From: Jiri Kosina <jkosina@suse.cz>
> 
> And as such should be marked static to avoid global namespace
> pollution.
> 
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>

Yes, thanks.

Reviewed-by: Bastien Nocera <hadess@hadess.net>

> ---
> 
> I've just applied this on top of hid.git#for-4.10/udraw-ps3
> 
>  drivers/hid/hid-udraw-ps3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-udraw-ps3.c b/drivers/hid/hid-udraw-
> ps3.c
> index 1f68b0b..88ea390 100644
> --- a/drivers/hid/hid-udraw-ps3.c
> +++ b/drivers/hid/hid-udraw-ps3.c
> @@ -54,7 +54,7 @@ enum {
>   * Accelerometer min/max values
>   * in order, X, Y and Z
>   */
> -struct {
> +static struct {
>         int min;
>         int max;
>  } accel_limits[] = {
> 
> -- 
> Jiri Kosina
> SUSE Labs
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
