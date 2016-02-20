From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 0/8] EC-based USB Power Delivery support for Chrome
 machines
Date: Sat, 20 Feb 2016 17:22:11 +0100
Message-ID: <20160220162211.GA4662@amd>
References: <1455281825-23526-1-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60234 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987AbcBTQWS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 20 Feb 2016 11:22:18 -0500
Content-Disposition: inline
In-Reply-To: <1455281825-23526-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, Sameer Nanda <snanda@chromium.org>, Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>, Enric =?iso-8859-1?Q?Balletb=F2?= <enric.balletbo@collabora.co.uk>, Vic Yang <victoryang@chromium.org>, Vincent Palatin <vpalatin@chromium.org>, Randall Spangler <rspangler@chromium.org>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-input@vger.kernel.org, Olof Johansson <olof@lixom.net>

Hi!

> this series contains a driver that exposes a power_supply to userspace
> representing a port that support USB PD charging.

Well, if this is meant for userspace, should it add some
documentation, too?

Thanks,
								Pavel
								
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
