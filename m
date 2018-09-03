From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] HID: i2c-hid: Don't reset device upon system resume
Date: Mon, 3 Sep 2018 23:54:35 +0800
Message-ID: <F02B6A3A-2584-452A-9A3F-BEF9DB0083E7@canonical.com>
References: <20180831095417.8541-1-benjamin.tissoires@redhat.com>
 <20180903090855.14952-1-kai.heng.feng@canonical.com>
 <CAO-hwJKAiXfvkBKrTDCSZXMFGp0Ygkhq+G2sgT+Qazm7RGx05Q@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAO-hwJKAiXfvkBKrTDCSZXMFGp0Ygkhq+G2sgT+Qazm7RGx05Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, AceLan Kao <acelan.kao@canonical.com>, Aaron Ma <aaron.ma@canonical.com>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Benjamin,

I forgot to include mailing list, first time -in-reply-to user :)

at 17:39, Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:

> On Mon, Sep 3, 2018 at 11:09 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>> Raydium touchscreen triggers interrupt storm after system-wide suspend:
>> [ 179.085033] i2c_hid i2c-CUST0000:00: i2c_hid_get_input: incomplete
>> report (58/65535)
>>
>> According to Raydium, Windows driver does not reset the device after
>> system resume.
>>
>> The HID over I2C spec does specify a reset should be used at
>> intialization, but it doesn't specify if reset is required for system
>> suspend.
>
> Hmm, that would explain a lot, thanks for digging into this.
>
> Jiri, I think this patch should partially replace
> https://patchwork.kernel.org/patch/10583481/
>
> Kai-heng, if you do not need to re-request the HID descriptors, I
> think it should be good to squash these together to:
> - remove I2C_HID_QUIRK_RESEND_REPORT_DESCR
> - remove the re-request the HID descriptors on resume
> - merge with this patch

There's still one user uses I2C_HID_QUIRK_RESEND_REPORT_DESCR,  
USB_DEVICE_ID_SIS10FB_TOUCH.
So I'd like to have an Ack from Hans first.

I'll send a new patch with your suggestion afterward.

>
>
>
>> Tested this patch on other i2c-hid touchpanels I have and those
>> touchpanels do work after S3 without doing reset. If any regression
>> happens to other touchpanel vendors, we can use quirk for Raydium
>> devices.
>>
>> Cc: AceLan Kao <acelan.kao@canonical.com>
>> Cc: Aaron Ma <aaron.ma@canonical.com>
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>>
>> Benjamin, Hans,
>>
>> I guess some vendors interpret spec this way, so hardware reset is an
>> unexpected request for their devices.
>> Can you give this patch a try?
>
> The only device I have that you should not is the Surface 3. And I am
> not so sure it goes into S3 fluently (it seems to, but I am not 100%
> sure). If you have tested on a Dell XPS 9360, I think there is not
> much more I could test.

At least for the Raydium touchscreen, the issue can be observed under both  
S2Idle and S3.
So I guess Surface 3 is still suitable for test if it can do S2Idle.

I've test this on XPS 9370 and Precision 5520, the patch doesn't break them.

Kai-Heng

>
> Cheers,
> Benjamin
>
>>  drivers/hid/i2c-hid/i2c-hid.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
>> index 57126f6837bb..7567034a009f 100644
>> --- a/drivers/hid/i2c-hid/i2c-hid.c
>> +++ b/drivers/hid/i2c-hid/i2c-hid.c
>> @@ -1237,7 +1237,7 @@ static int i2c_hid_resume(struct device *dev)
>>         pm_runtime_enable(dev);
>>
>>         enable_irq(client->irq);
>> -       ret = i2c_hid_hwreset(client);
>> +       ret = i2c_hid_set_power(client, I2C_HID_PWR_ON);
>>         if (ret)
>>                 return ret;
>>
>> --
>> 2.17.1
