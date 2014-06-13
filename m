From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH v2 1/1] elantech: Add support for trackpoint found on some
 v3 models
Date: Fri, 13 Jun 2014 09:39:34 +0200
Message-ID: <CANq1E4Q2pmZBRzCkZG9ssMQ3oVF0diYMNN+iaDzvWBHOis0KFg@mail.gmail.com>
References: <20140214205126.GB15526@lantern>
	<1402596901-28784-1-git-send-email-ulrik.debie-os@e2big.org>
	<1402596901-28784-2-git-send-email-ulrik.debie-os@e2big.org>
	<CANq1E4SozSvQGsj9ffiiUMSUzM_rd1uWTNqe51RF2kdkfA9WSA@mail.gmail.com>
	<539AA71D.2040808@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <539AA71D.2040808@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ulrik De Bie <ulrik.debie-os@e2big.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, stable <stable@vger.kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi

On Fri, Jun 13, 2014 at 9:24 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> You rely on external data here, so please check for truncation. If
>> anyone changes psmouse->ps2dev.serio->phys, they would not notice that
>> you rely on it here. So I'd do sth like:
>>
>> size_t n = snprintf(etd->tp_phys, sizeof(etd->tp_phys), "%s/input1",
>> psmouse->ps2dev.serio->phys);
>> if (n >= sizeof(etd->tp_phys))
>>         goto init_fail_tp_reg;
>
> Ugh no, we've this snprintf pattern for foo->phys everywhere in the kernel
> and we don't do a truncation check anywhere. No-one in its right mind will
> make phys smaller, and even if phys gets truncated things will likely
> still work fine.
>
>> Or at least force a terminating-zero on phys by decreasing the length
>> by 1 (phys is initialized to zero):
>
> snprintf already forces a terminating zero, no need for weird tricks.
>
>>
>> snprintf(etd->tp_phys, sizeof(etd->tp_phys) - 1, "%s/input1",
>> psmouse->ps2dev.serio->phys);
>
> So this is wrong, no need for the - 1.

Oh, right, snprintf() always writes null. Fair enough.

>>
>>> +               tp_dev->phys = etd->tp_phys;
>>> +               tp_dev->name = "Elantech PS/2 TrackPoint";
>>> +               tp_dev->id.bustype = BUS_I8042;
>>> +               tp_dev->id.vendor  = 0x0002;
>>> +               tp_dev->id.product = PSMOUSE_ELANTECH;
>>> +               tp_dev->id.version = 0x0000;
>>> +               tp_dev->dev.parent = &psmouse->ps2dev.serio->dev;
>>> +               tp_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REL);
>>> +               tp_dev->relbit[BIT_WORD(REL_X)] = BIT_MASK(REL_X) | BIT_MASK(REL_Y);
>>> +               tp_dev->keybit[BIT_WORD(BTN_LEFT)] =
>>> +                       BIT_MASK(BTN_LEFT) | BIT_MASK(BTN_MIDDLE) | BIT_MASK(BTN_RIGHT);
>>
>> Ugh, why not use __set_bit()? But ok, seems to be normal to use these
>> shortcuts for mice.
>>
>>> +               if (input_register_device(etd->tp_dev))
>>> +                       goto init_fail_tp_reg;
>>
>> Please forward the error code:
>>
>> int error = -EINVAL;
>>
>> ...
>>
>> error = input_register_device(tp_dev);
>> if (error < 0)
>>         goto init_fail_tp_reg;
>>
>> ...
>>
>> init_fail:
>> kfree(etd);
>> return error;
>>
>>> +       }
>>>
>>>         psmouse->protocol_handler = elantech_process_byte;
>>>         psmouse->disconnect = elantech_disconnect;
>>> @@ -1504,8 +1597,13 @@ int elantech_init(struct psmouse *psmouse)
>>>         psmouse->pktsize = etd->hw_version > 1 ? 6 : 4;
>>>
>>>         return 0;
>>> -
>>> + init_fail_tp_reg:
>>> +       input_free_device(tp_dev);
>>> + init_fail_tp_alloc:
>>> +       sysfs_remove_group(&psmouse->ps2dev.serio->dev.kobj,
>>> +                          &elantech_attr_group);
>>>   init_fail:
>>> +        psmouse_reset(psmouse);
>>
>> elantech_disconnect() does not call psmouse_reset, so why add it here?
>> What am I missing?
>
> AFAIK elantech disconnect will only get called if the ps2 mouse driver gets
> unloaded / the mouse gets hot-unplugged. Where as this gets called on
> probe failure, after which we want to turn the ps/2 mouse emulation
> back on so that it will work as a regular mouse.

But this sounds like a bugfix to me, which is unrelated to this
comment? If it is, please consider sending it separately.

Thanks
David
