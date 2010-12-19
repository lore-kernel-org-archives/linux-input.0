From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: introduce device properties
Date: Sun, 19 Dec 2010 00:07:23 -0800
Message-ID: <20101219080723.GB10074@core.coreip.homeip.net>
References: <1292702719-1552-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:55137 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159Ab0LSIHa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 19 Dec 2010 03:07:30 -0500
Content-Disposition: inline
In-Reply-To: <1292702719-1552-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Dec 18, 2010 at 09:05:19PM +0100, Henrik Rydberg wrote:
> Today, userspace sets up an input device based on the data it emits.
> This is not always enough; a tablet and a touchscreen may emit exactly
> the same data, for instance, but the former should be set up with a
> pointer whereas the latter does not need to. Recently, a new type of
> touchpad has emerged where the buttons are under the pad, which
> changes logic without changing the emitted data. This patch introduces
> a new ioctl, EVIOCGPROP, which enables user access to a set of device
> properties useful during setup. The properties are given as a bitmap
> in the same fashion as the event types, and are also made available
> via sysfs, uevent and /proc/bus/input/devices.
> 
> Acked-by: Ping Cheng <pingc@wacom.com>
> Acked-by: Chase Douglas <chase.douglas@canonical.com>
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>

Looks good to me, thanks for making changes.

BTW, we need to figure out how to tell when you CC me for review/FYI but
will push the patch through your tree and when you want me to apply the
patch directly to my tree.

Thanks.

-- 
Dmitry
