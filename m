From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] Input: synaptics - avoid using uninitialized variable
 when probing
Date: Wed, 17 Oct 2018 09:03:12 +0200
Message-ID: <CAO-hwJL1QEASk37NuYwkHhmW9N4pGWULnizpHi+4=65OdXe4yQ@mail.gmail.com>
References: <20181017001443.GA232819@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181017001443.GA232819@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, Oct 17, 2018 at 2:14 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> synaptics_detect() does not check whether sending commands to the
> device succeeds and instead relies on getting unique data from the
> device. Let's make sure we seed entire buffer with zeroes to make sure
> we not use garbage on stack that just happen to be 0x47.
>
> Reported-by: syzbot+13cb3b01d0784e4ffc3f@syzkaller.appspotmail.com
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/input/mouse/synaptics.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index 55d33500d55e..5e85f3cca867 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -99,9 +99,7 @@ static int synaptics_mode_cmd(struct psmouse *psmouse, u8 mode)
>  int synaptics_detect(struct psmouse *psmouse, bool set_properties)
>  {
>         struct ps2dev *ps2dev = &psmouse->ps2dev;
> -       u8 param[4];
> -
> -       param[0] = 0;
> +       u8 param[4] = { 0 };
>
>         ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
>         ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
> --
> 2.19.1.331.ge82ca0e54c-goog
>
>
> --
> Dmitry
