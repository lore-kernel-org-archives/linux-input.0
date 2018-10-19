From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH] Input: synaptics - avoid using uninitialized variable
 when probing
Date: Fri, 19 Oct 2018 15:46:24 +1000
Message-ID: <20181019054624.GA2783@jelly>
References: <20181017001443.GA232819@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181017001443.GA232819@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Oct 16, 2018 at 05:14:43PM -0700, Dmitry Torokhov wrote:
> synaptics_detect() does not check whether sending commands to the
> device succeeds and instead relies on getting unique data from the
> device. Let's make sure we seed entire buffer with zeroes to make sure
> we not use garbage on stack that just happen to be 0x47.
> 
> Reported-by: syzbot+13cb3b01d0784e4ffc3f@syzkaller.appspotmail.com
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

doh, was just about to send out the same patch.

Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>

Cheers,
   Peter

> ---
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
>  	struct ps2dev *ps2dev = &psmouse->ps2dev;
> -	u8 param[4];
> -
> -	param[0] = 0;
> +	u8 param[4] = { 0 };
>  
>  	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
>  	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
> -- 
> 2.19.1.331.ge82ca0e54c-goog
> 
> 
> -- 
> Dmitry
