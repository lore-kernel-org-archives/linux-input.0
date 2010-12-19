From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v2] Input: introduce device properties
Date: Sun, 19 Dec 2010 09:54:28 +0100
Message-ID: <20101219085428.GB5892@polaris.bitmath.org>
References: <1292702719-1552-1-git-send-email-rydberg@euromail.se>
 <20101219080723.GB10074@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:46739 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750950Ab0LSIyr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 19 Dec 2010 03:54:47 -0500
Content-Disposition: inline
In-Reply-To: <20101219080723.GB10074@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Dec 19, 2010 at 12:07:23AM -0800, Dmitry Torokhov wrote:
> On Sat, Dec 18, 2010 at 09:05:19PM +0100, Henrik Rydberg wrote:
> > Today, userspace sets up an input device based on the data it emits.
> > This is not always enough; a tablet and a touchscreen may emit exactly
> > the same data, for instance, but the former should be set up with a
> > pointer whereas the latter does not need to. Recently, a new type of
> > touchpad has emerged where the buttons are under the pad, which
> > changes logic without changing the emitted data. This patch introduces
> > a new ioctl, EVIOCGPROP, which enables user access to a set of device
> > properties useful during setup. The properties are given as a bitmap
> > in the same fashion as the event types, and are also made available
> > via sysfs, uevent and /proc/bus/input/devices.
> > 
> > Acked-by: Ping Cheng <pingc@wacom.com>
> > Acked-by: Chase Douglas <chase.douglas@canonical.com>
> > Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> 
> Looks good to me, thanks for making changes.

Thank you, I take that as an ack, then.
 
> BTW, we need to figure out how to tell when you CC me for review/FYI but
> will push the patch through your tree and when you want me to apply the
> patch directly to my tree.

Right, the subject is supposed to tell, but more often it becomes a
question of patch ordering and testing convenience. It seems
everything queued for next has been going through my tree, so maybe
that should be the default. Had the present patch really been for
2.6.37, for example, it would have been more convenient to have it
applied directly to your tree.

Makes sense?

Henrik
