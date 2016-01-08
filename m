From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [Patch-V2 1/6] INPUT: xpad: Add minimal support for Logitech
 G920 Wheel
Date: Fri, 8 Jan 2016 10:11:59 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1601081009561.3402@cbobk.fhfr.pm>
References: <1447345535-2912-1-git-send-email-simon@mungewell.org> <1447345535-2912-2-git-send-email-simon@mungewell.org> <alpine.LNX.2.00.1511191449130.20111@pobox.suse.cz> <20151119183106.GC24773@dtor-ws> <CAKdAkRTaTA8KFQripYP0ZcFb+5G7OC_Ecnhrwum4L9hsQ-PVxg@mail.gmail.com>
 <CAKdAkRRBtVfTss9AV+DgTtCXf8PVks5pCB4VnR5sQvgW=S3HyA@mail.gmail.com> <20151210170853.GC16026@mail.corp.redhat.com> <CAKdAkRSBTBTW8ma79hh+0sr4izJ70SnvUb1gmPFy3MoVWYaUbA@mail.gmail.com> <20160104095524.GB20222@mail.corp.redhat.com> <alpine.LNX.2.00.1601061535440.3402@cbobk.fhfr.pm>
 <20160107014721.GA35823@dtor-ws>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52530 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751314AbcAHJMD (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 8 Jan 2016 04:12:03 -0500
In-Reply-To: <20160107014721.GA35823@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Edwin <Edwin@velds.nl>, =?ISO-8859-15?Q?Michal_Mal=FD?= <madcatxster@devoid-pointer.net>, elias vanderstuyft <elias.vds@gmail.com>

Alright, so what I am planning to do is to drop 27b9d5a254d ("INPUT: xpad: 
switch Logitech G920 Wheel into HID mode") from the for-4.5/logitech 
branch, while keeping the rest of the G920 support in, so that it 
immediately starts working once proper HID-mode switching is implemented.

If anyone has objections to this aproach, please speak up.

Thanks,

-- 
Jiri Kosina
SUSE Labs

