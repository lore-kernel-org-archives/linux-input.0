From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Bluetooth: hidp: make sure input buffers are big
 enough
Date: Tue, 28 Jan 2014 21:53:00 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1401282152140.22492@pobox.suse.cz>
References: <1387451372-6881-1-git-send-email-dh.herrmann@gmail.com> <3109C2D8-E01C-4728-A593-1978BB3D202D@holtmann.org> <CANq1E4TOHvb3--H6SoRhB09sUwuYkrvSAXCNN2Y0PaVSOEte=w@mail.gmail.com> <alpine.LNX.2.00.1401071308020.4962@pobox.suse.cz>
 <CANq1E4SxrDnbOCsohZXYoYL-HQjEc-xcOnXfAm=npHG2QfMS9A@mail.gmail.com> <alpine.LNX.2.00.1401071811530.4962@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37886 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755694AbaA1UxF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Jan 2014 15:53:05 -0500
In-Reply-To: <alpine.LNX.2.00.1401071811530.4962@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, "linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>, "Gustavo F. Padovan" <gustavo@padovan.org>

On Tue, 7 Jan 2014, Jiri Kosina wrote:

> > > So doing kzalloc(rsize, GFP_ATOMIC) in the HID-core for now, and copying
> > > the buffer around, seems like only viable solution for now, with the
> > > outlook of removing this ugliness once hid-core honors 'size' properly.
> > 
> > Should I resend the patches and move it to hid_input_report() for now?
> > Or are you getting something in yourself?
> 
> Due to various reasons I will not have access to any testing HW for the 
> upcoming 2-3 days, so if you can cook something up in that timeframe, it'd 
> be appreciated.
> 
> Otherwise I'll be working on it by the end of this week.

David,

just got back to this, finally ... did you have time to work on this at 
all, or should I just start from scratch?

> > Given the amount of reports on the list and bugzilla, I think we should 
> > get this fix in asap. We can always fix it properly in -next.
> 
> Agreed.

-- 
Jiri Kosina
SUSE Labs
