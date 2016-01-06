From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [Patch-V2 1/6] INPUT: xpad: Add minimal support for Logitech
 G920 Wheel
Date: Wed, 6 Jan 2016 15:36:57 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1601061535440.3402@cbobk.fhfr.pm>
References: <1447345535-2912-1-git-send-email-simon@mungewell.org> <1447345535-2912-2-git-send-email-simon@mungewell.org> <alpine.LNX.2.00.1511191449130.20111@pobox.suse.cz> <20151119183106.GC24773@dtor-ws> <CAKdAkRTaTA8KFQripYP0ZcFb+5G7OC_Ecnhrwum4L9hsQ-PVxg@mail.gmail.com>
 <CAKdAkRRBtVfTss9AV+DgTtCXf8PVks5pCB4VnR5sQvgW=S3HyA@mail.gmail.com> <20151210170853.GC16026@mail.corp.redhat.com> <CAKdAkRSBTBTW8ma79hh+0sr4izJ70SnvUb1gmPFy3MoVWYaUbA@mail.gmail.com> <20160104095524.GB20222@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52805 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752522AbcAFOhC (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 6 Jan 2016 09:37:02 -0500
In-Reply-To: <20160104095524.GB20222@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Simon Wood <simon@mungewell.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Edwin <Edwin@velds.nl>, =?ISO-8859-15?Q?Michal_Mal=FD?= <madcatxster@devoid-pointer.net>, elias vanderstuyft <elias.vds@gmail.com>

On Mon, 4 Jan 2016, Benjamin Tissoires wrote:

> Jiri, I *think* this commit still is in your next pull request for
> Linus. We might want to drop it before it hits Linus' tree.

What exactly would be the reasoning for dropping it?

I am all for implementing the skeleton HID driver to take over the xpad.c 
heavylifting, but before that work gets done, this can stay, can't it?

Thanks,

-- 
Jiri Kosina
SUSE Labs

