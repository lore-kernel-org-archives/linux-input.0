From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] ELAN touchpad i2c_hid bugs fix
Date: Wed, 20 Mar 2019 15:37:16 +0100
Message-ID: <CAO-hwJLGABHATo-fOc_jgc8uNeLDv7cemsHuQMj7zRJWmfyp4g@mail.gmail.com>
References: <LaQHUFs--3-1@tutanota.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <LaQHUFs--3-1@tutanota.com>
Sender: linux-kernel-owner@vger.kernel.org
To: hotwater438@tutanota.com
Cc: Jiri Kosina <jikos@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Kai Heng Feng <kai.heng.feng@canonical.com>, Stephen Boyd <swboyd@chromium.org>, bigeasy@linutronix.de, Dmitry Torokhov <dtor@chromium.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Vladislav,

I really appreciate the contribution, there are a few issues with the
formatting of the patch, thanks for taking care of those (I'll inline
the problems).

On Wed, Mar 20, 2019 at 2:28 PM <hotwater438@tutanota.com> wrote:
>
> Desciption: This patch add's additional quirk to force
> IRQ_TRIGGER_FALLING flag which resolves issues with ELAN1200:04F3:303E
> touchpad. Issues are the next:
> - Journalctl floods with next report:
> i2c_hid i2c-ELAN1200:00: i2c_hid_get_input: incomplete report (16/65535)
> - Five finger tap kills i2c_hid
> - When you scroll anything, and release one finger, driver thought you are still scrolling

You don't need to be that "formal" in the commit message.
The "description" part describes too much what the patch is (while we
can just read the code), the important part is the issues you are
fixing.

I'd like you to rewrite this in a way that doesn't feel like you are
writing a bug report.

For instance, you could write (but you can change this too):
---
The ELAN1200:04F3:303E touchpad exposes several issues, all caused by
an error setting the correct IRQ_TRIGGER flag:
- ...
- ...
- ...

Fix all of these with a new quirk that corrects the trigger flag
announced by the ACPI tables.
---

I know writing good commit message is a tricky part :)

>
> The reason why i2c_hid_init_irq was moved is told by Hans De Goede
> <hdegoede@redhat.com>:
> i2c_hid_init_irq now checks for a quirk, so we must setup the quirks before we init the irq, and we cannot setup the quirk earlier, so we must init the irq later.

I am pretty sure you can paraphrase Hans in your commit message
without having to formally quote him (Hans, please shout if you
disagree).
But this is a definitively good point to raise: your patch touches a
general path, so it might have unexpected issues if not carefully
reviewed by us.

>
>
> Patch is created by help of ELANTECH and RedHat guys (Hans De Goede <hdegoede@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, Andy Shevchenko <andy.shevchenko@gmail.com>) and me (Vladislav Dalechyn <hotwater438@tutanota.com>.

Don't take it wrong, but that's not how we give credit in a patch.
In your case, if you do not have any Elantech engineer who agreed to
sign off the patch, you can definitively mention them this way.
But the other guys (Hans, Andy and myself) are well known kernel
developers in the input and HID subsystems, so we usually take the
fame by adding our Reviewed-by or Signed-off-by tag at the end of the
commit message. (Also note that Andy is working for Intel ;-P )

If you feel that these persons have an equal participation in the
creation of the patch, you should ask for their Signed-off-by in the
patch. My gut feelings tell me they would gladly give a Reviewed-by
because they helped you on the patch, but they are not the "author",
so the Signed-off-by should be you only.

And yes, you should sign your work here saying that you wrote this
code in accordance to the Developer's Certificate of Origin 1.1
(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst)

Then, either Jiri or myself will have a special role, and we will add
our own signed-of-by as the maintainers of the HID tree certifying
that this patch has been accepted by one of us.

>
> ---
> drivers/hid/hid-ids.h              |  1 +
> drivers/hid/i2c-hid/i2c-hid-core.c | 17 +++++++++++------
> 2 files changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index b6d93f4ad037..dc44b5661669 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -389,6 +389,7 @@
> #define USB_DEVICE_ID_TOSHIBA_CLICK_L9W 0x0401
> #define USB_DEVICE_ID_HP_X2 0x074d
> #define USB_DEVICE_ID_HP_X2_10_COVER 0x0755
> +#define USB_DEVICE_ID_ELAN_TOUCHPAD 0x303e

I know Hans wanted you to use USB here, but I'd think we should have a
I2C_DEVICE_ID_*
There is no guarantees that this same PID will be used in a different
chip over USB.
We tend to not car about USB/I2C for the vendor IDs: the vendors
decided to reuse their USB VID, which makes our life easier.

>
> #define USB_VENDOR_ID_ELECOM 0x056e
> #define USB_DEVICE_ID_ELECOM_BM084 0x0061
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
> index 90164fed08d3..16b55c45e2e8 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -50,7 +50,8 @@
> #define I2C_HID_QUIRK_NO_IRQ_AFTER_RESET BIT(1)
> #define I2C_HID_QUIRK_NO_RUNTIME_PM BIT(2)
> #define I2C_HID_QUIRK_DELAY_AFTER_SLEEP BIT(3)
> -#define I2C_HID_QUIRK_BOGUS_IRQ BIT(4)
> +#define I2C_HID_QUIRK_BOGUS_IRQ BIT(4)

your mail client is playing with tabs and spaces, but I don't expect
the line above to be changed at all.

> +#define I2C_HID_QUIRK_FORCE_TRIGGER_FALLING BIT(5)
>
> /* flags */
> #define I2C_HID_STARTED 0
> @@ -182,8 +183,10 @@ static const struct i2c_hid_quirks {
> I2C_HID_QUIRK_NO_RUNTIME_PM },
> { I2C_VENDOR_ID_GOODIX, I2C_DEVICE_ID_GOODIX_01F0,
> I2C_HID_QUIRK_NO_RUNTIME_PM },
> + { USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHPAD,
> + I2C_HID_QUIRK_BOGUS_IRQ | I2C_HID_QUIRK_FORCE_TRIGGER_FALLING },
> { USB_VENDOR_ID_ELAN, HID_ANY_ID,
> - I2C_HID_QUIRK_BOGUS_IRQ },
> + I2C_HID_QUIRK_BOGUS_IRQ },

same here, this line should not be changed.


> { 0, 0 }
> };
>
> @@ -854,6 +857,8 @@ static int i2c_hid_init_irq(struct i2c_client *client)
>
> if (!irq_get_trigger_type(client->irq))
> irqflags = IRQF_TRIGGER_LOW;
> + if (ihid->quirks & I2C_HID_QUIRK_FORCE_TRIGGER_FALLING)
> + irqflags = IRQF_TRIGGER_FALLING;

again, indentation problems, tabs are missing

>
> ret = request_threaded_irq(client->irq, NULL, i2c_hid_irq,
>    irqflags | IRQF_ONESHOT, client->name, ihid);
> @@ -1123,10 +1128,6 @@ static int i2c_hid_probe(struct i2c_client *client,
> if (ret < 0)
> goto err_pm;
>
> - ret = i2c_hid_init_irq(client);
> - if (ret < 0)
> - goto err_pm;
> -
> hid = hid_allocate_device();
> if (IS_ERR(hid)) {
> ret = PTR_ERR(hid);

the next call is "goto err_irq", which should be changed to "goto err_pm"

> @@ -1149,6 +1150,10 @@ static int i2c_hid_probe(struct i2c_client *client,
>
> ihid->quirks = i2c_hid_lookup_quirk(hid->vendor, hid->product);
>
> + ret = i2c_hid_init_irq(client);
> + if (ret < 0)
> + goto err_pm;

this should be "err_mem_free"

> +
> ret = hid_add_device(hid);
> if (ret) {
> if (ret != -ENODEV)

next one should be "err_irq"

and the err_irq and err_mem_free should be inverted at the end of probe.

Cheers,
Benjamin

> --
> 2.20.1
>
