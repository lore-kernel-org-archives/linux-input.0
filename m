From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH try #2] Blackfin BF54x Input Keypad controller driver
Date: Thu, 11 Oct 2007 12:37:15 +0100
Message-ID: <600D5CB4DFD93545BF61FF01473D11AC0F100DA7@limkexm2.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-class: urn:content-classes:message
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, bryan.wu@analog.com
Cc: Michael Hennerich <michael.hennerich@analog.com>, linux-input@atrey.karlin.mff.cuni.cz, Linux Kernel <linux-kernel@vger.kernel.org>, uclinux-dist-devel@blackfin.uclinux.org
List-Id: linux-input@vger.kernel.org



Hi Dmitry,

Thanks for your feedback.
See my comment below.
Bryan is going to send you an updated patch shortly.

Best regards,
Michael


>Hi Bryan,
>
>On 10/4/07, Bryan Wu <bryan.wu@analog.com> wrote:
>> From: Michael Hennerich <michael.hennerich@analog.com>
>> Blackfin BF54x Input Keypad controller driver:
>>
>> [try #2] Changelog:
>>  - Coding style issue fixes
>>  - using a temp variable for bf54x_kpad->input
>>  - Other updates according to Dmitry's review
>>
>
>I would like to ask you for a couple of additional changes:
>
>> +
>> +static u16 per_rows[] =3D {
>
>Change to "const" perhaps?
>
>> +       P_KEY_ROW7,
>> +       P_KEY_ROW6,
>> +       P_KEY_ROW5,
>> +       P_KEY_ROW4,
>> +       P_KEY_ROW3,
>> +       P_KEY_ROW2,
>> +       P_KEY_ROW1,
>> +       P_KEY_ROW0,
>> +       0
>> +};
>> +
>> +static u16 per_cols[] =3D {
>
>Same here.
>
>> +       P_KEY_COL7,
>> +       P_KEY_COL6,
>> +       P_KEY_COL5,
>> +       P_KEY_COL4,
>> +       P_KEY_COL3,
>> +       P_KEY_COL2,
>> +       P_KEY_COL1,
>> +       P_KEY_COL0,
>> +       0
>> +};
>> +
>> +
>> +       if (bfin_kpad_get_keypressed(bf54x_kpad)) {
>> +               disable_irq(bf54x_kpad->irq);
>> +               bf54x_kpad->lastkey =3D key;
>> +               bf54x_kpad->timer.expires =3D jiffies
>> +                                       +
bf54x_kpad->keyup_test_jiffies;
>> +               add_timer(&bf54x_kpad->timer);
>
>mod_timer()?
>
>> +
>> +       input->keycode =3D pdata->keymap;
>
>Please consider allocating memory for keycode so that platfrom data
>can be kept constant.

Typical use cases for this driver module would be in a single user
embedded system. - More likely going through reboot than through a
module unload/load cycle with different user setting. But you are right
cleaner is to copy the key codes.


>
>> +       input->keycodesize =3D sizeof(unsigned short);
>> +       input->keycodemax =3D pdata->keymapsize;
>> +
>> +       /* setup input device */
>> +       set_bit(EV_KEY, input->evbit);
>> +
>> +       if (pdata->repeat)
>> +               set_bit(EV_REP, input->evbit);
>> +
>
>__set_bit() should suffice here and above.
>
>> +       for (i =3D 0; i < pdata->keymapsize; i++)
>> +               __set_bit(pdata->keymap[i] & KEY_MAX, input->keybit);
>> +
>> +       __clear_bit(KEY_RESERVED, input->keybit);
>> +
>> +       error =3D input_register_device(input);
>> +
>> +       if (error) {
>> +               printk(KERN_ERR DRV_NAME
>> +                       ": Unable to register input device (%d)\n",
>error);
>> +               goto out4;
>> +       }
>> +
>> +       /* Init Keypad Key Up/Release test timer */
>> +
>> +       init_timer(&bf54x_kpad->timer);
>> +       bf54x_kpad->timer.function =3D bfin_kpad_timer;
>> +       bf54x_kpad->timer.data =3D (unsigned long) pdev;
>> +
>
>setup_timer()?
>
>> +
>> +       bfin_write_KPAD_PRESCALE(bfin_kpad_get_prescale(TIME_SCALE));
>> +
>> +       bfin_write_KPAD_CTL((((pdata->cols - 1) << 13) & KPAD_COLEN)
|
>> +                               (((pdata->rows - 1) << 10) &
KPAD_ROWEN)
>|
>> +                               (2 & KPAD_IRQMODE));
>> +
>> +
>> +       bfin_write_KPAD_CTL(bfin_read_KPAD_CTL() | KPAD_EN);
>> +
>> +       printk(KERN_ERR DRV_NAME
>> +               ": Blackfin BF54x Keypad registered IRQ %d\n",
>bf54x_kpad->irq);
>> +
>> +       return 0;
>> +
>> +
>> +out4:
>> +       input_free_device(input);
>> +out3:
>> +       free_irq(bf54x_kpad->irq, pdev);
>> +out2:
>> +       peripheral_free_list(&per_cols[MAX_RC - pdata->cols]);
>> +out1:
>> +       peripheral_free_list(&per_rows[MAX_RC - pdata->rows]);
>> +out:
>> +       kfree(bf54x_kpad);
>> +       platform_set_drvdata(pdev, NULL);
>> +
>> +       return error;
>> +}
>> +
>> +static int __devexit bfin_kpad_remove(struct platform_device *pdev)
>> +{
>> +       struct bfin_kpad_platform_data *pdata =3D
pdev->dev.platform_data;
>> +       struct bf54x_kpad *bf54x_kpad =3D platform_get_drvdata(pdev);
>> +
>> +
>> +       del_timer_sync(&bf54x_kpad->timer);
>> +       free_irq(bf54x_kpad->irq, pdev);
>> +
>> +       peripheral_free_list(&per_rows[MAX_RC - pdata->rows]);
>> +       peripheral_free_list(&per_cols[MAX_RC - pdata->cols]);
>> +
>> +       input_unregister_device(bf54x_kpad->input);
>> +
>> +       kfree(bf54x_kpad);
>> +       platform_set_drvdata(pdev, NULL);
>> +
>> +       return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM
>> +static int bfin_kpad_suspend(struct platform_device *pdev,
pm_message_t
>state)
>> +{
>
>Do you need these empty functions? At least stop timer here.

Currently not - I'm going to remove them.

>
>Thanks!
>
>Oh, one more thing - do not access input->private directly - it is
>going away - use input_set_drvdata() and input_get_drvdata().
>
>--
>Dmitry
