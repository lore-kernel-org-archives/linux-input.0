From: Benjamin Tissoires <btissoir@redhat.com>
Subject: Re: [PATCH v2] alps: Do not divide trackpoint deltas reported by
 hardware by 2 for v7 devices
Date: Thu, 4 Jun 2015 09:54:34 -0400
Message-ID: <20150604135434.GA2495@mail.corp.redhat.com>
References: <1433420780-23213-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1433420780-23213-1-git-send-email-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rico Moorman <rico.moorman@gmail.com>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Jun 04 2015 or thereabouts, Hans de Goede wrote:
> On some v7 devices (e.g. Lenovo-E550) the deltas reported are typically
> only in the 0-1 range dividing this by 2 results in a range of 0-0.
> 
> And even for v7 devices where this does not lead to making the trackstick
> entirely unusable, it makes it twice as slow as before we added v7 support
> and were using the ps/2 mouse emulation of the dual point setup.
> 
> If some kind of generic slowdown is actually necessary for some devices,
> then that belongs in userspace, not in the kernel.
> 
> Cc: stable@vger.kernel.org
> Reported-and-tested-by: Rico Moorman <rico.moorman@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Also remove the comment why we were dividing the delta by 2
> ---

Looks good to me

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>

Cheers,
Benjamin

>  drivers/input/mouse/alps.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index 9bc4343..113d6f1 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -1071,9 +1071,8 @@ static void alps_process_trackstick_packet_v7(struct psmouse *psmouse)
>  	right = (packet[1] & 0x02) >> 1;
>  	middle = (packet[1] & 0x04) >> 2;
>  
> -	/* Divide 2 since trackpoint's speed is too fast */
> -	input_report_rel(dev2, REL_X, (char)x / 2);
> -	input_report_rel(dev2, REL_Y, -((char)y / 2));
> +	input_report_rel(dev2, REL_X, (char)x);
> +	input_report_rel(dev2, REL_Y, -((char)y));
>  
>  	input_report_key(dev2, BTN_LEFT, left);
>  	input_report_key(dev2, BTN_RIGHT, right);
> -- 
> 2.4.2
> 
