From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: wacom: remove the extra Pen interface for Wacom
 Bamboo PAD
Date: Tue, 7 Jul 2015 10:04:07 -0400
Message-ID: <20150707140407.GB18484@mail.corp.redhat.com>
References: <1434657524-5374-1-git-send-email-benjamin.tissoires@redhat.com>
 <alpine.LNX.2.00.1506291425410.10183@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37559 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753396AbbGGOEK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 7 Jul 2015 10:04:10 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1506291425410.10183@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.com>
Cc: Jason Gerecke <killertofu@gmail.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Jun 29 2015 or thereabouts, Jiri Kosina wrote:
> On Thu, 18 Jun 2015, Benjamin Tissoires wrote:
> 
> > As mentioned in the comment in the code, both the pen and touch data
> > come from the interface tagged as BAMBOO_PAD. The driver re-routes the
> > events for the Pen to the generic HID interface and keeps the ones for
> > the touch through this current interface.
> > 
> > Clearing the WACOM_DEVICETYPE_PEN bit removes the extra unused interface
> > and makes the Bamboo PAD to behave like in 4.1.
> > 
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> Could you please be a little bit more specific about which commit this is 
> a bugfix for?
> 

Jason, Jiri,

OK, I will amend the patch and send a v2 this week (Thursday maybe when
I get my hand on the Bamboo PAD).

Cheers,
Benjamin
