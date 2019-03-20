From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: logitech: Handle 0 scroll events for the m560
Date: Wed, 20 Mar 2019 15:29:58 +0100
Message-ID: <CAO-hwJJNzdx6DBj3vxgvnJz3aohtX_PBTP5YLAqAL2Rh4HeN=w@mail.gmail.com>
References: <20190319224823.GA26366@jelly>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190319224823.GA26366@jelly>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, =?UTF-8?B?QWltbyBNZXRzw6Rsw6Q=?= <aimetsal@outlook.com>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Jiri Kosina <jikos@kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Mar 19, 2019 at 11:48 PM Peter Hutterer
<peter.hutterer@who-t.net> wrote:
>
> hidpp_scroll_counter_handle_scroll() doesn't expect a 0-value scroll event, it
> gets interpreted as a negative scroll direction event. This can cause scroll
> direction resets and thus broken scrolling.
>
> Reported-and-tested-by: Aimo Metsälä <aimetsal@outlook.com>
> Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> ---

Added the 'Fixes' and "cc: stable" tags and patch applied to
for-5.1/upstream-fixes

Cheers,
Benjamin

>  drivers/hid/hid-logitech-hidpp.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 15ed6177a7a3..f040c8a7f9a9 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -2608,8 +2608,9 @@ static int m560_raw_event(struct hid_device *hdev, u8 *data, int size)
>                 input_report_rel(mydata->input, REL_Y, v);
>
>                 v = hid_snto32(data[6], 8);
> -               hidpp_scroll_counter_handle_scroll(
> -                               &hidpp->vertical_wheel_counter, v);
> +               if (v != 0)
> +                       hidpp_scroll_counter_handle_scroll(
> +                                       &hidpp->vertical_wheel_counter, v);
>
>                 input_sync(mydata->input);
>         }
> --
> 2.20.1
>
