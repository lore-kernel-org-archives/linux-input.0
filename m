From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: i2c-hid: Prevent sending reports from racing with
 device reset
Date: Mon, 21 Dec 2015 15:13:01 +0100
Message-ID: <20151221141259.GA21704@mail.corp.redhat.com>
References: <1450704391-47008-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1450704391-47008-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, Nish Aravamudan <nish.aravamudan@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Seth Forshee <seth.forshee@canonical.com>, Dan Carpenter <dan.carpenter@oracle.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Dec 21 2015 or thereabouts, Mika Westerberg wrote:
> When an i2c-hid device is resumed from system sleep the driver resets
> the device to be sure it is in known state. The device is expected to
> issue an interrupt when reset is complete.
> 
> This reset might take few milliseconds to complete so if the HID driver
> on top (hid-rmi) starts to set up the device by sending feature reports
> etc. the device might not issue the reset complete interrupt anymore.
> 
> Below is what happens to touchpad on Lenovo Yoga 900 during resume from
> system sleep:
> 
>   [   24.790951] i2c_hid i2c-SYNA2B29:00: i2c_hid_hwreset
>   [   24.790973] i2c_hid i2c-SYNA2B29:00: i2c_hid_set_power
>   [   24.790982] i2c_hid i2c-SYNA2B29:00: __i2c_hid_command: cmd=22 00 00 08
>   [   24.793011] i2c_hid i2c-SYNA2B29:00: resetting...
>   [   24.793016] i2c_hid i2c-SYNA2B29:00: __i2c_hid_command: cmd=22 00 00 01
> 
> Here i2c-hid sends reset command to the touchpad.
> 
>   [   24.794012] i2c_hid i2c-SYNA2B29:00: input: 06 00 01 00 00 00
>   [   24.794051] i2c_hid i2c-SYNA2B29:00: i2c_hid_set_or_send_report
>   [   24.794059] i2c_hid i2c-SYNA2B29:00: __i2c_hid_command:
>                  cmd=22 00 3f 03 0f 23 00 04 00 0f 01
> 
> Now hid-rmi puts the touchpad to correct mode by sending it a feature
> report. This makes the touchpad not to issue reset complete interrupt.
> 
>   [   24.796092] i2c_hid i2c-SYNA2B29:00: __i2c_hid_command: waiting...
> 
> i2c-hid starts to wait for the reset interrupt to trigger which never
> happens.
> 
>   [   24.798304] i2c_hid i2c-SYNA2B29:00: i2c_hid_set_or_send_report
>   [   24.798313] i2c_hid i2c-SYNA2B29:00: __i2c_hid_command:
>                  cmd=25 00 17 00 09 01 42 00 2e 00 19 19 00 10 cc 06 74 04 0f
>                      19 00 00 00 00 00
> 
> Yet another output report from hid-rmi driver.
> 
>   [   29.795630] i2c_hid i2c-SYNA2B29:00: __i2c_hid_command: finished.
>   [   29.795637] i2c_hid i2c-SYNA2B29:00: failed to reset device.
> 
> After 5 seconds i2c-hid driver times out.
> 
>   [   29.795642] i2c_hid i2c-SYNA2B29:00: i2c_hid_set_power
>   [   29.795649] i2c_hid i2c-SYNA2B29:00: __i2c_hid_command: cmd=22 00 01 08
>   [   29.797576] dpm_run_callback(): i2c_hid_resume+0x0/0xb0 returns -61
>   [   29.797584] PM: Device i2c-SYNA2B29:00 failed to resume: error -61
> 
> After this the touchpad does not work anymore (and also resume itself
> gets slowed down because of the timeout).
> 
> Prevent sending of feature/output reports while the device is being
> reset by adding a mutex which is held during that time.
> 
> Reported-by: Nish Aravamudan <nish.aravamudan@gmail.com>
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Suggested-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---

Looks good to me.

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Thanks for the patch Mika!

Cheers,
Benjamin

>  drivers/hid/i2c-hid/i2c-hid.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index 10bd8e6e4c9c..fc5ef1c25ed4 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -151,6 +151,7 @@ struct i2c_hid {
>  	struct i2c_hid_platform_data pdata;
>  
>  	bool			irq_wake_enabled;
> +	struct mutex		reset_lock;
>  };
>  
>  static int __i2c_hid_command(struct i2c_client *client,
> @@ -356,9 +357,16 @@ static int i2c_hid_hwreset(struct i2c_client *client)
>  
>  	i2c_hid_dbg(ihid, "%s\n", __func__);
>  
> +	/*
> +	 * This prevents sending feature reports while the device is
> +	 * being reset. Otherwise we may lose the reset complete
> +	 * interrupt.
> +	 */
> +	mutex_lock(&ihid->reset_lock);
> +
>  	ret = i2c_hid_set_power(client, I2C_HID_PWR_ON);
>  	if (ret)
> -		return ret;
> +		goto out_unlock;
>  
>  	i2c_hid_dbg(ihid, "resetting...\n");
>  
> @@ -366,10 +374,11 @@ static int i2c_hid_hwreset(struct i2c_client *client)
>  	if (ret) {
>  		dev_err(&client->dev, "failed to reset device.\n");
>  		i2c_hid_set_power(client, I2C_HID_PWR_SLEEP);
> -		return ret;
>  	}
>  
> -	return 0;
> +out_unlock:
> +	mutex_unlock(&ihid->reset_lock);
> +	return ret;
>  }
>  
>  static void i2c_hid_get_input(struct i2c_hid *ihid)
> @@ -587,12 +596,15 @@ static int i2c_hid_output_raw_report(struct hid_device *hid, __u8 *buf,
>  		size_t count, unsigned char report_type, bool use_data)
>  {
>  	struct i2c_client *client = hid->driver_data;
> +	struct i2c_hid *ihid = i2c_get_clientdata(client);
>  	int report_id = buf[0];
>  	int ret;
>  
>  	if (report_type == HID_INPUT_REPORT)
>  		return -EINVAL;
>  
> +	mutex_lock(&ihid->reset_lock);
> +
>  	if (report_id) {
>  		buf++;
>  		count--;
> @@ -605,6 +617,8 @@ static int i2c_hid_output_raw_report(struct hid_device *hid, __u8 *buf,
>  	if (report_id && ret >= 0)
>  		ret++; /* add report_id to the number of transfered bytes */
>  
> +	mutex_unlock(&ihid->reset_lock);
> +
>  	return ret;
>  }
>  
> @@ -990,6 +1004,7 @@ static int i2c_hid_probe(struct i2c_client *client,
>  	ihid->wHIDDescRegister = cpu_to_le16(hidRegister);
>  
>  	init_waitqueue_head(&ihid->wait);
> +	mutex_init(&ihid->reset_lock);
>  
>  	/* we need to allocate the command buffer without knowing the maximum
>  	 * size of the reports. Let's use HID_MIN_BUFFER_SIZE, then we do the
> -- 
> 2.6.4
> 
