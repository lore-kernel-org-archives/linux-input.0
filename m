From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH][next] HID: quirks: make array hid_quirks static
Date: Mon, 4 Dec 2017 13:26:03 +0100
Message-ID: <CAO-hwJJBtma8K2Z6w_J-SHQbR++ptDsUjPnO3EG8tOYhCxoJUg@mail.gmail.com>
References: <20171204111910.2840-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20171204111910.2840-1-colin.king@canonical.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Dec 4, 2017 at 12:19 PM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Array hid_quirks is local to the source and does not need to be in
> global scope, so make it static.
>
> Cleans up sparse warning:
> drivers/hid/hid-quirks.c:29:28: warning: symbol 'hid_quirks' was not
> declared. Should it be static?
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Sounds good.
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/hid/hid-quirks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> index 1cf1e9a0d699..627efb74d1e4 100644
> --- a/drivers/hid/hid-quirks.c
> +++ b/drivers/hid/hid-quirks.c
> @@ -26,7 +26,7 @@
>   * Alphabetically sorted by vendor then product.
>   */
>
> -const struct hid_device_id hid_quirks[] = {
> +static const struct hid_device_id hid_quirks[] = {
>         { HID_USB_DEVICE(USB_VENDOR_ID_AASHIMA, USB_DEVICE_ID_AASHIMA_GAMEPAD), HID_QUIRK_BADPAD },
>         { HID_USB_DEVICE(USB_VENDOR_ID_AASHIMA, USB_DEVICE_ID_AASHIMA_PREDATOR), HID_QUIRK_BADPAD },
>         { HID_USB_DEVICE(USB_VENDOR_ID_AFATECH, USB_DEVICE_ID_AFATECH_AF9016), HID_QUIRK_FULLSPEED_INTERVAL },
> --
> 2.14.1
>
