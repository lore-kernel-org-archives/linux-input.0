From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4] input: qt2160: Add support for LEDs.
Date: Wed, 24 Oct 2012 13:38:17 -0700
Message-ID: <20121024203817.GA19503@core.coreip.homeip.net>
References: <1350893052-16137-1-git-send-email-javier.martin@vista-silicon.com>
 <20121022161751.GA14014@core.coreip.homeip.net>
 <CACKLOr3emVJGi1xd0qTX3WW-ARoEjaeq8zE26_Zr+NVyaPznJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35285 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934318Ab2JXUiV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Oct 2012 16:38:21 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so1471903pbb.19
        for <linux-input@vger.kernel.org>; Wed, 24 Oct 2012 13:38:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACKLOr3emVJGi1xd0qTX3WW-ARoEjaeq8zE26_Zr+NVyaPznJg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: javier Martin <javier.martin@vista-silicon.com>
Cc: linux-input@vger.kernel.org, axel.lin@gmail.com

On Wed, Oct 24, 2012 at 11:24:12AM +0200, javier Martin wrote:
> Hi Dmitry,
> thank you for your review.
> 
> On 22 October 2012 18:17, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > Hi Javier,
> >
> > On Mon, Oct 22, 2012 at 10:04:12AM +0200, Javier Martin wrote:
> >> Outputs x8..x0 of the qt2160 can have leds attached to it.
> >> This patch handles those outputs using the generic LED
> >> framework.
> >>
> >> The PWM controls available in the chip are used to achieve
> >> different levels of brightness.
> >>
> >> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
> >> ---
> >> Changes since v3:
> >>  - Protect led related code with #ifdefs so that users can decide
> >>  wether to enable LEDS_CLASS support in the kernel or not.
> >>
> >> ---
> >>  drivers/input/keyboard/qt2160.c |  113 ++++++++++++++++++++++++++++++++++++++-
> >>  1 file changed, 111 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/input/keyboard/qt2160.c b/drivers/input/keyboard/qt2160.c
> >> index 73ea4b0..482a7c5 100644
> >> --- a/drivers/input/keyboard/qt2160.c
> >> +++ b/drivers/input/keyboard/qt2160.c
> >> @@ -20,6 +20,7 @@
> >>
> >>  #include <linux/kernel.h>
> >>  #include <linux/init.h>
> >> +#include <linux/leds.h>
> >>  #include <linux/module.h>
> >>  #include <linux/slab.h>
> >>  #include <linux/jiffies.h>
> >> @@ -39,6 +40,11 @@
> >>  #define QT2160_CMD_GPIOS      6
> >>  #define QT2160_CMD_SUBVER     7
> >>  #define QT2160_CMD_CALIBRATE  10
> >> +#define QT2160_CMD_DRIVE_X    70
> >> +#define QT2160_CMD_PWMEN_X    74
> >> +#define QT2160_CMD_PWM_DUTY   76
> >> +
> >> +#define QT2160_NUM_LEDS_X    8
> >>
> >>  #define QT2160_CYCLE_INTERVAL        (2*HZ)
> >>
> >> @@ -49,6 +55,17 @@ static unsigned char qt2160_key2code[] = {
> >>       KEY_C, KEY_D, KEY_E, KEY_F,
> >>  };
> >>
> >> +#ifdef CONFIG_LEDS_CLASS
> >> +struct qt2160_led {
> >> +     struct qt2160_data *qt2160;
> >> +     struct led_classdev cdev;
> >> +     struct work_struct work;
> >> +     char name[32];
> >> +     int id;
> >> +     enum led_brightness new_brightness;
> >> +};
> >> +#endif
> >> +
> >>  struct qt2160_data {
> >>       struct i2c_client *client;
> >>       struct input_dev *input;
> >> @@ -56,8 +73,61 @@ struct qt2160_data {
> >>       spinlock_t lock;        /* Protects canceling/rescheduling of dwork */
> >>       unsigned short keycodes[ARRAY_SIZE(qt2160_key2code)];
> >>       u16 key_matrix;
> >> +#ifdef CONFIG_LEDS_CLASS
> >> +     struct qt2160_led leds[QT2160_NUM_LEDS_X];
> >> +     struct mutex led_lock;
> >> +#endif
> >>  };
> >>
> >> +static int qt2160_read(struct i2c_client *client, u8 reg);
> >> +static int qt2160_write(struct i2c_client *client, u8 reg, u8 data);
> >> +
> >> +#ifdef CONFIG_LEDS_CLASS
> >> +
> >> +static void qt2160_led_work(struct work_struct *work)
> >> +{
> >> +     struct qt2160_led *led = container_of(work, struct qt2160_led, work);
> >> +     struct qt2160_data *qt2160 = led->qt2160;
> >> +     struct i2c_client *client = qt2160->client;
> >> +     int value = led->new_brightness;
> >> +     u32 drive, pwmen;
> >> +
> >> +     mutex_lock(&qt2160->led_lock);
> >
> > What about accessing I2C from other contexts? Don't we need to take this
> > lock there too?
> 
> The purpose of this mutex is to avoid races between multiple calls to
> this function which is the only one that access (read/modify/write)
> CMD_DRIVE_X, CMD_PWMEN_X, CMD_PWM_DUTY registers.
> Please, correct me if I am wrong but I don't think we have to take
> this mutex anywhere else.

Ah, OK then.

-- 
Dmitry
