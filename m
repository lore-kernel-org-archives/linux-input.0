From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] input: xpad: avoid using __set_bit() for capabilities
Date: Tue, 8 May 2018 15:32:23 -0700
Message-ID: <20180508223223.GA129015@dtor-ws>
References: <20180331112143.18768-1-marcus.folkesson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180331112143.18768-1-marcus.folkesson@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, Mar 31, 2018 at 01:21:40PM +0200, Marcus Folkesson wrote:
> input_set_capability() and input_set_abs_param() will do it for you.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  drivers/input/joystick/xpad.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index 9d2688f3f961..cbf54082281d 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -1568,7 +1568,6 @@ static void xpad_close(struct input_dev *dev)
>  static void xpad_set_up_abs(struct input_dev *input_dev, signed short abs)
>  {
>  	struct usb_xpad *xpad = input_get_drvdata(input_dev);
> -	set_bit(abs, input_dev->absbit);

The switch below does not cover all possible values of ABS_*, so I stuck
"default" branch there in case we'll ever have ABS_* that is not covered
explicitly.

Applied, thank you.

>  
>  	switch (abs) {
>  	case ABS_X:
> @@ -1628,10 +1627,7 @@ static int xpad_init_input(struct usb_xpad *xpad)

Thanks.

-- 
Dmitry
