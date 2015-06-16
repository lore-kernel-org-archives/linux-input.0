From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH v4 2/2] cap11xx: add LED support
Date: Tue, 16 Jun 2015 23:26:14 +0200
Message-ID: <55809476.90407@zonque.org>
References: <1434422770-26896-1-git-send-email-mranostay@gmail.com>	<1434422770-26896-3-git-send-email-mranostay@gmail.com>	<557FD625.1080806@samsung.com> <CAKzfze9gneY_LmWaWGNKxLXBsw_k2d596CkGNat5RoTbn3cYEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <CAKzfze9gneY_LmWaWGNKxLXBsw_k2d596CkGNat5RoTbn3cYEg@mail.gmail.com>
Sender: linux-leds-owner@vger.kernel.org
To: Matt Ranostay <mranostay@gmail.com>, Jacek Anaszewski <j.anaszewski@samsung.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-leds@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On 06/16/2015 04:39 PM, Matt Ranostay wrote:
> On Tue, Jun 16, 2015 at 12:54 AM, Jacek Anaszewski
> <j.anaszewski@samsung.com> wrote:
>> On 06/16/2015 04:46 AM, Matt Ranostay wrote:

>>> +       for_each_child_of_node(node, child) {
>>> +               led->cdev.name =
>>> +                       of_get_property(child, "label", NULL) ? :
>>> child->name;
>>> +               led->cdev.default_trigger =
>>> +                       of_get_property(child, "linux,default-trigger",
>>> NULL);
>>> +               led->cdev.flags = 0;
>>> +               led->cdev.brightness_set = cap11xx_led_set;
>>> +               led->cdev.max_brightness = 1;
>>> +               led->cdev.brightness = LED_OFF;
>>> +
>>> +               error = of_property_read_u32(child, "reg", &reg);
>>> +               if (error != 0 || reg >= priv->num_leds)
>>> +                       continue;
>>> +               led->reg = reg;
>>> +               led->priv = priv;
>>> +
>>> +               INIT_WORK(&led->work, cap11xx_led_work);
>>> +               error = devm_led_classdev_register(dev, &led->cdev);
>>> +               if (error < 0)
>>> +                       return -EINVAL;
>>> +
>>> +               schedule_work(&led->work);
>>
>>
>> Why do you schedule work here? It should be done only in brightness_set op.
>>
> The LED needs to be set to initial turned off state, since there is no
> Power ON/OFF register for the cap11xx devices.. So LEDs state would be
> persistent across warm reboots.
> Thoughts on how to do this better?

What's wrong with this?

  regmap_write(priv->regmap, CAP11XX_REG_LED_OUTPUT_CONTROL, 0);

Outside the loop, of course ...


Daniel
