Received: from mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763CD4AA3EA
	for <linux-input@vger.kernel.org>; Wed, 16 Sep 2026 12:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561096; cv=none; b=m06QwJVpi1BuI3mIDcH8d4anyDPMZn/RnqQa0hp62f1uZz1Cft53gWY9ZcJCSHsbYM/XSKNM37WVFYwdoXLZWlbJIXhtBPHpFSAd07SD4E2EHtHy14T1soqTFMMZnBRIbmJidQfubsxEUAY2NsrPJ+3OgXXOPJcLUlfpC/5GDfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561096; c=relaxed/simple;
	bh=8UNdUpue5sKwxYXRGKWwuUUlLh8VybcphmQB5BfawQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CyDwMM02HWW+GFkMDncnuJ0mEzFM/d2loG2MHTgITPYdnYZ5CVbIyba0buwBExKmzmtXOCu+pZ99gZkxq6Zx4DY1wE9P987L+4fHkoMAXEYaOgMBP4UuYvOyA0JuWPtp5cfp8a6e8LWNXNPmmM9zVM4FgO7MdTounK3fRM82gC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u4iyJnKa; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u4iyJnKa"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=8UNdUpue5sKwxYXRGKWwuUUlLh8VybcphmQB5BfawQo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789561091; v=1; x=1790165891;
 b=u4iyJnKaBvEALs2nqFLg8I8D7q+dcd1PgSQjI1ERkm5QIRVE9CnT93vmWT9p2NVYntmktvnK
 EkQnTN5y0uT2Ofhgwcxuz8vgW/qdeY97Y0KjO0qOyqPBKhLTYVvQncNjD/nju1Ujon5qXljWGJ+
 S2BirEPntM3gDqC+ro6dZWOk=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f2cb4540f21b2bed;
	Wed, 16 Sep 2026 12:18:11 +0000
X-Mizu-Trace-ID: f2cb4540f21b2bed
X-Migadu-Flow: FLOW_OUT
Message-ID: <39eaa5c2-c22e-4007-bfce-e31f6bfd6b17@linux.dev>
Date: Wed, 16 Sep 2026 14:18:06 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] HID: asus: add support for xgm led
To: Antheas Kapenekakis <lkml@antheas.dev>,
 Denis Benato <benato.denis96@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 "Luke D . Jones" <luke@ljones.dev>, Mateusz Schyboll <dragonn@op.pl>
References: <20260915181200.18086-1-denis.benato@linux.dev>
 <20260915181200.18086-4-denis.benato@linux.dev>
 <CAGwozwHe7dnSi1=NuqeQuXD0FtdPKLJvwyC53ff6LUmRU9Z7SQ@mail.gmail.com>
 <9fd173d2-08c2-4455-b251-27af53db2028@gmail.com>
 <CAGwozwHTZVrrC7zB4oGc3safznXKH3zkHv5EDVSyOYdNGZCpXw@mail.gmail.com>
Content-Language: en-US
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <CAGwozwHTZVrrC7zB4oGc3safznXKH3zkHv5EDVSyOYdNGZCpXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 9/16/26 08:46, Antheas Kapenekakis wrote:
> On Wed, 16 Sept 2026 at 02:54, Denis Benato <benato.denis96@gmail.com> wrote:
>>
>> On 9/15/26 23:52, Antheas Kapenekakis wrote:
>>> On Tue, 15 Sept 2026 at 20:12, Denis Benato <denis.benato@linux.dev> wrote:
>>>> XG mobile stations have very bright leds behind the fan that can be
>>>> turned either ON or OFF: add a cled interface to allow controlling the
>>>> brightness of those red leds.
>>> Hi Denis,
>>> as of last month, I am also the proud owner of a XG Mobile (2025 in my
>>> case). Therefore, I can now comment on this series and give you
>>> feedback.
>>
>> Perhaps. These two devices have nothing in common but the name.
>>
>>> First, I have some interim patches that are not ready yet to post. The
>>> device still has some led behavior that I need to investigate, but I
>>> attach them here for your reference. You may send them on my behalf if
>>> you want to see them sooner though.
>>>
>>> https://github.com/anatase-org/patchwork/commit/af3e5e1755f720a2fffd1b67cb1253e11efbc5bb
>>> https://github.com/anatase-org/patchwork/commit/7718c4b64b03ca9be043e8c56f1833e5c4880fff
>>>
>>> Note that these two patches are essentially a replacement for this
>>> patch essentially, except for the binding, where your device is I2C
>>> where mine is thunderbolt, so that still needs to be added. There are
>>> still leftover issues with the LED I have to investigate before I
>>> submit these patches.
>>>
>>> As you know, USB keyboards in Asus laptops are connected over WMI
>>> through s2idle as well, which is what makes them turn off their
>>> backlight during suspend. However, our devices are external and cannot
>>> use the same path. I suspect that there is a different notifier for
>>> these devices over armoury crate we need to investigate first.
>> Your device is thunderbolt only, but 2022, 2023 and 2024
>> xg mobiles that his patch targets are devices for which the
>> ACPI of laptops supporting this weird connector is full of
>> references to and handling and custom code all over the place.
>>
>> They are nothing alike. They share the name....
>>
>> If I connect mine to my rog ally armoury crate gains a
>> slider that sends the exact same command my patch sends...
>>
>> I couldn't find anything else over USB with wireshark:
>> everything else is ACPI-driven.
>>
>>>> Let the led core manage the power transitions: the classdev is flagged
>>>> with LED_CORE_SUSPENDRESUME, so it is switched off at suspend and its
>>>> last brightness is restored at resume. The EC drives its own blinking
>>>> pattern during s2idle anyway, so the led state while the machine is
>>>> asleep is not meaningful.
>>>>
>>>> Cc: Antheas Kapenekakis <lkml@antheas.dev>
>>>> Signed-off-by: Denis Benato <denis.benato@linux.dev>
>>>> ---
>>>>  drivers/hid/hid-asus.c | 84 ++++++++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 84 insertions(+)
>>>>
>>>> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
>>>> index 03150d29eec5..a427e272563d 100644
>>>> --- a/drivers/hid/hid-asus.c
>>>> +++ b/drivers/hid/hid-asus.c
>>>> @@ -51,6 +51,8 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
>>>>  #define FEATURE_KBD_LED_REPORT_ID1 0x5d
>>>>  #define FEATURE_KBD_LED_REPORT_ID2 0x5e
>>>>
>>>> +#define ROG_XGM_REPORT_SIZE 300
>>> Here, you define an additional report size var. This is not necessary,
>>> as ROG_ALLY_REPORT_SIZE is only used for reads currently in the driver
>>> and we defer to hid core to set the write length. Therefore, you might
>>> increase ROG_ALLY_REPORT_SIZE to 300 universally instead, as a
>>> correctness fix. This way, when Aura devices attempt to write 300
>>> bytes, they still work regardless of the quirk. This is what
>>> af3e5e1755f720a2fffd1b67cb1253e11efbc5bb.
>> I answer to this below, but I want to point out something here:
>> you are right in wanting to join these, but wrong on what to join:
>> the right thing to do is not to join the ALLY_REPORT_SIZE and the
>> XGM report size, but instead to join the  KBD report size and the
>> ally one as one NKEY_REPORT_SIZE since this is exactly what they
>> are: N-KEY devices.
> You are right, NKEY_REPORT_SIZE. This is what my patch did. It was
> late yesterday.

Splendid, now it makes sense. Yeah I'll do it, don't worry about it:
it's on my TODO list and has been for a few months.

>>>> +
>>>>  #define ROG_ALLY_REPORT_SIZE 64
>>>>  #define ROG_ALLY_X_MIN_MCU 313
>>>>  #define ROG_ALLY_MIN_MCU 319
>>>> @@ -144,6 +146,11 @@ struct asus_worker {
>>>>         bool removed;
>>>>  };
>>>>
>>>> +struct asus_xgm_led {
>>>> +       struct led_classdev cdev;
>>>> +       struct hid_device *hdev;
>>>> +};
>>>> +
>>>>  struct asus_touchpad_info {
>>>>         int max_x;
>>>>         int max_y;
>>>> @@ -170,6 +177,7 @@ struct asus_drvdata {
>>>>         unsigned long battery_next_query;
>>>>         struct asus_hid_listener listener;
>>>>         bool fn_lock;
>>>> +       struct asus_xgm_led *xgm_led;
>>>>  };
>>>>
>>>>  static int asus_report_battery(struct asus_drvdata *, u8 *, int);
>>>> @@ -1161,6 +1169,26 @@ static int asus_battery_probe(struct hid_device *hdev)
>>>>         return ret;
>>>>  }
>>>>
>>>> +static int asus_xgm_led_set(struct led_classdev *led_cdev, enum led_brightness value)
>>>> +{
>>>> +       const u8 buf[ROG_XGM_REPORT_SIZE] = {
>>>> +               FEATURE_KBD_LED_REPORT_ID2, 0xC5, (value) ? 0x50 : 0x00
>>>> +       };
>>>> +       struct asus_xgm_led *xgm = container_of(led_cdev, struct asus_xgm_led, cdev);
>>>> +       int ret;
>>>> +
>>>> +       ret = asus_kbd_set_report(xgm->hdev, buf, ROG_XGM_REPORT_SIZE);
>>>> +       if (ret < 0) {
>>>> +               hid_err(xgm->hdev, "Unable to set XG mobile led state: %d\n", ret);
>>>> +               return ret;
>>>> +       } else if (ret != ROG_XGM_REPORT_SIZE) {
>>>> +               hid_err(xgm->hdev, "Unexpected partial transfer to XG mobile: %d\n", ret);
>>>> +               return -EIO;
>>>> +       }
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>> Moreover, as this is an Aura device, and by setting
>>> ROG_XGM_REPORT_SIZE to 300, you can now reuse the initial inits and
>>> brightness handler instead of adding new ones as you did here. This
>>> way, for asus laptops with a wmi handler, the brightness keyboard
>>> shortcut of the device will also control the eGPU, which is preferable
>>> behavior. This is what 7718c4b64b03ca9be043e8c56f1833e5c4880fff does
>>> in part.
>>
>> Absolutely bad idea, trust me: I have recently followed the fix
>> of a regression I introduced sending a 64-bytes command to
>> touchpads that accepts some other length as those stopped
>> working. Doing that is asking for troubles. Listen to who
>> caused the trouble already and make the most out of my
>> mistakes.
>>
>> I also had to make asusctl send exactly 64-bytes commands
>> because of random bugs to zephyrus and strix models.
>> Sending 65 bytes to anime matrix is not a very good idea either.
>>
>> Also Armoury Crate never sends anything different to 64 bytes
>> to N-key devices and I do not want to send anything different
>> than windows does.
>>
>> Do you remember what happens to rainbow on ROG ally if you send
>> commands the MCU doesn't like? I don't want having weird things
>> difficult to debug and nearly impossible to recover from only because
>> the code would look better/be shorter.
>>
>> These devices are fragile in handling, tied to the EC and low lever
>> hardware and I absolutely don't want to diverge from what
>> Armoury Crate does unless there is a very good reason to it.
>>
>> I agree that ASUS devices are somewhat forgiving in accepting
>> different lengths, unlike MSI claws that will not answer to
>> commands until you have sent a number of bytes multiple of
>> the length they want, but this is no reason to toy around this.
>>
>>> I have not tested the common path yet. I have been travelling so I
>>> have not flashed the new kernel on my z13. I have been using the eGPU
>>> with a different device.
>> If with "the new kernel" you mean 7.3 I can tell you it appears
>> d3 is broken and some ASUS laptops stopped entering s2idle...
>>
>>> 7718c4b64b03ca9be043e8c56f1833e5c4880fff also fixes the "blinking
>>> pattern" of the EC, as you note in your subject. With the init,
>>> suspend and resume handlers sending the init of that patch, during
>>> boot the light blinks, it becomes solid once hid-asus binds, then
>>> during the transition to sleep, it starts to blink until it turns red,
>>> and does the reverse during resume. It would be good for you to give
>>> feedback for that. I have not verified the Windows behavior there, and
>>> we should do that for correctness. The init is referenced from
>>> g-helper in Windows, but maybe there is another command that signals
>>> sleep better.
>> 2022, 2023 and 2024 models don't blink outside of s2idle...
>> Because ACPI is all over the place and the device gets informed
>> constantly of what the host is doing.
>>
>> If 2025 models blink until you bind the driver it that means they
>> rely on commands from the windows application... We will need
>> to replicate those as closely as possible.
>>
>> I can ask ASUS if wireshark captures don't shed some lights to it.
> If you can and forward me some info it should be great.

I cannot because that would be covered by my NDA, and
that would take quite a lot of time and depending on the
questions surfacing here I might not even be allowed to
answer so it's hugely better if wireshark is all that is needed.

>>> I do not have an answer to the sleep leds unfortunately. My XG's RGB
>>> stays on while there is a device plugged in, regardless of whether its
>>> sleeping or shutdown. This makes me think that we are missing a
>>> notifier command, and the brightness patch you propose here just
>>> papers over the issue. So we should investigate that first.
>> What I propose is correct for old models. Newer ones I know nothing
>> about except that there is no custom ACPI handling them.
>>
>>
>>> Let me know how you'd like to proceed.
>> Honestly I think you should name those something like xgb_tb_.....
>> and handle them separately since they have pretty much nothing
>> in common... Except the price maybe. Lol.
>>
>> In general don't go crazy over refactors and trying to make the
>> code looks better at the expense of proven things: the priority
>> is for this driver to work reliably and to reuse as much things
>> proven to work as possible.
> Let me simplify. Please try to stay on topic.
>
> My XG Mobile is an Aura device using FEATURE_KBD_LED_REPORT_ID2 with a
> feature report size of 300. Your XG Mobile is an Aura device that uses
> the same. They both have the same sleep issue that you paper over by
> setting the brightness to 0. The LED stays on during sleep. It also
> stays on / off during boot and the power command works inconsistently
> with it. Which points to the device not knowing boot state and missing
> a command to inform it.

I don't see any sleep issue: the resume sometime return to the
old setting and sometimes it doesn't but it always blink s2idle.

Setting the brightness to 0 is pretty much a no-op on these
models and that's why I used the proper flag, but if new models
requires something different you can restore the old code
from me for those models.

Resetting the setting by sending the command is exactly what
Windows does so I'm okay with what I did here.

Yours may very well need other things: just disable the device
in windows driver manager, start wireshark, re-enable the
device and the command will appear there.

> The asusctl driver handles aura devices. However, instead of using the
> current aura cdev handler and init handling you introduce a SECOND ONE
> THAT DOES THE SAME THING and is not connected to the central keyboard
> brightness handler.

The current one is rooted in asus-wmi, has 0-3 brightness and
is for keyboards.

> Why do you do that? Can you justify the new cdev? What's wrong with
> the normal one? Why do we need a new ABI just for the 2022-2024 eGPU
> models?

Yes: new xgm only needs hid-asus, has 0-1 brightness and is for
xg mobile. Code written for kbd_backlight that assumes 0-3
won't work on it.

Also users may very well to be able to control the light of
the xgm separately from kbd_backlight because xgm led
is very bright and it's uncomfortable to look at unlike the
keyboard backlight.

Another reason is that even in windows the lighting of
xgm is a totally separated option with just ON/OFF and
it's what users expect (this patch has been written on
input and capture from a 2022 xgm user on Discord).

As for 2022-2024 eGPU models I don't really mean "do
things in a totally separated manner from 2025": code
can be reused but the code that can be reused might
be a small portion in comparison with what those
may need so I am skeptical in attempting to merge
the two paths entirely without knowing what
new models actually want to receive.

I was suggesting not to try too hard to share the same
code path until you have figured out all required details.

Beside these devices even have a different USB vid:pid
so it's not like what this patch does affects them in any
way unless we want to by using the same quirk.

>
> I am not arguing on which command is correct to send. Keep the flow
> the same if you want
>
> Antheas
>
>>> Best,
>>> Antheas
>>>
>>>
>>>>  static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
>>>>  {
>>>>         struct input_dev *input = hi->input;
>>>> @@ -1406,6 +1434,49 @@ static void asus_initialize_reports(struct hid_device *hdev)
>>>>         }
>>>>  }
>>>>
>>>> +static int asus_xgm_init(struct hid_device *hdev, struct asus_drvdata *drvdata)
>>>> +{
>>>> +       const char *name;
>>>> +       int ret;
>>>> +
>>>> +       drvdata->xgm_led = devm_kzalloc(&hdev->dev, sizeof(*drvdata->xgm_led), GFP_KERNEL);
>>>> +       if (drvdata->xgm_led == NULL)
>>>> +               return -ENOMEM;
>>>> +
>>>> +       name = devm_kasprintf(&hdev->dev, GFP_KERNEL, "asus:xgm-%s:led",
>>>> +                             strlen(hdev->uniq) ? hdev->uniq : dev_name(&hdev->dev));
>>>> +
>>>> +       if (name == NULL) {
>>>> +               ret = -ENOMEM;
>>>> +               goto asus_xgm_init_err;
>>>> +       }
>>>> +
>>>> +       drvdata->xgm_led->hdev = hdev;
>>>> +       drvdata->xgm_led->cdev.name = name;
>>>> +       drvdata->xgm_led->cdev.brightness = 1;
>>>> +       drvdata->xgm_led->cdev.max_brightness = 1;
>>>> +       drvdata->xgm_led->cdev.brightness_set_blocking = asus_xgm_led_set;
>>>> +       drvdata->xgm_led->cdev.flags = LED_CORE_SUSPENDRESUME;
>>>> +
>>>> +       /* LED state is arbitrary on boot, set a default */
>>>> +       ret = asus_xgm_led_set(&drvdata->xgm_led->cdev, drvdata->xgm_led->cdev.brightness);
>>>> +       if (ret) {
>>>> +               hid_err(hdev, "Asus failed to set xgm led: %d\n", ret);
>>>> +               goto asus_xgm_init_err;
>>>> +       }
>>>> +
>>>> +       ret = devm_led_classdev_register(&hdev->dev, &drvdata->xgm_led->cdev);
>>>> +       if (ret) {
>>>> +               hid_err(hdev, "Asus failed to register xgm led: %d\n", ret);
>>>> +               goto asus_xgm_init_err;
>>>> +       }
>>>> +
>>>> +       return 0;
>>>> +asus_xgm_init_err:
>>>> +       drvdata->xgm_led = NULL;
>>>> +       return ret;
>>>> +}
>>>> +
>>>>  static int __maybe_unused asus_resume(struct hid_device *hdev)
>>>>  {
>>>>         struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
>>>> @@ -1545,6 +1616,16 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
>>>>         if (!drvdata->tp)
>>>>                 asus_initialize_reports(hdev);
>>>>
>>>> +       if (asus_has_report_id(hdev, FEATURE_KBD_REPORT_ID) &&
>>>> +           ((hdev->product == USB_DEVICE_ID_ASUSTEK_XGM_2022) ||
>>>> +            (hdev->product == USB_DEVICE_ID_ASUSTEK_XGM_2023))) {
>>>> +               ret = asus_xgm_init(hdev, drvdata);
>>>> +               if (ret) {
>>>> +                       hid_err(hdev, "Failed to initialize xg mobile: %d\n", ret);
>>>> +                       goto err_stop_hw;
>>>> +               }
>>>> +       }
>>>> +
>>>>         /* Laptops keyboard backlight is always at 0x5a */
>>>>         if (is_vendor && (drvdata->quirks & QUIRK_USE_KBD_BACKLIGHT) &&
>>>>             (asus_has_report_id(hdev, FEATURE_KBD_REPORT_ID)) &&
>>>> @@ -1594,6 +1675,9 @@ static void asus_remove(struct hid_device *hdev)
>>>>         if (drvdata->listener.brightness_set)
>>>>                 asus_hid_unregister_listener(&drvdata->listener);
>>>>
>>>> +       if (drvdata->xgm_led)
>>>> +               devm_led_classdev_unregister(&hdev->dev, &drvdata->xgm_led->cdev);
>>>> +
>>>>         asus_worker_stop(drvdata->worker);
>>>>         hid_hw_stop(hdev);
>>>>  }
>>>> --
>>>> 2.47.3
>>>>
>>>>
