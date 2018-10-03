From: Kai Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] HID: i2c-hid: Add a small delay after powering on/off the
 device
Date: Wed, 3 Oct 2018 17:21:07 +0800
Message-ID: <0C967268-A741-47F8-9791-01A94F551AB3@canonical.com>
References: <20181001035313.21453-1-kai.heng.feng@canonical.com>
 <nycvar.YFH.7.76.1810031109200.14430@cbobk.fhfr.pm>
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <nycvar.YFH.7.76.1810031109200.14430@cbobk.fhfr.pm>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org



> On Oct 3, 2018, at 5:10 PM, Jiri Kosina <jikos@kernel.org> wrote:
> 
> On Mon, 1 Oct 2018, Kai-Heng Feng wrote:
> 
>> Raydium touchpanel (2386:4B33) sometimes does not workin desktop session
>> although it works in display manager.
>> 
>> During user logging, the display manager exits, close the HID device,
>> then the device gets runtime suspended and powered off. The desktop
>> session begins shortly after, opens the HID device, then the device gets
>> runtime resumed and powered on.
>> 
>> If the trasition from display manager to desktop sesesion is fast, the
>> touchpanel cannot switch from powered off to powered on in short
>> timeframe. So add a small delay to workaround the issue.
>> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> drivers/hid/i2c-hid/i2c-hid.c | 2 ++
>> 1 file changed, 2 insertions(+)
>> 
>> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
>> index f3076659361a..ff5682cc1bce 100644
>> --- a/drivers/hid/i2c-hid/i2c-hid.c
>> +++ b/drivers/hid/i2c-hid/i2c-hid.c
>> @@ -409,6 +409,8 @@ static int i2c_hid_set_power(struct i2c_client *client, int power_state)
>> 
>> 	if (ret)
>> 		dev_err(&client->dev, "failed to change power setting.\n");
>> +	else
>> +		msleep(20);
> 
> In case there really is no other way around it, at least please add 
> comment explaining why this ugly msleep() is there. Thanks,

I am working on a better approach for this issue, I’ll send a v2 soon.

Kai-Heng

> 
> -- 
> Jiri Kosina
> SUSE Labs
> 
