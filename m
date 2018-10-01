From: Kai Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] HID: i2c-hid: Add a small delay after powering on/off the
 device
Date: Mon, 1 Oct 2018 15:13:35 +0800
Message-ID: <D7895636-743E-4F43-B916-DB4326693A3B@canonical.com>
References: <20181001035313.21453-1-kai.heng.feng@canonical.com>
 <CAO-hwJKhyVjfNsiEK-a16KGPdtfgrtnQ0XgxLyBqUhHVaS8AOA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAO-hwJKhyVjfNsiEK-a16KGPdtfgrtnQ0XgxLyBqUhHVaS8AOA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Hans de Goede <hdegoede@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org


> On Oct 1, 2018, at 3:00 PM, Benjamin Tissoires  
> <benjamin.tissoires@redhat.com> wrote:
>
> On Mon, Oct 1, 2018 at 5:53 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
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
>
> I think you want something similar to
> https://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git/commit/?h=for-next&id=807588ac92018bde88a1958f546438e840eb0158
>
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>>  drivers/hid/i2c-hid/i2c-hid.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
>> index f3076659361a..ff5682cc1bce 100644
>> --- a/drivers/hid/i2c-hid/i2c-hid.c
>> +++ b/drivers/hid/i2c-hid/i2c-hid.c
>> @@ -409,6 +409,8 @@ static int i2c_hid_set_power(struct i2c_client  
>> *client, int power_state)
>>
>>         if (ret)
>>                 dev_err(&client->dev, "failed to change power setting.\n");
>> +       else
>> +               msleep(20);
>
> We shouldn't have this error in the first place, so adding a timeout
> will just add a band-aid on top of an other issue.
>
> I really think the solution from Anisse would work in your case and
> will be nicer.

The Hantick one requires 2.5 seconds delay, the Raydium one requires much  
less.
Also it doesn't have the input shift issue.

So disabling runtime PM entirely is a little overkill in this case.

Maybe there's a better approach?

Kai-Heng

>
> Cheers,
> Benjamin
>
>>  set_pwr_exit:
>>         return ret;
>> --
>> 2.17.1
