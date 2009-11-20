From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Re: ATKBD: adding force-release quirks
Date: Fri, 20 Nov 2009 11:21:10 +0200
Message-ID: <4B065F86.8070702@pardus.org.tr>
References: <20090911051245.GB23210@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lider.pardus.org.tr ([193.140.100.216]:47716 "EHLO
	lider.pardus.org.tr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752203AbZKTJVH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Nov 2009 04:21:07 -0500
In-Reply-To: <20090911051245.GB23210@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, hal@lists.freedesktop.org

Dmitry Torokhov wrote:
> Hi,
>
> It appears that more and more laptops do not send release events for
> their multimedia keys requiring adding their DMI info to the atkbd
> driver. I don't think we can continue this practice any longer and I
> would like to punt this responsibility to HAL/DevKit/whatever. In 2.6.32
> there will be a new sysfs attribute, force_release, attached to the
> serio port that is bound to atkbd driver. Writing to that attribute will
> allow setting a new bitmap for the keys that require forced release,
> reading will produce current bitmap. The format as follows:
>
> echo 133-139,143,147 > /sys/devices/platform/i8042/serio0/force_release
>
>   

Is there currently any work for this support in udev/dk?
