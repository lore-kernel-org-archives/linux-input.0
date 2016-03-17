From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] HID: wiimote: Fix wiimote mp scale linearization
Date: Thu, 17 Mar 2016 10:22:21 +0100
Message-ID: <CANq1E4SOSEoUrS6urxb98LD5VGmGSb5+FmaUb5-E6FsTTVMuBw@mail.gmail.com>
References: <1458147581-4126-1-git-send-email-cyan.ogilvie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458147581-4126-1-git-send-email-cyan.ogilvie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Cyan Ogilvie <cyan.ogilvie@gmail.com>
Cc: David Herrmann <dh.herrmann@googlemail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi

On Wed, Mar 16, 2016 at 5:59 PM, Cyan Ogilvie <cyan.ogilvie@gmail.com> wrote:
> The wiimote motion plus gyros use two scales to report fast and slow
> rotation - below 440 deg/s uses 8192/440 units / deg/s, and above uses
> 8192/2000 units / deg/s.
>
> Previously this driver attempted to linearize the two by scaling the fast
> rate by 18 and the slow by 9, but this results in a scale of
> 8192*9/440 = ~167.564 for slow and 8192*18/2000 = 73.728 for fast.
>
> Correct the fast motion scale factor so that both report ~167.564
> units / deg/s
>
> Signed-off-by: Cyan Ogilvie <cyan.ogilvie@gmail.com>
> ---
>  drivers/hid/hid-wiimote-modules.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
> index 4390eee..c830ed3 100644
> --- a/drivers/hid/hid-wiimote-modules.c
> +++ b/drivers/hid/hid-wiimote-modules.c
> @@ -2049,9 +2049,11 @@ static void wiimod_mp_in_mp(struct wiimote_data *wdata, const __u8 *ext)
>          *   -----+------------------------------+-----+-----+
>          * The single bits Yaw, Roll, Pitch in the lower right corner specify
>          * whether the wiimote is rotating fast (0) or slow (1). Speed for slow
> -        * roation is 440 deg/s and for fast rotation 2000 deg/s. To get a
> -        * linear scale we multiply by 2000/440 = ~4.5454 which is 18 for fast
> -        * and 9 for slow.

Oh dear! My initial reasoning was completely off. I somehow upscaled
4.5 to 18, and 1 to 9, when it should have been 1 to 4. Oops!

> +        * roation is 8192/440 units / deg/s and for fast rotation 8192/2000
> +        * units / deg/s. To get a linear scale for fast rotation we multiply
> +        * by 2000/440 = ~4.5454 and scale both fast and slow by 9 to match the
> +        * previous scale reported by this driver.
> +        * This leaves a linear scale with 8192*9/440 (~167.564) units / deg/s.
>          * If the wiimote is not rotating the sensor reports 2^13 = 8192.
>          * Ext specifies whether an extension is connected to the motionp.
>          * which is parsed by wiimote-core.
> @@ -2070,15 +2072,15 @@ static void wiimod_mp_in_mp(struct wiimote_data *wdata, const __u8 *ext)
>         z -= 8192;
>
>         if (!(ext[3] & 0x02))
> -               x *= 18;
> +               x = (x * 2000 * 9) / 440;
>         else
>                 x *= 9;
>         if (!(ext[4] & 0x02))
> -               y *= 18;
> +               y = (y * 2000 * 9) / 440;
>         else
>                 y *= 9;
>         if (!(ext[3] & 0x01))
> -               z *= 18;
> +               z = (z * 2000 * 9) / 440;

So 2000/440 ~= 4.5, so this is exactly what the initial comment said.
Patch looks good to me:

Reviewed-by: David Herrmann <dh.herrmann@gmail.com>

Thanks
David

>         else
>                 z *= 9;
>
> --
> 2.1.4
>
