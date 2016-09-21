From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: alps: fix stick device not working after resume
Date: Wed, 21 Sep 2016 14:00:11 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1609211359320.22028@cbobk.fhfr.pm>
References: <20160919074139.2551-1-kai.heng.feng@canonical.com> <alpine.LNX.2.00.1609191436370.22028@cbobk.fhfr.pm> <CAAd53p54k3JMEBNqVF3UR9NGwLNuuh9P_vMh8NoggFUfwCoADA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54228 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753281AbcIUMAR (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 21 Sep 2016 08:00:17 -0400
In-Reply-To: <CAAd53p54k3JMEBNqVF3UR9NGwLNuuh9P_vMh8NoggFUfwCoADA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kai Heng Feng <kai.heng.feng@canonical.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, masaki.ota@jp.alps.com

On Mon, 19 Sep 2016, Kai Heng Feng wrote:

> >> The stick device does not work after resume, add U1_SP_ABS_MODE flag can
> >> make the device work after resume.
> >
> > Do you happen to have any more details on why it doesn't work without
> > U1_SP_ABS_MODE? Or was this a pure guesswork?
> 
> It' pure guesswork, based on how the existing code uses U1_TP_ABS_MODE flag
> on both initialization and resume.
> 
> I also tested the the patch on an ALPS touchpad without stick device,
> did not notice
> any side effect on suspend/resume, so I made the U1_SP_ABS_MODE flag mandatory.

I'll fold this information into the patch changelog before comitting; if 
you disagree, please let me know. 

-- 
Jiri Kosina
SUSE Labs

