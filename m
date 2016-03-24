From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [REGRESSION] panic with Wacom One Tablet on 4.4.x kernel
Date: Thu, 24 Mar 2016 15:43:04 +0100
Message-ID: <20160324144304.GB7602@mail.corp.redhat.com>
References: <56E9D929.70101@redhat.com>
 <CAF8JNhKJLzvj=Xe8ibNCJ6-U9fJqjHFzg0uibFTBSxR4t-AmXA@mail.gmail.com>
 <alpine.LNX.2.00.1603241530370.3656@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53478 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751805AbcCXOnJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Mar 2016 10:43:09 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1603241530370.3656@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Ping Cheng <pinglinux@gmail.com>, Laura Abbott <labbott@redhat.com>, Ping Cheng <pingc@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mar 24 2016 or thereabouts, Jiri Kosina wrote:
> On Wed, 16 Mar 2016, Ping Cheng wrote:
> 
> > Yes, please provide a bisect report so we get a clue.
> > 
> > I do not have a "Wacom One". I have a Wacom Bamboo Pen, which goes 
> > through the same code base as "Wacom One". I tested kernel 4.4.4. I 
> > don't see the issue.
> 
> Laura, do we have any result from the bisect please?
> 

Well, there are two users with the problem, one on Arch (reported
through linuxwacom[1]) and one on Fedora[2] that Laura mentioned. If you look
at the Fedora bug, you'll see that I found an issue in the wacom driver
that fixes the crash, and seems to make the Fedora user happy. However,
the same patch is not sufficient for the Arch user, and we are trying to
get to it in the meantime.
I think I can safely send the fix for the oops now, but we need some
clarifications on the linuxwacom issues we are seeing.

[1] https://sourceforge.net/p/linuxwacom/bugs/311/
[2] https://bugzilla.redhat.com/show_bug.cgi?id=1317116

Cheers,
Benjamin

