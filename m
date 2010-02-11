From: Ed Tomlinson <edt@aei.ca>
Subject: Re: [PATCH 2/2] Add a device driver for the Apple Magic Mouse (2.6.32.8)
Date: Thu, 11 Feb 2010 07:51:14 -0500
Message-ID: <201002110751.14813.edt@aei.ca>
References: <alpine.LNX.2.00.1001291515560.356@pobox.suse.cz> <201002102205.58967.edt@aei.ca> <878wb0e9w2.fsf@troilus.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail001.aei.ca ([206.123.6.130]:44056 "EHLO mail001.aei.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754014Ab0BKMvS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Feb 2010 07:51:18 -0500
In-Reply-To: <878wb0e9w2.fsf@troilus.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Poole <mdpoole@troilus.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 10 February 2010 22:20:13 Michael Poole wrote:
> Ed Tomlinson writes:
> 
> > Hi,
> >
> > When I apply this to head, I get:
> >
> > drivers/hid/hid-magicmouse.c: In function 'magicmouse_probe':                                                         
> > drivers/hid/hid-magicmouse.c:393: error: too many arguments to function 'hdev->hid_output_raw_report'                 
> > drivers/hid/hid-magicmouse.c:400: error: too many arguments to function 'hdev->hid_output_raw_report'                 
> >
> > I only need the second patch - the first seems to be in tree.
> >
> > Any ideas as to what I am missing?
> >
> > TIA
> > Ed
> 
> You're missing the patch that makes hid_output_raw_report() more generic.
> It is in the HID tree[1] as commit d4bfa033.
> 
> [1]- http://git.kernel.org/?p=linux/kernel/git/jikos/hid.git

Ok.  With this I have a patchset that applies to 2.6.32.8.  If anyone wants it
just email.  

Of course, Michael's cleanups came just after I booted with the new kernel.  I'll
apply it and update & post my changes that allow both x and y scrolling and almost 
work for a few multitouch gestures.

Ed
