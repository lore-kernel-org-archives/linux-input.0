From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] hid: logitech: check the return value of create_singlethread_workqueue
Date: Mon, 11 Mar 2019 16:08:51 +0100
Message-ID: <CAO-hwJLwvZvhPPKU7r74xtKsp_P5VBZ2964iQhgBR5zF-ZM7wg@mail.gmail.com>
References: <20190309044345.7018-1-kjlu@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190309044345.7018-1-kjlu@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Kangjie Lu <kjlu@umn.edu>
Cc: pakki001@umn.edu, Jiri Kosina <jikos@kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sat, Mar 9, 2019 at 5:43 AM Kangjie Lu <kjlu@umn.edu> wrote:
>
> create_singlethread_workqueue may fail and return NULL. The fix
> checks if it is NULL to avoid NULL pointer dereference.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/hid/hid-logitech-hidpp.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 15ed6177a7a3..efbc39b92aa2 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -2156,6 +2156,9 @@ static int hidpp_ff_init(struct hidpp_device *hidpp, u8 feature_index)
>
>         /* init the hardware command queue */
>         data->wq = create_singlethread_workqueue("hidpp-ff-sendqueue");
> +       if (!data->wq)
> +               return -ENOMEM;
> +

I agree there is something wrong with the current code, but I think
you are not fixing the issue properly.
The code just above allocates data with kzalloc and stores it in the
hid_device and set up everything. If create_singlethread_workqueue()
fails now, then we are screwed and you need to reverse all of the FF
init.

I think we should move the thread creation above so we are not leaking
memory and not create the FF elements if there is something wrong.

Cheers,
Benjamin

>         atomic_set(&data->workqueue_size, 0);
>
>         /* initialize with zero autocenter to get wheel in usable state */
> --
> 2.17.1
>
