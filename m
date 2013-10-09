From: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] HID: i2c-hid: add platform data for quirks
Date: Wed, 9 Oct 2013 12:59:56 +0200
Message-ID: <CAN+gG=Fi2cmJktiUCTT0mBQNnkAFcL8jTctw7EngQh50odQO-g@mail.gmail.com>
References: <1380790121-1355-1-git-send-email-bbasu@nvidia.com>
	<alpine.LNX.2.00.1310091225230.13289@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LNX.2.00.1310091225230.13289-ztGlSCb7Y1iN3ZZ/Hiejyg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: Bibek Basu <bbasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kiran Adduri <kadduri-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, Oct 9, 2013 at 12:26 PM, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org> wrote:
> On Thu, 3 Oct 2013, Bibek Basu wrote:
>
>> Some HID device does not responds to INPUT/FEATURE
>> report query during initialization. As a result HID driver
>> throws error even when its not mandatory according to the
>> HID specification. Add platform data to provide
>> quirk information to the driver so that init query is not
>> done on such devices.
>>
>> Signed-off-by: Bibek Basu <bbasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> ---
>>  drivers/hid/i2c-hid/i2c-hid.c | 1 +
>>  include/linux/i2c/i2c-hid.h   | 3 ++-
>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
>> index fd7ce37..a7aec2c 100644
>> --- a/drivers/hid/i2c-hid/i2c-hid.c
>> +++ b/drivers/hid/i2c-hid/i2c-hid.c
>> @@ -1017,6 +1017,7 @@ static int i2c_hid_probe(struct i2c_client *client,
>>       hid->version = le16_to_cpu(ihid->hdesc.bcdVersion);
>>       hid->vendor = le16_to_cpu(ihid->hdesc.wVendorID);
>>       hid->product = le16_to_cpu(ihid->hdesc.wProductID);
>> +     hid->quirks = platform_data->quirks;
>>
>>       snprintf(hid->name, sizeof(hid->name), "%s %04hX:%04hX",
>>                client->name, hid->vendor, hid->product);
>> diff --git a/include/linux/i2c/i2c-hid.h b/include/linux/i2c/i2c-hid.h
>> index 7aa901d..12e682d 100644
>> --- a/include/linux/i2c/i2c-hid.h
>> +++ b/include/linux/i2c/i2c-hid.h
>> @@ -17,7 +17,7 @@
>>  /**
>>   * struct i2chid_platform_data - used by hid over i2c implementation.
>>   * @hid_descriptor_address: i2c register where the HID descriptor is stored.
>> - *
>> + * @quirks: quirks, if any for i2c-hid devices
>>   * Note that it is the responsibility of the platform driver (or the acpi 5.0
>>   * driver, or the flattened device tree) to setup the irq related to the gpio in
>>   * the struct i2c_board_info.
>> @@ -31,6 +31,7 @@
>>   */
>>  struct i2c_hid_platform_data {
>>       u16 hid_descriptor_address;
>> +     u32 quirks;
>>  };
>

Hi Jiri,

> Umm, and where does the quirks field of platform data actually get set? I
> don't seem to see any followup patchset doing that?

The platform data is filled by specific march-* board definition data.
In this case some I would say a tegra board. So it's fine not having a
patchset setting the quirk (as it is per board, and maybe per
version/manufacturer).

Other than that I would love seeing the same for the device tree
binding if we add this to the struct i2c_hid_platform_data.

BTW, Jiri, the aim of the patch was to be able to add the quirk
HID_QUIRK_NO_INIT_INPUT_REPORTS to some of the i2c-hid devices.
However, the Windows driver uses this by default, so I already told to
Bibek that we could just drop the related calls in
i2c_hid_init_reports().

Cheers,
Benjamin
