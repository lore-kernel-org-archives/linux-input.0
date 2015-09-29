From: Daniel Martin <consume.noise@gmail.com>
Subject: Re: [PATCH 2/2] HID: i2c-hid: Fill in physical device providing HID functionality
Date: Tue, 29 Sep 2015 08:40:44 +0200
Message-ID: <CADscph3bxp0S5JvT9Zx4Ff_pmyJuPq0b2s3PezJezh0Xtsxokg@mail.gmail.com>
References: <1443442508-94971-1-git-send-email-mika.westerberg@linux.intel.com>
	<1443442508-94971-2-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f170.google.com ([209.85.160.170]:35791 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932565AbbI2Gkp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Sep 2015 02:40:45 -0400
Received: by ykdz138 with SMTP id z138so204306954ykd.2
        for <linux-input@vger.kernel.org>; Mon, 28 Sep 2015 23:40:44 -0700 (PDT)
In-Reply-To: <1443442508-94971-2-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input <linux-input@vger.kernel.org>

On 28 September 2015 at 14:15, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> Currently hid_connect() prints out following when I2C connected HID devices
> is connected:
>
>   hid-multitouch 0018:03EB:2136.0001: ... [ATML3432:00 03EB:2136] on
>
> After "on " should read physical device name but it is left empty by the
> driver.
>
> Make it look better and fill in the physical device name.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/hid/i2c-hid/i2c-hid.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index 2871f3c81a4c..10bd8e6e4c9c 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -1028,6 +1028,7 @@ static int i2c_hid_probe(struct i2c_client *client,
>
>         snprintf(hid->name, sizeof(hid->name), "%s %04hX:%04hX",
>                  client->name, hid->vendor, hid->product);
> +       strlcpy(hid->phys, dev_name(&client->dev), sizeof(hid->phys));
>
>         ret = hid_add_device(hid);
>         if (ret) {
> --

Tested and
Reviewed-by: Daniel Martin <consume.noise@gmail.com>
