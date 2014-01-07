From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Bluetooth: hidp: make sure input buffers are big
 enough
Date: Tue, 7 Jan 2014 13:11:03 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1401071308020.4962@pobox.suse.cz>
References: <1387451372-6881-1-git-send-email-dh.herrmann@gmail.com> <3109C2D8-E01C-4728-A593-1978BB3D202D@holtmann.org> <CANq1E4TOHvb3--H6SoRhB09sUwuYkrvSAXCNN2Y0PaVSOEte=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57900 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751095AbaAGMLG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 7 Jan 2014 07:11:06 -0500
In-Reply-To: <CANq1E4TOHvb3--H6SoRhB09sUwuYkrvSAXCNN2Y0PaVSOEte=w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, "linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>, "Gustavo F. Padovan" <gustavo@padovan.org>

On Fri, 27 Dec 2013, David Herrmann wrote:

> >> I also haven't figured out a nice way to make HID-core honor the 
> >> "size" parameter. hid-input depends on getting the whole 
> >> input-report.
> >
> > I think this needs clearly fixing.
> 
> And we have a volunteer, yippie! ;)
> 
> I think hid_input_report() in hid-core.c is the only place that relies
> on this. Maybe it really is easier to fix it. But I am not even
> slightly familiar with that code. So if no-one of the HID core
> developers steps up to fix it, we should take the transport-driver
> fixes instead. As nearly all transport-drivers are affected by this,
> maybe we should even move this buffer into hid_device and provide
> hid_input_truncated_report() which does this.
> 
> Anyhow, waiting for Jiri's comments on this.

Hmm, this is really unfortunate situation.

I am now looking into making hid_input_report() honor 'size' properly, but 
no matter how it'll be done in the end, it'll absolutely not be a simple 
'fix'. So definitely can be done for 3.15 or so, but not as a fix for 
current kernels.

So doing kzalloc(rsize, GFP_ATOMIC) in the HID-core for now, and copying 
the buffer around, seems like only viable solution for now, with the 
outlook of removing this ugliness once hid-core honors 'size' properly.

I will keep looking into this and maybe some easy way how to hack this 
together will materialize, but I don't currently see it.

Hmm ...

-- 
Jiri Kosina
SUSE Labs
