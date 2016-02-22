From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH v2 0/8] EC-based USB Power Delivery support for Chrome machines
Date: Mon, 22 Feb 2016 08:56:24 +0100
Message-ID: <CAAObsKBB8-VR3hGdHqATtKMfpxnFasRvn4ucCxvdNQOfrGQdyg@mail.gmail.com>
References: <1455281825-23526-1-git-send-email-tomeu.vizoso@collabora.com> <20160220162211.GA4662@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:34470 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877AbcBVH4q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Feb 2016 02:56:46 -0500
In-Reply-To: <20160220162211.GA4662@amd>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sameer Nanda <snanda@chromium.org>, Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>, =?UTF-8?Q?Enric_Balletb=C3=B2?= <enric.balletbo@collabora.co.uk>, Vic Yang <victoryang@chromium.org>, Vincent Palatin <vpalatin@chromium.org>, Randall Spangler <rspangler@chromium.org>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-input@vger.kernel.org, Olof Johansson <olof@lixom.net>

On 20 February 2016 at 17:22, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> this series contains a driver that exposes a power_supply to userspace
>> representing a port that support USB PD charging.
>
> Well, if this is meant for userspace, should it add some
> documentation, too?

Hi Pavel, in v3 I have dropped any new sysfs attributes, so everything
exposed to userspace is already documented.

Thanks,

Tomeu

> Thanks,
>                                                                 Pavel
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
