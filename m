From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] gpio_keys, twl4030-pwrbutton: stay awake for 1sec on resume
Date: Sat, 28 Jun 2014 19:57:53 +0200
Message-ID: <BD5D0538-BD03-4CD8-8E12-2344AD7ED669@goldelico.com>
References: <1403906118-23517-1-git-send-email-lukas@goldelico.com> <20140628170820.GF23634@xo-6d-61-c0.localdomain>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140628170820.GF23634@xo-6d-61-c0.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Lukas M?rdian <lukas@goldelico.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Marek Belisko <marek@goldelico.com>
List-Id: linux-input@vger.kernel.org

Hi,
Am 28.06.2014 um 19:08 schrieb Pavel Machek:

> Hi!
>=20
>> This gives the userspace (Replicant) a chance to fully handle the
>> pm_wakeup_event, before autosleep suspends the system alltogether
>> again.
>>=20
>> This fixes suspend/resume on the OpenPhoenux GTA04, in combination w=
ith
>> the Replicant 4.2.2 userspace, which needs to execute this to stay
>> awake: 'echo on > /sys/power/state'
>>=20
>> Signed-off-by: Lukas M=E4rdian <lukas@goldelico.com>
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>=20
> I'm sorry, but we should not be doing this.
>=20
> You basically put a delay in driver to work around userspace bug.

Do you think it is a user-space bug if the kernel goes to sleep again
before giving user space any chance to react to an event?

And the msec parameter is described as:

@msec: Anticipated event processing time (in milliseconds).

Isn't calling pm_wakeup_event() with a non-zero msec the standard
method to handle this situation? And it is used in other drivers. E.g. =
in
_mmc_detect_change() or hub_suspend().

And if I understand the code of __pm_wakeup_event() correctly it does
*not* delay, but just modifies the wakeup_source timer to expire a litt=
le
later. I.e. keep the system longer awake. So as long as the system is
not suspended there is no difference to current driver.

> There must be better
> solution....

I am not sure how it could look like.

-- hns--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
