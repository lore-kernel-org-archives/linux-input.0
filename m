From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] gpio_keys, twl4030-pwrbutton: stay awake for 1sec on
 resume
Date: Sat, 28 Jun 2014 19:08:21 +0200
Message-ID: <20140628170820.GF23634@xo-6d-61-c0.localdomain>
References: <1403906118-23517-1-git-send-email-lukas@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1403906118-23517-1-git-send-email-lukas@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukas M?rdian <lukas@goldelico.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-input@vger.kernel.org

Hi!

> This gives the userspace (Replicant) a chance to fully handle the
> pm_wakeup_event, before autosleep suspends the system alltogether
> again.
>=20
> This fixes suspend/resume on the OpenPhoenux GTA04, in combination wi=
th
> the Replicant 4.2.2 userspace, which needs to execute this to stay
> awake: 'echo on > /sys/power/state'
>=20
> Signed-off-by: Lukas M=E4rdian <lukas@goldelico.com>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

I'm sorry, but we should not be doing this.

You basically put a delay in driver to work around userspace bug. There=
 must be better
solution....

										Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
