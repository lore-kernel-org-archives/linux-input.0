From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/1] Input - alps: Fix button reporting on the V2 Alps
 protocol
Date: Thu, 30 Jul 2015 15:51:25 +0200
Message-ID: <55BA2BDD.90108@redhat.com>
References: <CANuv8QwPQ1aLvZkC522vmm+_kv7r+f3rwvc=SmjVOvx5XbQUzw@mail.gmail.com>
 <1438202726-5100-1-git-send-email-cpaul@redhat.com>
 <1438202726-5100-2-git-send-email-cpaul@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34107 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752180AbbG3Nv2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Jul 2015 09:51:28 -0400
In-Reply-To: <1438202726-5100-2-git-send-email-cpaul@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: cpaul@redhat.com, Douglas Christman <douglaschristman@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi Chandler,

On 29-07-15 22:45, cpaul@redhat.com wrote:
> From: Stephen Chandler Paul <cpaul@redhat.com>
>
> The data concerning which buttons on the touchpad are held down or not
> are in the fourth packet we receive from the mouse, not the first.
>
> Signed-off-by: Stephen Chandler Paul <cpaul@redhat.com>
> ---
>   drivers/input/mouse/alps.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index 113d6f1..e2f9b25 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -254,9 +254,9 @@ static void alps_process_packet_v1_v2(struct psmouse *psmouse)
>   	/* Non interleaved V2 dualpoint has separate stick button bits */
>   	if (priv->proto_version == ALPS_PROTO_V2 &&
>   	    priv->flags == (ALPS_PASS | ALPS_DUALPOINT)) {
> -		left |= packet[0] & 1;
> -		right |= packet[0] & 2;
> -		middle |= packet[0] & 4;
> +		left |= packet[3] & 1;
> +		right |= packet[3] & 2;
> +		middle |= packet[3] & 4;
>   	}
>
>   	alps_report_buttons(dev, dev2, left, right, middle);

Thanks for taking a look at the recordings, but the above patch is wrong,
if you look slightly higher in the lps_process_packet_v1_v2() function there
is this:

if (priv->proto_version == ALPS_PROTO_V1) {
...
} else {
	left = packet[3] & 1;
	right = packet[3] & 2;
	middle = packet[3] & 4;
}

So with your patch for the devices in question the entire code flow
becomes:

	left = packet[3] & 1;
	right = packet[3] & 2;
	middle = packet[3] & 4;
	left |= packet[3] & 1;
	right |= packet[3] & 2;
	middle |= packet[3] & 4;

Which is not really helpful for the devices for which I added
commit 92bac83dd:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/input/mouse/alps.c?id=92bac83dd79e60e65c475222e41a992a70434beb

and will cause these devices to regress.

Since Hans de Bruin's laptop is a Dell Latitude D430 and I saw
the same problem and tested my patch on a Dell Latitude D630,
it seems the use of the low bits of packet[0] to report the
trackpoint buttons separately when the touchpad is active is
a Dell specific thing, so I believe that a patch to only
activate this code block on Dell's is the right solution for
the regression Douglas is seeing.

I'll write such a patch and post it shortly.

Regards,

Hans



