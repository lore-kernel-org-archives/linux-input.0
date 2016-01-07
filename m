From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Patch-V2 1/6] INPUT: xpad: Add minimal support for Logitech
 G920 Wheel
Date: Wed, 6 Jan 2016 17:47:21 -0800
Message-ID: <20160107014721.GA35823@dtor-ws>
References: <1447345535-2912-1-git-send-email-simon@mungewell.org>
 <1447345535-2912-2-git-send-email-simon@mungewell.org>
 <alpine.LNX.2.00.1511191449130.20111@pobox.suse.cz>
 <20151119183106.GC24773@dtor-ws>
 <CAKdAkRTaTA8KFQripYP0ZcFb+5G7OC_Ecnhrwum4L9hsQ-PVxg@mail.gmail.com>
 <CAKdAkRRBtVfTss9AV+DgTtCXf8PVks5pCB4VnR5sQvgW=S3HyA@mail.gmail.com>
 <20151210170853.GC16026@mail.corp.redhat.com>
 <CAKdAkRSBTBTW8ma79hh+0sr4izJ70SnvUb1gmPFy3MoVWYaUbA@mail.gmail.com>
 <20160104095524.GB20222@mail.corp.redhat.com>
 <alpine.LNX.2.00.1601061535440.3402@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35367 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905AbcAGBrY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Jan 2016 20:47:24 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1601061535440.3402@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Edwin <Edwin@velds.nl>, Michal =?iso-8859-1?Q?Mal=FD?= <madcatxster@devoid-pointer.net>, elias vanderstuyft <elias.vds@gmail.com>

On Wed, Jan 06, 2016 at 03:36:57PM +0100, Jiri Kosina wrote:
> On Mon, 4 Jan 2016, Benjamin Tissoires wrote:
> 
> > Jiri, I *think* this commit still is in your next pull request for
> > Linus. We might want to drop it before it hits Linus' tree.
> 
> What exactly would be the reasoning for dropping it?

It is wrong. Aside form the fact that IMO xpad.c is the wrong place for
this code to be in, why are we waiting for the input device to be
opened by userspace before we do the switch instead of doing it
immediately?

Thanks.

-- 
Dmitry
