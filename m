From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [RESEND] Lenovo Yoga 900 touchpad issues
Date: Fri, 18 Dec 2015 17:10:31 +0100
Message-ID: <20151218161031.GB12730@mail.corp.redhat.com>
References: <CAOhV88MGoJdUzty=DDTLOkd7me5uoRWwTTrR8aD=zf5ga0_Hew@mail.gmail.com>
 <20151216092858.GP1762@lahna.fi.intel.com>
 <CAOhV88Mv+RUADPHT5AwD=dR-VdPn7Cmf4TkJoaBjNA4Q6zL6WQ@mail.gmail.com>
 <20151218144209.GK1762@lahna.fi.intel.com>
 <20151218153802.GL1762@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35357 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932151AbbLRQKg (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Dec 2015 11:10:36 -0500
Content-Disposition: inline
In-Reply-To: <20151218153802.GL1762@lahna.fi.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Nish Aravamudan <nish.aravamudan@gmail.com>, Jiri Kosina <jikos@kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Seth Forshee <seth.forshee@canonical.com>, Dan Carpenter <dan.carpenter@oracle.com>, linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Dec 18 2015 or thereabouts, Mika Westerberg wrote:
> On Fri, Dec 18, 2015 at 04:42:09PM +0200, Mika Westerberg wrote:
> > On another occasion the faulty input report was received immediatelly
> > after we call i2c_hid_set_power().
> > 
> > With below hack patch suspend/resume works fine but it is far from being
> > suitable for merging. Still, it would be nice if you could try it out
> > and see if it helps in your case.
> 
> Actually it looks like we can handle this by just ignoring input reports
> while we are resetting the device. Following seems to work as well.

Yes, I like this one better. I think, it is still prone to races, but
it's a much better option.

After turning this around, I think I finally got what was going on (and
yes, it's basically a race that should have been caught long ago):
- during resume, the i2c-hid driver calls reset, which is a long (few
  ms) operation.
- hid-multitouch is also called during resume, and right after i2c-hid
- hid-multiotuch immediately emits for touchpads a set input mode (this
  was unseen with touchscreens because they do not have to be switched
  into a proper mode)
- there is a race between hid-multitouch accessing the features while
  the device is still resetting. And our reset interrupt never gets to
  us because there was an other operation in progress to request/set
  reports

So the actual fix would be to make hid-multitouch wait until we reset
i2c-hid.

This should be done by either a mutex or a spinlock in
i2c_hid_output_raw_report() and i2c_hid_resume() that would protect a
flag set during suspend and cleared after resume.

(not sure if this is clear :-P )

Cheers,
Benjamin

> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index 10bd8e6..eeaf33a 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -352,13 +352,24 @@ static int i2c_hid_set_power(struct i2c_client *client, int power_state)
>  static int i2c_hid_hwreset(struct i2c_client *client)
>  {
>  	struct i2c_hid *ihid = i2c_get_clientdata(client);
> +	bool started;
>  	int ret;
>  
>  	i2c_hid_dbg(ihid, "%s\n", __func__);
>  
> +	/*
> +	 * Some touchpads seem to send input reports once their power is
> +	 * turned back on after resume. This confuses our reset logic
> +	 * below.
> +	 *
> +	 * Prevent handling any input reports while we are resetting the
> +	 * device.
> +	 */
> +	started = test_and_clear_bit(I2C_HID_STARTED, &ihid->flags);
> +
>  	ret = i2c_hid_set_power(client, I2C_HID_PWR_ON);
>  	if (ret)
> -		return ret;
> +		goto out;
>  
>  	i2c_hid_dbg(ihid, "resetting...\n");
>  
> @@ -366,10 +377,14 @@ static int i2c_hid_hwreset(struct i2c_client *client)
>  	if (ret) {
>  		dev_err(&client->dev, "failed to reset device.\n");
>  		i2c_hid_set_power(client, I2C_HID_PWR_SLEEP);
> -		return ret;
> +		goto out;
>  	}
>  
> -	return 0;
> +out:
> +	if (started)
> +		set_bit(I2C_HID_STARTED, &ihid->flags);
> +
> +	return ret;
>  }
>  
>  static void i2c_hid_get_input(struct i2c_hid *ihid)
