From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: Re: [PATCH]input: Change timer function to workqueue for gpio_keys
	driver
Date: Thu, 25 Jun 2009 13:29:25 +0300
Message-ID: <359ed6810906250329x70cf380cy278f23e3ebc6a829@mail.gmail.com>
References: <20090608152420.0e76c302@dxy.sh.intel.com>
	 <5d5443650906121040n3f36c99eka01f5eb5274ee6ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:36536 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683AbZFYK3X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Jun 2009 06:29:23 -0400
In-Reply-To: <5d5443650906121040n3f36c99eka01f5eb5274ee6ff@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Alek Du <alek.du@intel.com>
Cc: Trilok Soni <soni.trilok@gmail.com>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, ben-linux@fluff.org

On Fri, Jun 12, 2009 at 8:40 PM, Trilok Soni<soni.trilok@gmail.com> wro=
te:
>> =C2=A0static irqreturn_t gpio_keys_isr(int irq, void *dev_id)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct gpio_button_data *bdata =3D dev_id=
;
>> @@ -62,10 +61,10 @@ static irqreturn_t gpio_keys_isr(int irq, void *=
dev_id)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0BUG_ON(irq !=3D gpio_to_irq(button->gpio)=
);
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (button->debounce_interval)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mod_timer(&bdata-=
>timer,
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 jiffies + msecs_to_jiffies(button->debounce_interval));
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 schedule_delayed_=
work(&bdata->work,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 msecs_to_jiffies(button->debounce_interval));
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0else
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gpio_keys_report_=
event(bdata);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 schedule_work(&bd=
ata->work.work);
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_HANDLED;
>> =C2=A0}

Correct me if I'm wrong, but as far as I can tell,
schedule_delayed_work doesn't modify the timer if the work was already
pending. The result is not the same as with the timer. This breaks the
debouncing.

It looks like a slightly modified version of this patch has already
been committed [1], but it has the same problem.

[1] 0b346838c5862bfe911432956a106d602535d030 Input: gpio-keys - change
timer to workqueue


BR,
Jani.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
