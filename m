From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] saa7134 - ir remote for sinovideo 1300
Date: Sun, 19 Jul 2009 12:38:10 -0700
Message-ID: <20090719193809.GB17495@dtor-d630.eng.vmware.com>
References: <303575.20312.qm@web39105.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.235]:45962 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838AbZGSTiO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 19 Jul 2009 15:38:14 -0400
Received: by rv-out-0506.google.com with SMTP id f6so516650rvb.1
        for <linux-input@vger.kernel.org>; Sun, 19 Jul 2009 12:38:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <303575.20312.qm@web39105.mail.mud.yahoo.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: James Guo <jinp65@yahoo.com>
Cc: linux-input@vger.kernel.org

Hi James,

On Fri, Jul 17, 2009 at 10:59:34AM -0700, James Guo wrote:
> 
> Have a tv tuner believe to be sinovideo 1300, and the remote has h-338 in the back, the tuner is detected as saa7134 proteus 2309, and working fine, the patch is for the remote.
> 
> following buttons supposed to be working: all the number button, channel up and down, volumn up and down, off, mute, full screen, recall, snapshot, tv.  Some buttons do not have valid entry for tvtime, so I did not map them(record, stop ...)
> 
> to apply, use command
> modprobe saa7134 card=157
> if it does not work, use
> modprobe saa7134 card=157 ir_debug=1
> and send me(yahoo.com) the output of dmesg(after modprobe and after a button is pressed)
> 
> --- a/include/media/ir-common.h    2009-07-08 19:28:50.000000000 -0400
> +++ b/include/media/ir-common.h    2009-07-16 01:37:41.000000000 -0400
> @@ -162,6 +162,7 @@
>  extern IR_KEYTAB_TYPE ir_codes_kworld_plus_tv_analog[IR_KEYTAB_SIZE];
>  extern IR_KEYTAB_TYPE ir_codes_kaiomy[IR_KEYTAB_SIZE];
>  extern IR_KEYTAB_TYPE ir_codes_dm1105_nec[IR_KEYTAB_SIZE];
> +extern IR_KEYTAB_TYPE ir_codes_sinovideo_1300[IR_KEYTAB_SIZE];
>  #endif
>  
>  /*
> --- a/drivers/media/common/ir-keymaps.c    2009-07-08 19:28:49.000000000 -0400
> +++ b/drivers/media/common/ir-keymaps.c    2009-07-16 13:17:30.000000000 -0400
> @@ -62,6 +62,38 @@
>  };
>  
>  EXPORT_SYMBOL_GPL(ir_codes_proteus_2309);
> +
> +IR_KEYTAB_TYPE ir_codes_sinovideo_1300[IR_KEYTAB_SIZE] = {
> +    /* numeric */
> +    [ 0x00 ] = KEY_0,
> +    [ 0x01 ] = KEY_1,
> +    [ 0x02 ] = KEY_2,
> +    [ 0x03 ] = KEY_3,
> +    [ 0x04 ] = KEY_4,
> +    [ 0x05 ] = KEY_5,
> +    [ 0x06 ] = KEY_6,
> +    [ 0x07 ] = KEY_7,
> +    [ 0x08 ] = KEY_8,
> +    [ 0x09 ] = KEY_9,

Please use KEY_NUMERIC_* instead as they should not be affected by Shift
and NumLock state.

> +
> +    [ 0x5c ] = KEY_POWER,     /* power       */
> +    [ 0x20 ] = KEY_F,         /* full screen */
> +    [ 0x0f ] = KEY_BACKSPACE, /* recall      */
> +    [ 0x1b ] = KEY_M,         /* mute        */

I bet we have better keycodes for these.

> +    [ 0x41 ] = KEY_RECORD,    /* record      */
> +    [ 0x43 ] = KEY_STOP,      /* stop        */
> +    [ 0x16 ] = KEY_S,         /* snapshot    */
> +    [ 0x1a ] = KEY_Q,         /* off         */
> +    [ 0x2e ] = KEY_RED,
> +    [ 0x1f ] = KEY_DOWN,      /* channel -   */
> +    [ 0x1c ] = KEY_UP,        /* channel +   */
> +    [ 0x10 ] = KEY_LEFT,      /* volume -    */
> +    [ 0x1e ] = KEY_RIGHT,     /* volume +    */
> +    [ 0x14 ] = KEY_F1,
> +    [ 0x15 ] = KEY_I,         /* tv          */
> +};
> +
> +EXPORT_SYMBOL_GPL(ir_codes_sinovideo_1300);
>  /* Matt Jesson <dvb@jesson.eclipse.co.uk */
>  IR_KEYTAB_TYPE ir_codes_avermedia_dvbt[IR_KEYTAB_SIZE] = {
>      [ 0x28 ] = KEY_0,         //'0' / 'enter'
> --- a/drivers/media/video/saa7134/saa7134-cards.c    2009-07-08 19:28:49.000000000 -0400
> +++ b/drivers/media/video/saa7134/saa7134-cards.c    2009-07-15 22:37:16.000000000 -0400
> @@ -4744,6 +4744,37 @@
>              .gpio = 0x01,
>          },
>      },
> +    [SAA7134_BOARD_SINOVIDEO_1300] = {
> +        .name           = "Sinovideo 1300",
> +        .audio_clock    = 0x00187de7,
> +        .tuner_type    = TUNER_PHILIPS_FM1216ME_MK3,
> +        .radio_type     = UNSET,
> +        .tuner_addr    = ADDR_UNSET,
> +        .radio_addr    = ADDR_UNSET,
> +        .tda9887_conf   = TDA9887_PRESENT,
> +        .inputs         = {{
> +            .name = name_tv,
> +            .vmux = 1,
> +            .amux = LINE2,
> +            .tv   = 1,
> +        },{
> +            .name = name_comp1,
> +            .vmux = 0,
> +            .amux = LINE2,
> +        },{
> +            .name = name_comp2,
> +            .vmux = 3,
> +            .amux = LINE2,
> +        },{
> +            .name = name_svideo,
> +            .vmux = 8,
> +            .amux = LINE2,
> +        }},
> +        .mute = {
> +            .name = name_mute,
> +            .amux = LINE1,
> +        },
> +    },
>  };
>  
>  const unsigned int saa7134_bcount = ARRAY_SIZE(saa7134_boards);
> @@ -5838,6 +5869,12 @@
>          .subvendor    = 0x1461, /* Avermedia Technologies Inc */
>          .subdevice    = 0xf31d,
>          .driver_data  = SAA7134_BOARD_AVERMEDIA_GO_007_FM_PLUS,
> +    },{
> +        .vendor       = PCI_VENDOR_ID_PHILIPS,
> +        .device       = PCI_DEVICE_ID_PHILIPS_SAA7130,
> +        .subvendor    = 0x0919,
> +        .subdevice    = 0x2003,
> +        .driver_data  = SAA7134_BOARD_SINOVIDEO_1300,
>  
>      }, {
>          /* --- boards without eeprom + subsystem ID --- */
> @@ -6133,6 +6170,7 @@
>      case SAA7134_BOARD_REAL_ANGEL_220:
>      case SAA7134_BOARD_KWORLD_PLUS_TV_ANALOG:
>      case SAA7134_BOARD_AVERMEDIA_GO_007_FM_PLUS:
> +    case SAA7134_BOARD_SINOVIDEO_1300:
>          dev->has_remote = SAA7134_REMOTE_GPIO;
>          break;
>      case SAA7134_BOARD_FLYDVBS_LR300:
> --- a/drivers/media/video/saa7134/saa7134.h    2009-07-08 19:28:49.000000000 -0400
> +++ b/drivers/media/video/saa7134/saa7134.h    2009-07-16 15:31:54.000000000 -0400
> @@ -280,6 +280,7 @@
>  #define SAA7134_BOARD_AVERMEDIA_GO_007_FM_PLUS 154
>  #define SAA7134_BOARD_HAUPPAUGE_HVR1120     155
>  #define SAA7134_BOARD_HAUPPAUGE_HVR1110R3   156
> +#define SAA7134_BOARD_SINOVIDEO_1300   157
>  
>  #define SAA7134_MAXBOARDS 32
>  #define SAA7134_INPUT_MAX 8
> --- a/drivers/media/video/saa7134/saa7134-input.c    2009-03-23 19:12:14.000000000 -0400
> +++ b/drivers/media/video/saa7134/saa7134-input.c    2009-07-16 15:08:50.000000000 -0400
> @@ -67,6 +67,7 @@
>  static int saa7134_nec_irq(struct saa7134_dev *dev);
>  static void nec_task(unsigned long data);
>  static void saa7134_nec_timer(unsigned long data);
> +static void ir_sv_timer_end(unsigned long data);
>  
>  /* -------------------- GPIO generic keycode builder -------------------- */
>  
> @@ -367,7 +368,10 @@
>      } else if (ir->rc5_gpio) {
>          /* set timer_end for code completion */
>          init_timer(&ir->timer_end);
> -        ir->timer_end.function = ir_rc5_timer_end;
> +        if (dev->board == SAA7134_BOARD_SINOVIDEO_1300)
> +            ir->timer_end.function = ir_sv_timer_end;
> +        else
> +            ir->timer_end.function = ir_rc5_timer_end;
>          ir->timer_end.data = (unsigned long)ir;
>          init_timer(&ir->timer_keyup);
>          ir->timer_keyup.function = ir_rc5_timer_keyup;
> @@ -601,6 +605,13 @@
>          mask_keycode = 0x7f;
>          polling = 40; /* ms */
>          break;
> +    case SAA7134_BOARD_SINOVIDEO_1300:
> +        ir_codes     = ir_codes_sinovideo_1300;
> +        mask_keycode = 0x00007F;
> +        mask_keyup   = 0x040000;
> +        rc5_gpio = 1;
> +        ir_rc5_remote_gap = 1125;
> +        break;
>      }
>      if (NULL == ir_codes) {
>          printk("%s: Oops: IR config error [card=%d]\n",
> @@ -748,6 +759,7 @@
>              tv.tv_usec - ir->base_time.tv_usec;
>      }
>  
> +    dprintk("gap is %d\n", gap);
>      /* active code => add bit */
>      if (ir->active) {
>          /* only if in the code (otherwise spurious IRQ or timer
> @@ -764,7 +776,10 @@
>          ir->base_time = tv;
>          ir->last_bit = 0;
>  
> -        timeout = current_jiffies + (500 + 30 * HZ) / 1000;
> +        if (dev->board == SAA7134_BOARD_SINOVIDEO_1300)
> +            timeout = current_jiffies + (500 + 35 * HZ) / 1000;
> +        else
> +            timeout = current_jiffies + (500 + 30 * HZ) / 1000;

Please use msecs_to_jiffies instead of doing calculations on HZ.

-- 
Dmitry
