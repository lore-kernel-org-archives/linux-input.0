From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCHv3] HID: i2c-hid: Add sleep between POWER ON and RESET
Date: Fri, 6 Jan 2017 23:02:32 +0100
Message-ID: <20170106220232.GB23721@mail.corp.redhat.com>
References: <20170106081144.GE15702@mail.corp.redhat.com>
 <1483736498-7805-1-git-send-email-redmcg@redmandi.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1483736498-7805-1-git-send-email-redmcg@redmandi.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Brendan McGrath <redmcg@redmandi.dyndns.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Victor Vlasenko <victor.vlasenko@sysgears.com>, Frederik Wenigwieser <frederik.wenigwieser@gmail.com>
List-Id: linux-input@vger.kernel.org

On Jan 07 2017 or thereabouts, Brendan McGrath wrote:
> Support for the Asus Touchpad was recently added. It turns out this
> device can fail initialisation (and become unusable) when the RESET
> command is sent too soon after the POWER ON command.
> 
> Unfortunately the i2c-hid specification does not specify the need for
> a delay between these two commands. But it was discovered the Windows
> driver has a 1ms delay.
> 
> As a result, this patch modifies the i2c-hid module to add a sleep
> inbetween the POWER ON and RESET commands which lasts between 1ms and 5ms.
> 
> See https://github.com/vlasenko/hid-asus-dkms/issues/24 for further
> details.
> 
> Signed-off-by: Brendan McGrath <redmcg@redmandi.dyndns.org>
> ---
> Changes since v2:
>   - added comments to explain the reason for the sleep
> 

Looks good now, thanks!

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/hid/i2c-hid/i2c-hid.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index 844662c..d5288f3 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -426,6 +426,15 @@ static int i2c_hid_hwreset(struct i2c_client *client)
>  	if (ret)
>  		goto out_unlock;
>  
> +	/*
> +	 * The HID over I2C specification states that if a DEVICE needs time
> +	 * after the PWR_ON request, it should utilise CLOCK stretching.
> +	 * However, it has been observered that the Windows driver provides a
> +	 * 1ms sleep between the PWR_ON and RESET requests and that some devices
> +	 * rely on this.
> +	 */
> +	usleep_range(1000, 5000);
> +
>  	i2c_hid_dbg(ihid, "resetting...\n");
>  
>  	ret = i2c_hid_command(client, &hid_reset_cmd, NULL, 0);
> -- 
> 2.7.4
> 
