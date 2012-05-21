From: Tai-hwa Liang <avatar@sentelic.com>
Subject: Re: [PATCH] input: Force Sentelic reconnect when mode setting has
 failed
Date: Mon, 21 May 2012 23:22:07 +0800 (CST)
Message-ID: <12052123215711.9614@cnaqrzbavhz.fragryvp.pbz>
References: <1337468192-16337-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hermod.sentelic.com ([203.69.18.19]:45031 "EHLO
	hermod.sentelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524Ab2EUPWQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 May 2012 11:22:16 -0400
In-Reply-To: <1337468192-16337-1-git-send-email-mjg@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: os@ohmu.fi, dtor@mail.ru, linux-input@vger.kernel.org

On Sat, 19 May 2012, Matthew Garrett wrote:
> The Sentelic touchpad in an Asus UX-21 failed to work since the native
> driver was merged. Examination showed that the FSP_REG_SWC1 register had
> reverted back to 0x80 and so the pad was sending normal packets despite
> the driver expecting absolute ones.

    Sounds to me that the hardware was reset, which usually happens if
there's intermittent power failure events.  Is there any particular step
to reproduce this unexpected resetting?

> I haven't been able to identify what causes this - dumping the register
> state after ps2 setup shows it set correctly. The easiest workaround seems
> to be to force a reconnect when an unexpected packet type is received.
>
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> ---
> drivers/input/mouse/sentelic.c |   14 ++++++++++++--
> 1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/mouse/sentelic.c b/drivers/input/mouse/sentelic.c
> index 661a0ca..aaabf94 100644
> --- a/drivers/input/mouse/sentelic.c
> +++ b/drivers/input/mouse/sentelic.c
> @@ -687,7 +687,7 @@ static psmouse_ret_t fsp_process_byte(struct psmouse *psmouse)
> 	unsigned char *packet = psmouse->packet;
> 	unsigned char button_status = 0, lscroll = 0, rscroll = 0;
> 	unsigned short abs_x, abs_y, fgrs = 0;
> -	int rel_x, rel_y;
> +	int rel_x, rel_y, packet_type;
>
> 	if (psmouse->pktcnt < 4)
> 		return PSMOUSE_GOOD_DATA;
> @@ -698,7 +698,17 @@ static psmouse_ret_t fsp_process_byte(struct psmouse *psmouse)
>
> 	fsp_packet_debug(psmouse, packet);
>
> -	switch (psmouse->packet[0] >> FSP_PKT_TYPE_SHIFT) {
> +	packet_type = psmouse->packet[0] >> FSP_PKT_TYPE_SHIFT;
> +
> +	if (ad->ver >= FSP_VER_STL3888_C0 && packet_type != FSP_PKT_TYPE_ABS) {
> +		psmouse_warn(psmouse,
> +			     "Incorrect packet type %x, reconnecting\n",
> +			     packet_type);
> +		serio_reconnect(psmouse->ps2dev.serio);
> +		return PSMOUSE_FULL_PACKET;
> +	}
> +
> +	switch (packet_type) {
> 	case FSP_PKT_TYPE_ABS:
> 		abs_x = GET_ABS_X(packet);
> 		abs_y = GET_ABS_Y(packet);
