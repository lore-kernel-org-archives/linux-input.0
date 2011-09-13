From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] input: Add a driver TSC40 (serial)
Date: Tue, 13 Sep 2011 09:32:10 -0700
Message-ID: <20110913163210.GA2915@core.coreip.homeip.net>
References: <CAH9NwWcYWPPShEC4tyH_VQJaNmcmaWHiApkxnKr=0HCnaqZuMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f170.google.com ([209.85.161.170]:60344 "EHLO
	mail-gx0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755297Ab1IMQcS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Sep 2011 12:32:18 -0400
Received: by gxk27 with SMTP id 27so989197gxk.1
        for <linux-input@vger.kernel.org>; Tue, 13 Sep 2011 09:32:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAH9NwWcYWPPShEC4tyH_VQJaNmcmaWHiApkxnKr=0HCnaqZuMw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: linux-input@vger.kernel.org, bigeasy@linutronix.de

Hi Christian,

On Tue, Sep 13, 2011 at 10:18:24AM +0200, Christian Gmeiner wrote:
> +
> +       ret = tsc_get_id(serio, STATE_GET_ID);
> +       if (ret) {
> +
> +               /*
> +                * So it did not repsond. Nasty litle thingy. A reset followed
> +                * by ID seems to wake it up again. It responds with an ack
> +                * followed by the ID.
> +                */
> +               ret = serio_write(serio, TSC10_CMD_RESET);
> +               if (ret)
> +                       goto fail3;
> +
> +               msleep(15);
> +               ret = tsc_get_id(serio, STATE_GET_ID);
> +               if (ret)
> +                       goto fail3;
> +
> +               ret = serio_write(serio, TSC10_CMD_RESET);
> +               if (ret)
> +                       goto fail3;
> +
> +               msleep(15);
> +
> +               ret = tsc_get_id(serio, STATE_RESET_GET_ID);
> +               if (ret)
> +                       goto fail3;
> +       }
> +
> +       mode = ptsc->data[0];
> +       switch (mode) {
> +               case 0x00:
> +                       ptsc->state = STATE_INIT_MODE;
> +                       break;
> +
> +               case 0x05:
> +               case 0x01:
> +               case 0x21:
> +               case 0x31:
> +               case 0x02:
> +               case 0x0a:
> +               case 0x2a:
> +               case 0x3a:
> +                       ret = serio_write(serio, TSC10_CMD_RESET);
> +                       if (ret)
> +                               goto fail3;
> +                       msleep(16);
> +                       ret = tsc_get_id(serio, STATE_GET_ID);
> +                       if (ret)
> +                               goto fail3;
> +                       if (ptsc->data[0] == 0) {
> +                               ptsc->state = STATE_INIT_MODE;
> +                               break;
> +                       }
> +                       dev_err(&serio->dev, "Can't get into init mode
> in %x\n", ptsc->data[0]);
> +                       goto fail3;
> +               default:
> +                       dev_err(&serio->dev, "Unexpected mode: %02x\n", mode);
> +                       goto fail3;
> +       }
> +
> +       ptsc->idx = 0;
> +       init_completion(&ptsc->cmd_done);
> +       ret = serio_write(serio, TSC10_CMD_RATE);
> +       if (ret)
> +               goto fail3;
> +       ret = serio_write(serio, TSC10_RATE_150);
> +       if (ret)
> +               goto fail3;
> +
> +       ret = wait_for_completion_timeout(&ptsc->cmd_done, HZ);
> +       if (ret <= 0) {
> +               dev_err(&serio->dev, "Mode transition failed %d\n", ret);
> +               goto fail3;
> +       }
> +
> +       ptsc->idx = 0;
> +       if (ptsc->state != STATE_READ) {
> +               dev_err(&serio->dev, "Touchscreen probably not attached.\n");
> +               goto fail3;
> +       }

All this initialization is much easier done in inputattach.

> +       ret = serio_write(serio, TSC10_CMD_DATA1);
> +       if (ret)
> +               goto fail3;
> +
> +       ret = input_register_device(ptsc->dev);
> +       if (ret)
> +               goto fail3;
> +
> +       return 0;
> + fail3:
> +       serio_close(serio);
> + fail2:
> +       serio_set_drvdata(serio, NULL);
> + fail1:
> +       input_free_device(input_dev);
> +       kfree(ptsc);
> +       return ret;
> +}
> +
> +static void tsc_disconnect(struct serio *serio)
> +{
> +       struct tsc_ser *ptsc = serio_get_drvdata(serio);
> +
> +       input_get_device(ptsc->dev);
> +       input_unregister_device(ptsc->dev);
> +       serio_close(serio);
> +       serio_set_drvdata(serio, NULL);
> +       input_put_device(ptsc->dev);
> +       kfree(ptsc);

Just say:

	serio_close(serio);
	input_unregister_device(ptsc->dev);
	kfree(ptsc);
	serio_set_drvdata(serio, NULL);

No need to mess with get/put. I over-complicated some older drivers in
this regard ;)

-- 
Dmitry
