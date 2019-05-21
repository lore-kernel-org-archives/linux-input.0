From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: multitouch: handle faulty Elo touch device
Date: Tue, 21 May 2019 15:50:27 +0200
Message-ID: <CAO-hwJJfRXEdwMq9KLXDMs37CnHXnVhUzD5sbd5uzoeVdKQdvw@mail.gmail.com>
References: <20190521133831.4436-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190521133831.4436-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Breno Leitao <leitao@debian.org>
List-Id: linux-input@vger.kernel.org

On Tue, May 21, 2019 at 3:38 PM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> Since kernel v5.0, one single win8 touchscreen device failed.
> And it turns out this is because it reports 2 InRange usage per touch.
>
> It's a first, and I *really* wonder how this was allowed by Microsoft in
> the first place. But IIRC, Breno told me this happened *after* a firmware
> upgrade...
>
> Anyway, better be safe for those crappy devices, and make sure we have
> a full slot before jumping to the next.
> This won't prevent all crappy devices to fail here, but at least we will
> have a safeguard as long as the contact ID and the X and Y coordinates
> are placed in the report after the grabage.

Grmbl, I forgot:
Fixes: 01eaac7e5713 ("HID: multitouch: remove one copy of values")
CC: stable@vger.kernel.org # v5.0+

Cheers,
Benjamin

>
> Reported-and-tested-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  drivers/hid/hid-multitouch.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index ef635964cfe1..a344a3cf5398 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -642,6 +642,13 @@ static void mt_store_field(struct hid_device *hdev,
>         if (*target != DEFAULT_TRUE &&
>             *target != DEFAULT_FALSE &&
>             *target != DEFAULT_ZERO) {
> +               if (usage->contactid == DEFAULT_ZERO ||
> +                   usage->x == DEFAULT_ZERO ||
> +                   usage->y == DEFAULT_ZERO) {
> +                       hid_dbg(hdev,
> +                               "ignoring duplicate usage on incomplete");
> +                       return;
> +               }
>                 usage = mt_allocate_usage(hdev, application);
>                 if (!usage)
>                         return;
> --
> 2.19.2
>
