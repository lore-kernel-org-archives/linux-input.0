From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: input: support Microsoft wireless radio control hotkey
Date: Fri, 30 Nov 2018 12:18:03 +0100
Message-ID: <CAO-hwJKAnHqPi7aOGqKET+_JKnXmvdwOyhtH4nLeqS+-K8597Q@mail.gmail.com>
References: <20181130064617.67920-1-chiu@endlessm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181130064617.67920-1-chiu@endlessm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: chiu@endlessm.com
Cc: Jiri Kosina <jikos@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, linux@endlessm.com
List-Id: linux-input@vger.kernel.org

On Fri, Nov 30, 2018 at 7:46 AM Chris Chiu <chiu@endlessm.com> wrote:
>
> The ASUS laptops start to support the airplane mode radio management
> to replace the original machanism of airplane mode toggle hotkey.
> On the ASUS P5440FF, it presents as a HID device connecting via
> I2C, name i2c-AMPD0001. When pressing hotkey, the Embedded Controller
> send hid report up via I2C and switch the airplane mode indicator
> LED based on the status.
>
> However, it's not working because it fails to be identified as a
> hidinput device. It fails in hidinput_connect() due to the macro
> IS_INPUT_APPLICATION doesn't identify HID_GD_WIRELESS_RADIO_CTLS
> as a legit application code.
>
> It's easy to add the HID I2C vendor and product id to the quirk
> list and apply HID_QUIRK_HIDINPUT_FORCE to make it work. But it
> can be more generic to support such kind of application on PC.

Sounds good, but while you are at it, can you please:
- fix the kbuild warning
- rewrite the whole line to use macros,
- make the macro prettier by inserting new lines were required
- and define the missing macro:
  0x000d0006 -> HID_DG_WHITEBOARD

Maybe we should keep the ranges definitions with raw values and put a
comment on the side with the names.

Cheers,
Benjamin

>
> Signed-off-by: Chris Chiu <chiu@endlessm.com>
> ---
>  include/linux/hid.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index d44a78362942..f4805f605fed 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -836,7 +836,7 @@ static inline bool hid_is_using_ll_driver(struct hid_device *hdev,
>
>  /* Applications from HID Usage Tables 4/8/99 Version 1.1 */
>  /* We ignore a few input applications that are not widely used */
> -#define IS_INPUT_APPLICATION(a) (((a >= 0x00010000) && (a <= 0x00010008)) || (a == 0x00010080) || (a == 0x000c0001) || ((a >= 0x000d0002) && (a <= 0x000d0006)))
> +#define IS_INPUT_APPLICATION(a) (((a >= 0x00010000) && (a <= 0x00010008)) || (a == 0x00010080) || || (a == 0x0001000c) || (a == 0x000c0001) || ((a >= 0x000d0002) && (a <= 0x000d0006)))
>
>  /* HID core API */
>
> --
> 2.11.0
>
