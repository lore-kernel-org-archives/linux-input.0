From: Gabor Juhos <juhosg@openwrt.org>
Subject: Re: [PATCH 09/18] input: add input driver for polled GPIO buttons
Date: Wed, 24 Nov 2010 19:54:59 +0100
Message-ID: <4CED5F83.6070301@openwrt.org>
References: <1290524800-21419-1-git-send-email-juhosg@openwrt.org>	<1290524800-21419-10-git-send-email-juhosg@openwrt.org> <AANLkTikQ=oen3jmz=BfY7y=s6Qo7R8DQ1-79puby-Snt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:43767 "EHLO
	phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151Ab0KXSzK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Nov 2010 13:55:10 -0500
In-Reply-To: <AANLkTikQ=oen3jmz=BfY7y=s6Qo7R8DQ1-79puby-Snt@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Gardiner <bengardiner@nanometrics.ca>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, kaloz@openwrt.org, "Luis R. Rodriguez" <lrodriguez@atheros.com>, Cliff Holden <Cliff.Holden@atheros.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mike Frysinger <vapier@gentoo.org>, linux-input@vger.kernel.org

Hi Ben,

> <...>
> I've tested this driver with the da850-evm pushbuttons and switches
> connected to i2c gpio expanders. It works well. The changes to the
> patch series were straightforward: .config, "gpio-keys" ->
> "gpio-buttons", struct gpio_key -> struct gpio_button etc.
> 
> I do have some comments about this patch. But the new driver is
> functional as-is.
> 
> Tested-by: Ben Gardiner <bengardiner@nanometrics.ca>

Thanks!

>><...>
> 
> Since the new gpio_buttons.c driver presents the same input event
> device as the gpio_keys.c driver, I think it should also be a
> drivers/input/keys device.

Makes sense.

> 
>>  [...]
>> diff --git a/drivers/input/misc/gpio_buttons.c b/drivers/input/misc/gpio_buttons.c
> 
> When I was converting the da850-evm platform code to use the new
> driver I felt that the changes did not indicate a switch to a polled
> driver as seems to be the intent with the introduction of a separate
> driver. All that was different in the platform code was 'button' where
> there use to be 'key' and button does not itself convey the knowledge
> that it is a polled input device.
> 
> I know names of drivers can be contentions but I will propose
> regardless that this driver be called gpio-polled-keys /
> gpio_polled_keys.c

I agree, this would be more informative.

>> <...>
>> +       for (i = 0; i < bdev->pdata->nbuttons; i++) {
>> +               struct gpio_button *button = &pdata->buttons[i];
>> +               struct gpio_button_data *bdata = &bdev->data[i];
>> +
>> +               if (bdata->count < button->threshold)
>> +                       bdata->count++;
>> +               else
>> +                       gpio_buttons_check_state(input, button, bdata);
> 
> I think that a count-theshold can still be performed here, but using
> the debounce_interval and polling_interval field specified in the
> gpio_button and gpio_buttons_platform_data structures, respectively,
> to calculate a threshold value.

Good idea. We don't even have to compute a threshold value, we can use the
debounce_interval and poll_interval fields directly. I mean something similar to
this:

<...>
	if (bdata->interval < button->debounce_interval)
		bdata->interval += pdata->poll_interval;
	else
		gpio_buttons_check_state(input, button, bdata);
<...>

> In this way the gpio_button and gpio_keys_button structs are made more
> similar -- differing only in the presence of .wakeup in
> gpio_keys_button but not in gpio_button. Which may make it possible to
> re-use the gpio_keys_button structure.
> 
>> <...>
>> +struct gpio_button {
>> +       int     gpio;           /* GPIO line number */
>> +       int     active_low;
>> +       char    *desc;          /* button description */
>> +       int     type;           /* input event type (EV_KEY, EV_SW) */
>> +       int     code;           /* input event code (KEY_*, SW_*) */
>> +       int     threshold;      /* count threshold */
> 
> Could we instead use the existing struct gpio_keys_button; we could
> transform debounce_interval into a threshold as described above

Sure, we can use that...

> and add an error when a gpio_button_probe() sees a gpio_key with .wakeup ==
> TRUE?

I don't think we should check that, we can simply ignore this field. Maybe we
should add a comment to the .wakeup field to state that the polled driver does
not use that.

> It seems that this structure duplicates alot of the gpio_keys_button
> structure.

Yes, it is almost the same.

>> [...]
>> +struct gpio_buttons_platform_data {
>> +       struct gpio_button *buttons;
>> +       int     nbuttons;               /* number of buttons */
>> +       int     poll_interval;          /* polling interval */
>> +};
> 
> I think the units of poll_interval should be included in the comment.
> i.e. /* polling interval in msecs */

Yes, you are right. Additionally, we should move this structure into
gpio_keys.h, so we can get rid of the gpio_buttons.h file.

Thank you for the valuable comments. I will create a new patch.

Regards,
Gabor
