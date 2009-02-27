From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH] LED key trigger support
Date: Fri, 27 Feb 2009 11:13:02 +0900
Message-ID: <9c9fda240902261813s70189795hd7fe7c79151d6f87@mail.gmail.com>
References: <20090225093440.GA5414@july>
	 <5d5443650902252305h6e221b4epd724d8331607eebb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.217.174]:40396 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbZB0CNF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Feb 2009 21:13:05 -0500
In-Reply-To: <5d5443650902252305h6e221b4epd724d8331607eebb@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, rpurdie@rpsys.net

On Thu, Feb 26, 2009 at 4:05 PM, Trilok Soni <soni.trilok@gmail.com> wr=
ote:
> Hi Kyungmin,
>
>> +
>> +static int key_notifier_callback(struct notifier_block *nb,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsign=
ed long event, void *data)
>> +{
>> + =A0 =A0 =A0 struct key_trigger_notifier *kn =3D container_of(nb,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 struct key_trigger_notifier, notifier);
>> + =A0 =A0 =A0 struct led_classdev *led =3D kn->led;
>> + =A0 =A0 =A0 unsigned int *key_value =3D (unsigned int *) data;
>
> No need of casting from void *.
>
>> +
>> + =A0 =A0 =A0 /* In case of touchscreen, just skip it */
>> + =A0 =A0 =A0 if (*key_value =3D=3D BTN_TOUCH)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>
> I think this filtering is already done by notification patch.

No, touchscreen also use input_report_key function so it passed BTN_TOU=
CH value.
I don't want to key led blink at touchscreen.
>
>> +
>> + =A0 =A0 =A0 led_set_brightness(led, event);
>> + =A0 =A0 =A0 return 0;
>> +
>> +}
>> +
>> +static void key_led_activate(struct led_classdev *led)
>> +{
>> + =A0 =A0 =A0 struct key_trigger_notifier *kn;
>> + =A0 =A0 =A0 int ret;
>> +
>> + =A0 =A0 =A0 kn =3D kzalloc(sizeof(struct key_trigger_notifier), GF=
P_KERNEL);
>> + =A0 =A0 =A0 if (!kn) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(led->dev, "unable to allocatat=
e key trigger\n");
>
> s/allocatate/allocate

Sorry for typo, I will fix it.

Thank you,
Kyungmin Park
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
