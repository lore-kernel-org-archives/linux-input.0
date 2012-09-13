From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: fix input_open_file() accessing out-of-bound
 buffers
Date: Thu, 13 Sep 2012 09:57:17 -0700
Message-ID: <20120913165717.GB3519@core.coreip.homeip.net>
References: <1347553050-25480-1-git-send-email-dh.herrmann@googlemail.com>
 <CANq1E4Rs7ue8E7prx8KQ=UxLrhRdYA9YV7URGHLiV3yGAmrePA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56177 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755012Ab2IMQ5X (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Sep 2012 12:57:23 -0400
Received: by pbbrr13 with SMTP id rr13so4248197pbb.19
        for <linux-input@vger.kernel.org>; Thu, 13 Sep 2012 09:57:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANq1E4Rs7ue8E7prx8KQ=UxLrhRdYA9YV7URGHLiV3yGAmrePA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org

Hi David,

On Thu, Sep 13, 2012 at 06:18:17PM +0200, David Herrmann wrote:
> Hi Dmitry
> 
> On Thu, Sep 13, 2012 at 6:17 PM, David Herrmann
> <dh.herrmann@googlemail.com> wrote:
> > The "input_table" array is very small and we cannot be sure that the file
> > the user opens has a minor-ID below 256 (8 << 5). Hence, simply check that
> > the minor isn't out-of-bounds. If it is, return -ENODEV.
> >
> > Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> > Cc: <stable@kernel.org>
> 
> This should be "Cc: <stable@vger.kernel.org>". Sorry for the typo.

register_chrdev() reserves exactly 256 minors so it is not possible for
input_open_file() to be called with minor that will get us out of
bounds.

Thanks.

-- 
Dmitry
