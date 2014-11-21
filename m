From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/2] HID: wacom: Report ABS_TILT_{X,Y} as signed values
Date: Fri, 21 Nov 2014 22:41:28 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1411212241100.23174@pobox.suse.cz>
References: <1416358209-3937-1-git-send-email-killertofu@gmail.com> <CAF8JNhJMcD2QcC-Gp9+avxdQUpEjyTJ=R3-XKv+1Sm-uYhxNXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34581 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751738AbaKUVlV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Nov 2014 16:41:21 -0500
In-Reply-To: <CAF8JNhJMcD2QcC-Gp9+avxdQUpEjyTJ=R3-XKv+1Sm-uYhxNXg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Jason Gerecke <killertofu@gmail.com>, linux-input <linux-input@vger.kernel.org>, benjamin.tissores@gmail.com

On Fri, 21 Nov 2014, Ping Cheng wrote:

> On Tue, Nov 18, 2014 at 4:50 PM, Jason Gerecke <killertofu@gmail.com> wrote:
> > Centers the ABS_TILT_{X,Y} axes so that a value of zero is reported when
> > the pen is vertical. Combined with resolution information in the next
> > patch, this makes it possible for userspace to calculate the pen angle
> > without needing hardware-specific knowledge. The xf86-input-wacom driver
> > was updated to support signed tilt values in late-2012 (2f2acec).
> >
> > Signed-off-by: Jason Gerecke <killertofu@gmail.com>
> 
> Reviewed-by: Ping Cheng <pingc@wacom.com> for the series.

Series now queued in for-3.19/wacom. Thanks,

-- 
Jiri Kosina
SUSE Labs
