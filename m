From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: introduce device information ioctl
Date: Fri, 17 Dec 2010 11:39:36 -0800
Message-ID: <20101217193935.GB2576@core.coreip.homeip.net>
References: <1292531413-28924-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:59036 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755289Ab0LQTjm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Dec 2010 14:39:42 -0500
Content-Disposition: inline
In-Reply-To: <1292531413-28924-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pingc@wacom.com>, Chris Bagwell <chris@cnpbagwell.com>, Chase Douglas <chase.douglas@canonical.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Dec 16, 2010 at 09:30:13PM +0100, Henrik Rydberg wrote:
> Today, userspace sets up an input device based on the data it emits.
> This is not always enough; a tablet and a touchscreen may emit exactly
> the same data, for instance, but the former should be set up with a
> pointer whereas the latter does not need to. Recently, a new type of
> touchpad has emerged where the buttons are under the pad, which
> changes handling logic without changing the emitted data. This patch
> introduces a new ioctl, EVIOCGPROP, which enables user access to a set
> of device properties useful during setup. The properties are given as
> a bitmap in the same fashion as the event types, and are also made
> available via sysfs.
> 

Looks good to me.

Could you please also wire up /proc/bus/input/devices to show new
'props' (I think we could use  "B: PROP=" tags for them) and also to the
uevent handler?

Thanks.

-- 
Dmitry
