From: Jae hoon Chung <jh80.chung@gmail.com>
Subject: Re: [PATCH 1/4] [INPUT][KEYBOARD] Samsung keypad driver support
Date: Mon, 14 Sep 2009 14:22:27 +0900
Message-ID: <91990fe20909132222t292578abi5d2867312a5be095@mail.gmail.com>
References: <1252494663-17624-1-git-send-email-jsgood.yang@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:49974 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbZINFWY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Sep 2009 01:22:24 -0400
Received: by pxi27 with SMTP id 27so2115665pxi.15
        for <linux-input@vger.kernel.org>; Sun, 13 Sep 2009 22:22:27 -0700 (PDT)
In-Reply-To: <1252494663-17624-1-git-send-email-jsgood.yang@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jsgood.yang@samsung.com
Cc: dmitry.torokhov@gmail.com, ben-linux@fluff.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kyeongil Kim <ki0351.kim@samsung.com>

Hi...

I have some question to you.

> +static int s3c_keypad_scan(struct s3c_keypad *keypad, u32 *keymask_low,
> +                               u32 *keymask_high)
> +{
> +       struct s3c_platform_keypad *pdata = keypad->pdata;
> +       int i, j = 0;
> +       u32 cval, rval, cfg;
> +
> +       for (i = 0; i < pdata->nr_cols; i++) {
> +               cval = readl(keypad->regs + S3C_KEYIFCOL);
> +               cval |= S3C_KEYIF_COL_DMASK;
> +               cval &= ~(1 << i);
> +               writel(cval, keypad->regs + S3C_KEYIFCOL);
> +               udelay(pdata->delay);
> +
> +               rval = ~(readl(keypad->regs + S3C_KEYIFROW)) &
> +                       S3C_KEYIF_ROW_DMASK;
> +
> +               if ((i * pdata->nr_rows) < pdata->max_masks)
> +                       *keymask_low |= (rval << (i * pdata->nr_rows));
> +               else {
> +                       *keymask_high |= (rval << (j * pdata->nr_rows));
> +                       j++;
> +               }
> +       }
> +
> +       cfg = readl(keypad->regs + S3C_KEYIFCOL);
> +       cfg &= ~S3C_KEYIF_COL_MASK_ALL;
> +       writel(cfg, keypad->regs + S3C_KEYIFCOL);
> +
> +       return 0;
> +}
> +
> +static void s3c_keypad_timer_handler(unsigned long data)
> +{
> +       struct s3c_keypad *keypad = (struct s3c_keypad *)data;
> +       struct s3c_platform_keypad *pdata = keypad->pdata;
> +       struct input_dev *input = keypad->dev;
> +       u32 keymask_low = 0, keymask_high = 0;
> +       u32 press_mask_low, press_mask_high;
> +       u32 release_mask_low, release_mask_high, code, cfg;
> +       int i;
> +
> +       s3c_keypad_scan(keypad, &keymask_low, &keymask_high);
> +
> +       if (keymask_low != keypad->prevmask_low) {
> +               press_mask_low = ((keymask_low ^ keypad->prevmask_low) &
> +                                       keymask_low);
> +               release_mask_low = ((keymask_low ^ keypad->prevmask_low) &
> +                                       keypad->prevmask_low);
> +
> +               i = 0;
> +               while (press_mask_low) {
> +                       if (press_mask_low & 1) {
> +                               code = keypad->keycodes[i];
> +                               input_report_key(input, code, 1);
> +                               dev_dbg(&input->dev, "low pressed: %d\n", i);
> +                       }
> +                       press_mask_low >>= 1;
> +                       i++;
> +               }
> +
> +               i = 0;
> +               while (release_mask_low) {
> +                       if (release_mask_low & 1) {
> +                               code = keypad->keycodes[i];
> +                               input_report_key(input, code, 0);
> +                               dev_dbg(&input->dev, "low released: %d\n", i);
> +                       }
> +                       release_mask_low >>= 1;
> +                       i++;
> +               }
> +               keypad->prevmask_low = keymask_low;
> +       }
> +
> +       if (keymask_high != keypad->prevmask_high) {
> +               press_mask_high = ((keymask_high ^ keypad->prevmask_high) &
> +                                       keymask_high);
> +               release_mask_high = ((keymask_high ^ keypad->prevmask_high) &
> +                                       keypad->prevmask_high);
> +
> +               i = 0;
> +               while (press_mask_high) {
> +                       if (press_mask_high & 1) {
> +                               code = keypad->keycodes[i + pdata->max_masks];
> +                               input_report_key(input, code, 1);
> +                               dev_dbg(&input->dev, "high pressed: %d %d\n",
> +                                       keypad->keycodes[i + pdata->max_masks],
> +                                       i);
> +                       }
> +                       press_mask_high >>= 1;
> +                       i++;
> +               }
> +
> +               i = 0;
> +               while (release_mask_high) {
> +                       if (release_mask_high & 1) {
> +                               code = keypad->keycodes[i + pdata->max_masks];
> +                               input_report_key(input, code, 0);
> +                               dev_dbg(&input->dev, "high released: %d\n",
> +                                       keypad->keycodes[i + pdata->max_masks]);
> +                       }
> +                       release_mask_high >>= 1;
> +                       i++;
> +               }
> +               keypad->prevmask_high = keymask_high;
> +       }
> +
> +       if (keymask_low | keymask_high) {
> +               mod_timer(&keypad->timer, jiffies + HZ / 10);
> +       } else {
> +               cfg = readl(keypad->regs + S3C_KEYIFCON);
> +               cfg &= ~S3C_KEYIF_CON_MASK_ALL;
> +               cfg |= (S3C_KEYIF_INT_F_EN | S3C_KEYIF_INT_R_EN |
> +                               S3C_KEYIF_DF_EN | S3C_KEYIF_FC_EN);
> +               writel(cfg, keypad->regs + S3C_KEYIFCON);
> +       }
> +}

> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


I understood  your code that used the keymask_low & keymask_high.
why did you use to distinguish  a keymask_low & keymask_high?
In your code, that variable saved all value of row_val , then you are
searching the value of pressed row_val...
i think it is unnecessary.
