From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v3 6/6] HID: uclogic: actually invert the in-range bit
 for huion tablets only
Date: Tue, 3 Mar 2015 14:20:29 -0500
Message-ID: <20150303192029.GC21158@mail.corp.redhat.com>
References: <1425404645-20134-1-git-send-email-benjamin.tissoires@redhat.com>
 <1425404645-20134-7-git-send-email-benjamin.tissoires@redhat.com>
 <54F600E2.5040002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38914 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752901AbbCCTUo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 3 Mar 2015 14:20:44 -0500
Content-Disposition: inline
In-Reply-To: <54F600E2.5040002@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>

On Mar 03 2015 or thereabouts, Nikolai Kondrashov wrote:
> On 03/03/2015 07:44 PM, Benjamin Tissoires wrote:
> >This hack is only needed for Huion tablets. It does not seem to have
> >any effect on the other tablets handled by this device right now, but
> >it's better to check for the product id sooner than discovering that
> >we have messed up one tablet later.
> >
> >Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >---
> >
> >changes in v3:
> >- stores a flag to know when to invert the bit.
> >- add #define UCLOGIC_PEN_REPORT_ID
> >
> >new in v2
> >
> >  drivers/hid/hid-uclogic.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> >diff --git a/drivers/hid/hid-uclogic.c b/drivers/hid/hid-uclogic.c
> >index f44e72b..bdda9fd 100644
> >--- a/drivers/hid/hid-uclogic.c
> >+++ b/drivers/hid/hid-uclogic.c
> >@@ -564,6 +564,7 @@ enum uclogic_ph_id {
> >
> >  /* Report descriptor template placeholder */
> >  #define UCLOGIC_PH(_ID) UCLOGIC_PH_HEAD, UCLOGIC_PH_ID_##_ID
> >+#define UCLOGIC_PEN_REPORT_ID	0x07
> 
> It would be nice to also use this macro in the replaced report descriptor
> itself, but this will do for now.

Yeah. I thought about that too. I was about to send it that way, but
then I realized that we do not control the report ID from the device
(it's not overwritten by raw_event()). So it feels weird to just have
this macro in the middle of the report descriptor.
I think we can just leave it as it right now and maybe change the
whole thing later if needed.

> 
> Reviewed-by: Nikolai Kondrashov <spbnick@gmail.com>

Thanks!

> 
> Thanks a lot, Benjamin!
> 

No worries. Thanks for the reviews. Once Jiri will pull these, I'll send
the corresponding patches to DIGImend-devel for the digimend-kernel
tree.

Cheers,
Benjamin

> Nick
> 
> P.S. I like the way you describe the changes between patchset versions, will
>      have to keep it in mind and use in my own.
