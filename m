From: Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH v1] HID: cp2112: support i2c write-read transfers in
 hid-cp2112
Date: Thu, 9 Jul 2015 14:22:17 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1507091420510.10183@pobox.suse.cz>
References: <1434621340-10422-1-git-send-email-ellen@cumulusnetworks.com> <CAAj6DX03vzNHVLE2gx+zOCud-3WWUnewYCc2-z-wXKhDPHRYQg@mail.gmail.com> <alpine.LNX.2.00.1507081133350.10183@pobox.suse.cz> <559CFC61.6000303@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:34885 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606AbbGIMWn (ORCPT
	<rfc822;groupwise-linux-input@vger.kernel.org:0:0>);
	Thu, 9 Jul 2015 08:22:43 -0400
In-Reply-To: <559CFC61.6000303@cumulusnetworks.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ellen Wang <ellen@cumulusnetworks.com>
Cc: Antonio Borneo <borneo.antonio@gmail.com>, David Barksdale <dbarksdale@uplogix.com>, linux-input <linux-input@vger.kernel.org>, linux-i2c@vger.kernel.org

On Wed, 8 Jul 2015, Ellen Wang wrote:

> > > No need for int; u8 is enough (value is copyed from buf[2] that is u8).
> > > Put the new u8 field few lines below, together with the other u8, to
> > > avoid extra padding.
> > > 
> > > No need to send immediately a new version. Let's see if there is any
> > > other comment and if someone can test it before me.
> > 
> > Antonio, is there any result of your testing? I have put this patch on
> > hold waiting for your word on it, but it has been ~3 weeks already.
> > 
> > Thanks,
> 
> This patch should be applied after my other patch:
> https://patchwork.ozlabs.org/patch/492842/

Well, it actually conflicts with it :) The conflict is easy to resolve, 
but as you might be sending v2 anyway, please rebase it on top of 
for-4.3/cp2112 when doing so.

Thanks,

-- 
Jiri Kosina
SUSE Labs
