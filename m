From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 5/5] input: wacom - retrieve maximum number of contacts
Date: Tue, 16 Aug 2011 23:52:04 -0700
Message-ID: <20110817065204.GD29361@core.coreip.homeip.net>
References: <1313194205-5098-1-git-send-email-pinglinux@gmail.com>
 <CAGzDe_Zih_GWOPYmS74S68JNc-RkQ_-zg3+DY1+2zUmr6=Ocow@mail.gmail.com>
 <CAF8JNhLOQo_HdrXrjbDJqx_M6Mcb0puXJ80vNPaQeY1kOr-UNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f170.google.com ([209.85.210.170]:40734 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813Ab1HQGwK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Aug 2011 02:52:10 -0400
Received: by iye16 with SMTP id 16so1328541iye.1
        for <linux-input@vger.kernel.org>; Tue, 16 Aug 2011 23:52:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAF8JNhLOQo_HdrXrjbDJqx_M6Mcb0puXJ80vNPaQeY1kOr-UNA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Chris Bagwell <chris@cnpbagwell.com>, linux-input@vger.kernel.org

On Mon, Aug 15, 2011 at 09:12:16PM -0700, Ping Cheng wrote:
> On Sun, Aug 14, 2011 at 8:37 PM, Chris Bagwell <chris@cnpbagwell.com> wrote:
> 
> > On Fri, Aug 12, 2011 at 7:10 PM, Ping Cheng <pinglinux@gmail.com> wrote:
> > > Retrieve it from the HID descriptor when it is available
> >
> > Were you going to use touch_max for something (since its not referenced)?
> >
> 
> This set of patches is only a clean-up and preparation for the coming set of
> patches. The value will be used then.

OK, then I think it is best to submit this one with that set. I applied
the other 3 patches, but not the 'pressure' one.

-- 
Dmitry
