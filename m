From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/2] Input: silead - Add support for capactive home
 button found on some x86 tablets
Date: Tue, 17 Oct 2017 13:13:52 -0700
Message-ID: <CAKdAkRT63uOtsFS-+WuOuzZSGVHPRxDFLg7oCJZkwbA6uBPr4w@mail.gmail.com>
References: <20171017154512.30524-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20171017154512.30524-1-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Hans,

On Tue, Oct 17, 2017 at 8:45 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> On some x86 tablets with a silead touchscreen the windows logo on the
> front is a capacitive home button. Touching this button results in a touch
> with bits 12-15 of the Y coordinates set, while normally only the lower 12
> are used.
>
> Detect this and report a KEY_LEFTMETA press when this happens. Note for
> now we only respond to the Y coordinate bits 12-15 containing 0x01, on some
> tablets *without* a capacative button I've noticed these bits containing
> 0x04 when crossing the edges of the screen.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Only enable support for the home-button if a "silead,home-button"
>  boolean device-property is set on the device

You need to add this new property to
Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
and CC Rob.

Thanks!

-- 
Dmitry
