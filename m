From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Input: ALPS - Fix TrackStick support for SS5 hardware
Date: Tue, 1 Nov 2016 10:35:07 +0100
Message-ID: <20161101093507.GE3081@pali>
References: <20161024210122.GA2919@TopQuark.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35105 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1168251AbcKAJfL (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 1 Nov 2016 05:35:11 -0400
Received: by mail-wm0-f67.google.com with SMTP id 68so15163041wmz.2
        for <linux-input@vger.kernel.org>; Tue, 01 Nov 2016 02:35:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20161024210122.GA2919@TopQuark.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Donohue <linux-kernel@PaulSD.com>
Cc: linux-input@vger.kernel.org, Ben Gamari <ben@smart-cactus.org>, Michal Hocko <mhocko@suse.com>

On Monday 24 October 2016 17:01:22 Paul Donohue wrote:
> The current Alps SS5 (SS4 v2) code generates bogus TouchPad events when 
> TrackStick packets are processed.
> 
> This causes the xorg synaptics driver to print 
> "unable to find touch point 0" and 
> "BUG: triggered 'if (priv->num_active_touches > priv->num_slots)'" 
> messages.  It also causes unexpected TouchPad button release and reclick 
> event sequences if the TrackStick is moved while holding a TouchPad 
> button.
> 
> This commit corrects the problem by setting a flag for the relevant 
> packet type in alps_decode_ss4_v2(), then using that flag in 
> alps_process_packet_ss4_v2() to send only TrackStick reports when 
> processing TrackStick packets.
> 
> Signed-off-by: Paul Donohue <linux-kernel@PaulSD.com>
> 
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index 6d7de9b..2c2e55b 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -1279,6 +1279,8 @@ static int alps_decode_ss4_v2(struct alps_fields *f,
>                         input_report_rel(priv->dev2, REL_Y, -y);
>                         input_report_abs(priv->dev2, ABS_PRESSURE, pressure);
>                 }
> +               f->first_mp = 0;
> +               f->is_mp = 0;
>                 break;
>  
>         case SS4_PACKET_ID_IDLE:
> @@ -1289,12 +1291,14 @@ static int alps_decode_ss4_v2(struct alps_fields *f,
>  
>         /* handle buttons */
>         if (pkt_id == SS4_PACKET_ID_STICK) {
> +               f->is_ts = 1;
>                 f->ts_left = !!(SS4_BTN_V2(p) & 0x01);
>                 if (!(priv->flags & ALPS_BUTTONPAD)) {
>                         f->ts_right = !!(SS4_BTN_V2(p) & 0x02);
>                         f->ts_middle = !!(SS4_BTN_V2(p) & 0x04);
>                 }
>         } else {
> +               f->is_ts = 0;
>                 f->left = !!(SS4_BTN_V2(p) & 0x01);
>                 if (!(priv->flags & ALPS_BUTTONPAD)) {
>                         f->right = !!(SS4_BTN_V2(p) & 0x02);
> @@ -1346,18 +1350,18 @@ static void alps_process_packet_ss4_v2(struct psmouse *psmouse)
>  
>         priv->multi_packet = 0;
>  
> -       alps_report_mt_data(psmouse, (f->fingers <= 4) ? f->fingers : 4);
> -
> -       input_mt_report_finger_count(dev, f->fingers);
> +       if (!f->is_ts) {
> +               alps_report_mt_data(psmouse, (f->fingers <= 4) ? f->fingers : 4);
>  
> -       input_report_key(dev, BTN_LEFT, f->left);
> -       input_report_key(dev, BTN_RIGHT, f->right);
> -       input_report_key(dev, BTN_MIDDLE, f->middle);
> +               input_mt_report_finger_count(dev, f->fingers);
>  
> -       input_report_abs(dev, ABS_PRESSURE, f->pressure);
> -       input_sync(dev);
> +               input_report_key(dev, BTN_LEFT, f->left);
> +               input_report_key(dev, BTN_RIGHT, f->right);
> +               input_report_key(dev, BTN_MIDDLE, f->middle);
>  
> -       if (priv->flags & ALPS_DUALPOINT) {
> +               input_report_abs(dev, ABS_PRESSURE, f->pressure);
> +               input_sync(dev);
> +       } else {
>                 input_report_key(dev2, BTN_LEFT, f->ts_left);
>                 input_report_key(dev2, BTN_RIGHT, f->ts_right);
>                 input_report_key(dev2, BTN_MIDDLE, f->ts_middle);
> diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
> index b9417e2..1dc09b5 100644
> --- a/drivers/input/mouse/alps.h
> +++ b/drivers/input/mouse/alps.h
> @@ -192,6 +192,7 @@ struct alps_bitmap_point {
>   * @left: Left touchpad button is active.
>   * @right: Right touchpad button is active.
>   * @middle: Middle touchpad button is active.
> + * @is_ts: Packet is for the trackstick, not the touchpad.
>   * @ts_left: Left trackstick button is active.
>   * @ts_right: Right trackstick button is active.
>   * @ts_middle: Middle trackstick button is active.
> @@ -212,6 +213,7 @@ struct alps_fields {
>         unsigned int right:1;
>         unsigned int middle:1;
>  
> +       unsigned int is_ts:1;
>         unsigned int ts_left:1;
>         unsigned int ts_right:1;
>         unsigned int ts_middle:1;
> 

Hi! What looks suspicious on this patch is that you need to extend
structure in alps.h for marking packet as it comes from trackstick...
and only for sse_v2 devices. It is not possible to do detection in
process code similarly like for other devices?

-- 
Pali Rohár
pali.rohar@gmail.com
