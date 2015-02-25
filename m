From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 2/4] HID: uclogic: merge hid-huion driver in hid-uclogic
Date: Wed, 25 Feb 2015 16:28:13 -0500
Message-ID: <20150225212813.GC3097@mail.corp.redhat.com>
References: <1424822730-14938-1-git-send-email-benjamin.tissoires@redhat.com>
 <1424822730-14938-3-git-send-email-benjamin.tissoires@redhat.com>
 <54EE38EA.40702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33702 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752879AbbBYV21 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Feb 2015 16:28:27 -0500
Content-Disposition: inline
In-Reply-To: <54EE38EA.40702@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>

On Feb 25 2015 or thereabouts, Nikolai Kondrashov wrote:
> On 02/25/2015 02:05 AM, Benjamin Tissoires wrote:
> >From: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
> >
> >Merge the hid-huion driver into hid-uclogic as all the devices supported
> >by hid-huion are in fact UC-Logic devices.
> >
> >Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >---
> >
> >Changed from the original patch:
> >- update Makefile, Kconfig accordingly
> >- remove one extra pr_err when kzalloc failed (raised by checkpatch.pl)
> >
> >  drivers/hid/Kconfig       |   8 +-
> >  drivers/hid/Makefile      |   1 -
> >  drivers/hid/hid-huion.c   | 290 ----------------------------------------------
> >  drivers/hid/hid-uclogic.c | 229 +++++++++++++++++++++++++++++++++++-
> >  4 files changed, 229 insertions(+), 299 deletions(-)
> >  delete mode 100644 drivers/hid/hid-huion.c
> >
> >diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> >index 152b006..8a55fd7 100644
> >--- a/drivers/hid/Kconfig
> >+++ b/drivers/hid/Kconfig
> >@@ -286,12 +286,6 @@ config HID_GT683R
> >  	Currently the following devices are know to be supported:
> >  	  - MSI GT683R
> >
> >-config HID_HUION
> >-	tristate "Huion tablets"
> >-	depends on USB_HID
> >-	---help---
> >-	Support for Huion 580 tablet.
> >-
> >  config HID_KEYTOUCH
> >  	tristate "Keytouch HID devices"
> >  	depends on HID
> >@@ -314,7 +308,7 @@ config HID_UCLOGIC
> >  	tristate "UC-Logic"
> >  	depends on HID
> >  	---help---
> >-	Support for UC-Logic tablets.
> >+	Support for UC-Logic and Huion tablets.
> 
> I'm not sure this is worth changing. We'll need to at least add Yiynova and
> Ugee here later, which we're likely to forget. Meanwhile, essentially, they're
> UC-Logic underneath.

Well, true, we will likely forget it. But on the other hand, we should
be consistant with the current state of the kernel. Right now, Huion
users can look for huion in the menuconfig and find something. We should
not remove it :/

> 
> Apart from this (which can be left as is, IMHO):
> 
> Reviewed-by: Nikolai Kondrashov <spbnick@gmail.com>

Could I have your Signed-off-by here, it's mainly your patch, and so I
kept your From.

> 
> BTW, will you be submitting changes to digimend-kernel-drivers to align it
> with what you're submitting upstream?

Yep, as soon as the changes hit Jiri's tree (so they will end end in
Linus' tree at some point), I'll sync the digimend-kernel-drivers.

Cheers,
Benjamin
