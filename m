From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH] LED key trigger support
Date: Thu, 26 Feb 2009 12:35:45 +0530
Message-ID: <5d5443650902252305h6e221b4epd724d8331607eebb@mail.gmail.com>
References: <20090225093440.GA5414@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:32262 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476AbZBZHFs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Feb 2009 02:05:48 -0500
In-Reply-To: <20090225093440.GA5414@july>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, rpurdie@rpsys.net

Hi Kyungmin,

> +
> +static int key_notifier_callback(struct notifier_block *nb,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigne=
d long event, void *data)
> +{
> + =A0 =A0 =A0 struct key_trigger_notifier *kn =3D container_of(nb,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 struct key_trigger_notifier, notifier);
> + =A0 =A0 =A0 struct led_classdev *led =3D kn->led;
> + =A0 =A0 =A0 unsigned int *key_value =3D (unsigned int *) data;

No need of casting from void *.

> +
> + =A0 =A0 =A0 /* In case of touchscreen, just skip it */
> + =A0 =A0 =A0 if (*key_value =3D=3D BTN_TOUCH)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;

I think this filtering is already done by notification patch.

> +
> + =A0 =A0 =A0 led_set_brightness(led, event);
> + =A0 =A0 =A0 return 0;
> +
> +}
> +
> +static void key_led_activate(struct led_classdev *led)
> +{
> + =A0 =A0 =A0 struct key_trigger_notifier *kn;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 kn =3D kzalloc(sizeof(struct key_trigger_notifier), GFP=
_KERNEL);
> + =A0 =A0 =A0 if (!kn) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(led->dev, "unable to allocatate=
 key trigger\n");

s/allocatate/allocate

--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
