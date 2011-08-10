From: Barry Song <21cnbao@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: Add device tree binding for WM8753
Date: Wed, 10 Aug 2011 09:21:16 +0800
Message-ID: <CAGsJ_4w-YhWQTFovkynKVVr6JkwcHJQn-EmfxUxOSd=C2BwhiA@mail.gmail.com>
References: <1312778255-29755-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CAGsJ_4y2tDb3ZBPo8bCtrjFt0OWzR8WeG+kL_RKJPRP7-pZopw@mail.gmail.com>
 <20110809065100.GB8017@core.coreip.homeip.net> <20110809142851.GA15861@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42621 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802Ab1HJBVh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Aug 2011 21:21:37 -0400
Received: by bke11 with SMTP id 11so52332bke.19
        for <linux-input@vger.kernel.org>; Tue, 09 Aug 2011 18:21:36 -0700 (PDT)
In-Reply-To: <20110809142851.GA15861@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Liam Girdwood <lrg@ti.com>, Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, linux-input@vger.kernel.org

2011/8/9 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Mon, Aug 08, 2011 at 11:51:00PM -0700, Dmitry Torokhov wrote:
>
>> The issue I have with the ads7846 driver is that it still needs plat=
form
>> code to supply the needed platform data structure to make the
>> driver/device usable. So I am not sure what the benefit DT matching =
code
>> brings to that driver.
>
> Oh, if that's the case the driver ought to have device tree bindings
> which replicate the platform data. =C2=A0Unless the platform data is
> sufficiently obscure for hardly anyone to want to use it I guess.
>
With the device tree binding in ads7846, we don't need spi_board_info
any more since we have
ts@0 {
       compatible =3D "ti,ads7845";
       reg =3D <0x0>;
       spi-max-frequency =3D <31250>;
       interrupts =3D <90>;
};
in dts.

I guess what Dmitry said is the big ads7846_platform_data structure.

 struct ads7846_platform_data {
        u16     model;                  /* 7843, 7845, 7846, 7873. */
        u16     vref_delay_usecs;       /* 0 for external vref; etc */
        u16     vref_mv;                /* external vref value, milliVo=
lts
                                         * ads7846: if 0, use internal =
vref */
        bool    keep_vref_on;           /* set to keep vref on for diff=
erential
                                         * measurements as well */
        bool    swap_xy;                /* swap x and y axes */

        /* Settling time of the analog signals; a function of Vcc and t=
he
         * capacitance on the X/Y drivers.  If set to non-zero, two sam=
ples
         * are taken with settle_delay us apart, and the second one is =
used.
         * ~150 uSec with 0.01uF caps.
         */
        u16     settle_delay_usecs;

        /* If set to non-zero, after samples are taken this delay is ap=
plied
         * and penirq is rechecked, to help avoid false events.  This v=
alue
         * is affected by the material used to build the touch layer.
         */
        u16     penirq_recheck_delay_usecs;

        u16     x_plate_ohms;
        u16     y_plate_ohms;

        u16     x_min, x_max;
        u16     y_min, y_max;
        u16     pressure_min, pressure_max;

        u16     debounce_max;           /* max number of additional rea=
dings
                                         * per sample */
        u16     debounce_tol;           /* tolerance used for filtering=
 */
        u16     debounce_rep;           /* additional consecutive good =
readings
                                         * required after the first two=
 */
        int     gpio_pendown;           /* the GPIO used to decide the =
pendown
                                         * state if get_pendown_state =3D=
=3D NULL
                                         */
        int     (*get_pendown_state)(void);
        int     (*filter_init)  (const struct ads7846_platform_data *pd=
ata,
                                 void **filter_data);
        int     (*filter)       (void *filter_data, int data_idx, int *=
val);
        void    (*filter_cleanup)(void *filter_data);
        void    (*wait_for_sync)(void);
        bool    wakeup;
        unsigned long irq_flags;
};

The structure even has some callbacks which can't be possible in dts.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
