From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/5] input: Add new sun4i-ts driver for
 Allwinner sunxi SoC's
Date: Tue, 24 Dec 2013 23:24:02 +0100
Message-ID: <1387923847-1294-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBD4T5CKQKGQEBVQT5PA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Dimitri,

Here is a new driver for the resistive touchscreen controller found in
Allwinner sunxi SoC's. Please review, and when ready pull this driver into
your tree for Linus.

This series consist of 5 patches, the 1st patch is the actual new driver,
the 2nd patch extends it with support for the temperature sensor built into
the rtp controller. Since this depends on the 1st one I would like to ask
you to pull it into your tree too. I've written and maintain several hwmon
drivers, so I'm confident the hwmon bits are solid, I've also CC-ed the
sensors list so that they can review and if they've any comments I will of
course fix those and send a new version.

Patch 3-5 are dts patches adding the controller to the dts files describing
the sunxi SoC variants. These will be merged through Maxime Ripard's tree,
and are here so that the dts bits can be reviewed at the same time. I'll ask
Maxime to merge them once you're happy with Patch 1 + 2.

Thanks & Regards,

Hans
