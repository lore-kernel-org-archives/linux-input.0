From: Nish Aravamudan <nish.aravamudan@gmail.com>
Subject: Re: [RESEND] Lenovo Yoga 900 touchpad issues
Date: Fri, 18 Dec 2015 09:54:09 -0800
Message-ID: <CAOhV88NeTfdOiNZPAFYot7MxBZzZqWFSxeUq-h2Z9htws4VsWQ@mail.gmail.com>
References: <CAOhV88MGoJdUzty=DDTLOkd7me5uoRWwTTrR8aD=zf5ga0_Hew@mail.gmail.com>
	<20151216092858.GP1762@lahna.fi.intel.com>
	<CAOhV88Mv+RUADPHT5AwD=dR-VdPn7Cmf4TkJoaBjNA4Q6zL6WQ@mail.gmail.com>
	<20151218144209.GK1762@lahna.fi.intel.com>
	<20151218153802.GL1762@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175]:34816 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879AbbLRRyK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Dec 2015 12:54:10 -0500
In-Reply-To: <20151218153802.GL1762@lahna.fi.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Seth Forshee <seth.forshee@canonical.com>, Dan Carpenter <dan.carpenter@oracle.com>, linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Dec 18, 2015 at 7:38 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Fri, Dec 18, 2015 at 04:42:09PM +0200, Mika Westerberg wrote:
>> On another occasion the faulty input report was received immediatelly
>> after we call i2c_hid_set_power().
>>
>> With below hack patch suspend/resume works fine but it is far from being
>> suitable for merging. Still, it would be nice if you could try it out
>> and see if it helps in your case.
>
> Actually it looks like we can handle this by just ignoring input reports
> while we are resetting the device. Following seems to work as well.

FWIW,

Tested-by: Nishanth Aravamudan <nish.aravamudan@gmail.com>

and if you can Cc me on any follow-up/alternative patches, I will be
happy to test those too!

Thanks!
-Nish

> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index 10bd8e6..eeaf33a 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -352,13 +352,24 @@ static int i2c_hid_set_power(struct i2c_client *client, int power_state)
>  static int i2c_hid_hwreset(struct i2c_client *client)
>  {
>         struct i2c_hid *ihid = i2c_get_clientdata(client);
> +       bool started;
>         int ret;
>
>         i2c_hid_dbg(ihid, "%s\n", __func__);
>
> +       /*
> +        * Some touchpads seem to send input reports once their power is
> +        * turned back on after resume. This confuses our reset logic
> +        * below.
> +        *
> +        * Prevent handling any input reports while we are resetting the
> +        * device.
> +        */
> +       started = test_and_clear_bit(I2C_HID_STARTED, &ihid->flags);
> +
>         ret = i2c_hid_set_power(client, I2C_HID_PWR_ON);
>         if (ret)
> -               return ret;
> +               goto out;
>
>         i2c_hid_dbg(ihid, "resetting...\n");
>
> @@ -366,10 +377,14 @@ static int i2c_hid_hwreset(struct i2c_client *client)
>         if (ret) {
>                 dev_err(&client->dev, "failed to reset device.\n");
>                 i2c_hid_set_power(client, I2C_HID_PWR_SLEEP);
> -               return ret;
> +               goto out;
>         }
>
> -       return 0;
> +out:
> +       if (started)
> +               set_bit(I2C_HID_STARTED, &ihid->flags);
> +
> +       return ret;
>  }
>
>  static void i2c_hid_get_input(struct i2c_hid *ihid)
