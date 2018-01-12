From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: multi-touch fix for ALPS touchpads ("SS4 plus"
 variant)
Date: Thu, 11 Jan 2018 23:43:11 -0800
Message-ID: <20180112074311.tlhgpwp2szgldxi7@dtor-ws>
References: <CAE1KSOPo=uQbE4tCpZF4UzXRsfzA1gTqW4-UURGjt2u2+ZH_Mg@mail.gmail.com>
 <TYXPR01MB0719F851EB4CC5EA8375845EC7170@TYXPR01MB0719.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <TYXPR01MB0719F851EB4CC5EA8375845EC7170@TYXPR01MB0719.jpnprd01.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masaki Ota <masaki.ota@jp.alps.com>
Cc: Nir Perry <nirperry@gmail.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, Jan 12, 2018 at 01:02:55AM +0000, Masaki Ota wrote:
> Hi, Nir,
> 
> Wow, thank you for fixing the bug.
> Your code is correct!

Great, I am putting you down as "Reviewed-by" then. Thanks!

> 
> Best Regards,
> Masaki Ota
> -----Original Message-----
> From: Nir Perry [mailto:nirperry@gmail.com] 
> Sent: Saturday, January 06, 2018 8:55 PM
> To: 太田 真喜 Masaki Ota <masaki.ota@jp.alps.com>; Dmitry Torokhov <dmitry.torokhov@gmail.com>; Pali Rohár <pali.rohar@gmail.com>
> Cc: linux-kernel@vger.kernel.org; linux-input@vger.kernel.org
> Subject: [PATCH] input: multi-touch fix for ALPS touchpads ("SS4 plus" variant)
> 
> Hi all,
> 
> I think a minor "typo" bug was accidentally introduced to ALPS touchpad driver by a previous bug-fix (commit 4a646580f793d19717f7e034c8d473b509c27d49, "Input: ALPS - fix two-finger scroll breakage in right side on ALPS touchpad").
> It breaks how multi-touch events are decoded on some ALPS touchpads, so for example tapping with three-fingers can no longer be used to emulate middle-mouse-button (the kernel doesn't recognize this as the proper event, and doesn't report it correctly to userspace).
> This affects touchpads that use SS4 "plus" protocol variant, like those found on Dell E7270 & E7470 laptops (tested on E7270).
> 
> The cause of the problem
> ------------------------------------------
> First, probably due to a typo, the code in alps_decode_ss4_v2() for case SS4_PACKET_ID_MULTI used inconsistent indices to "f->mt[]". You can see 0 & 1 are used for the "if" part but 2 & 3 are used for the "else" part, which I believe is a typo.
> Second, in the previous patch, new macros were introduced to decode X coordinates specific to the SS4 "plus" variant, but the macro to define the maximum X value wasn't changed accordingly. The macros to decode X values for "plus" variant are effectively shifted right by 1 bit, but the max wasn't shifted too. This causes the driver to incorrectly handle "no data" cases, which also interfered with how multi-touch was handled. To fix it - I created new SS4 "plus" macros for the max value - SS4_PLUS_MFPACKET_NO_AX & SS4_PLUS_MFPACKET_NO_AX_BL. To make the change a little more readable, I moved also the Y-max lines so they are closer to the X-max lines.
> To get three-finger tap to work both changes are required.
> 
> The included patch was generated against the mainline tree today, but was also tested against the 4.14 kernel branch. I've included in this e-mail the people involved with the old patch from August, plus Pali Rohár who is listed as the ALPS PS/2 touchpad driver reviewer (in the maintainers file).
> 
> Fixes: 4a646580f793d19717f7e034c8d473b509c27d49 ("Input: ALPS - fix two-finger scroll breakage in right side on ALPS touchpad")
> 
> Regards,
> Nir
> 
> Signed-off-by: Nir Perry <nirperry@gmail.com> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c index 579b899..dbe57da 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -1250,29 +1250,32 @@ static int alps_decode_ss4_v2(struct alps_fields *f,
>         case SS4_PACKET_ID_MULTI:
>                 if (priv->flags & ALPS_BUTTONPAD) {
>                         if (IS_SS4PLUS_DEV(priv->dev_id)) {
> -                               f->mt[0].x = SS4_PLUS_BTL_MF_X_V2(p, 0);
> -                               f->mt[1].x = SS4_PLUS_BTL_MF_X_V2(p, 1);
> +                               f->mt[2].x = SS4_PLUS_BTL_MF_X_V2(p, 0);
> +                               f->mt[3].x = SS4_PLUS_BTL_MF_X_V2(p, 1);
> +                               no_data_x = SS4_PLUS_MFPACKET_NO_AX_BL;
>                         } else {
>                                 f->mt[2].x = SS4_BTL_MF_X_V2(p, 0);
>                                 f->mt[3].x = SS4_BTL_MF_X_V2(p, 1);
> +                               no_data_x = SS4_MFPACKET_NO_AX_BL;
>                         }
> +                       no_data_y = SS4_MFPACKET_NO_AY_BL;
> 
>                         f->mt[2].y = SS4_BTL_MF_Y_V2(p, 0);
>                         f->mt[3].y = SS4_BTL_MF_Y_V2(p, 1);
> -                       no_data_x = SS4_MFPACKET_NO_AX_BL;
> -                       no_data_y = SS4_MFPACKET_NO_AY_BL;
>                 } else {
>                         if (IS_SS4PLUS_DEV(priv->dev_id)) {
> -                               f->mt[0].x = SS4_PLUS_STD_MF_X_V2(p, 0);
> -                               f->mt[1].x = SS4_PLUS_STD_MF_X_V2(p, 1);
> +                               f->mt[2].x = SS4_PLUS_STD_MF_X_V2(p, 0);
> +                               f->mt[3].x = SS4_PLUS_STD_MF_X_V2(p, 1);
> +                               no_data_x = SS4_PLUS_MFPACKET_NO_AX;
>                         } else {
> -                               f->mt[0].x = SS4_STD_MF_X_V2(p, 0);
> -                               f->mt[1].x = SS4_STD_MF_X_V2(p, 1);
> +                               f->mt[2].x = SS4_STD_MF_X_V2(p, 0);
> +                               f->mt[3].x = SS4_STD_MF_X_V2(p, 1);
> +                               no_data_x = SS4_MFPACKET_NO_AX;
>                         }
> +                       no_data_y = SS4_MFPACKET_NO_AY;
> +
>                         f->mt[2].y = SS4_STD_MF_Y_V2(p, 0);
>                         f->mt[3].y = SS4_STD_MF_Y_V2(p, 1);
> -                       no_data_x = SS4_MFPACKET_NO_AX;
> -                       no_data_y = SS4_MFPACKET_NO_AY;
>                 }
> 
>                 f->first_mp = 0;
> diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h index c80a7c7..3dfae83 100644
> --- a/drivers/input/mouse/alps.h
> +++ b/drivers/input/mouse/alps.h
> @@ -145,6 +145,8 @@ enum SS4_PACKET_ID {
>  #define SS4_MFPACKET_NO_AY     4080    /* Y-Coordinate value */
>  #define SS4_MFPACKET_NO_AX_BL  8176    /* Buttonless X-Coordinate value */
>  #define SS4_MFPACKET_NO_AY_BL  4088    /* Buttonless Y-Coordinate value */
> +#define SS4_PLUS_MFPACKET_NO_AX        4080    /* SS4 PLUS, x  */
> +#define SS4_PLUS_MFPACKET_NO_AX_BL     4088    /* Buttonless SS4 PLUS, x */
> 
>  /*
>   * enum V7_PACKET_ID - defines the packet type for V7

-- 
Dmitry
