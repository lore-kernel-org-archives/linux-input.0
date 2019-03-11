From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH][next] HID: uclogic: remove redudant duplicated null check
 on ver_ptr
Date: Mon, 11 Mar 2019 15:55:39 +0100
Message-ID: <CAO-hwJJXgiLqLCQ+8Cw7Z1=yba0pVkLCkGH8R8HZjNQj=Vg4GA@mail.gmail.com>
References: <20190302222338.8023-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190302222338.8023-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Jiri Kosina <jikos@kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, kernel-janitors@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sat, Mar 2, 2019 at 11:23 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently ver_ptr is being null checked twice, once before calling
> usb_string and once afterwards.  The second null check is redundant
> and can be removed, remove it.
>
> Detected by CoverityScan, CID#1477308 ("Logically dead code")
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Applied to for-5.1/upstream-fixes

Cheers,
Benjamin

>  drivers/hid/hid-uclogic-params.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
> index 7710d9f957da..0187c9f8fc22 100644
> --- a/drivers/hid/hid-uclogic-params.c
> +++ b/drivers/hid/hid-uclogic-params.c
> @@ -735,10 +735,6 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
>                 goto cleanup;
>         }
>         rc = usb_string(udev, 201, ver_ptr, ver_len);
> -       if (ver_ptr == NULL) {
> -               rc = -ENOMEM;
> -               goto cleanup;
> -       }
>         if (rc == -EPIPE) {
>                 *ver_ptr = '\0';
>         } else if (rc < 0) {
> --
> 2.20.1
>
