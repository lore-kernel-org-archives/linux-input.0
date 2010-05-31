From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] drivers: remove all i2c_set_clientdata(client, NULL)
Date: Mon, 31 May 2010 22:57:50 +0200
Message-ID: <20100531225750.0dc18950@hyperion.delvare>
References: <1275310552-14685-1-git-send-email-w.sang@pengutronix.de>
	<20100531190911.GC30712@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100531190911.GC30712-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, George Joseph <george.joseph-H+B1fhQ+CpcEVd8bySq3Wg@public.gmane.org>, Riku Voipio <riku.voipio-X3B1VOXEql0@public.gmane.org>, Guillaume Ligneul <guillaume.ligneul-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Alessandro Rubini <rubini-JCs+bAQazDroPXhRcRtihA@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Colin Leroy <colin-5s/l0yV9g/OsTnJN9+BGXg@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Mauro Carvalho Chehab <mchehab-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Liam Girdwood <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>, Paul Gortmaker <p_gortmaker-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-media-u79uwXL29TaqPxH82wqD4g@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On Mon, 31 May 2010 12:09:12 -0700, Dmitry Torokhov wrote:
> Frankly I'd prefer taking input stuff through my tree with the goal of
> .36 merge window just to minimize potential merge issues. This is a
> simple cleanup patch that has no dependencies, so there is little gain
> from doing it all in one go.

If I take the patch in my i2c tree, the aim is to merge it upstream
immediately, so merge issues won't exist.

-- 
Jean Delvare
