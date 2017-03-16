From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 0/2] HID: wacom: patches for 4.11
Date: Thu, 16 Mar 2017 21:23:38 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1703162122540.31814@cbobk.fhfr.pm>
References: <1488826498-8578-1-git-send-email-skomra@gmail.com> <20170307103416.GB24124@mail.corp.redhat.com> <CAF8JNh+bwaDr+1oO=c0R2=X7HfPc_apvTRXQNX_3uo9d2ANizQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41714 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751960AbdCPUno (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 16 Mar 2017 16:43:44 -0400
In-Reply-To: <CAF8JNh+bwaDr+1oO=c0R2=X7HfPc_apvTRXQNX_3uo9d2ANizQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Aaron Armstrong Skomra <skomra@gmail.com>, linux-input <linux-input@vger.kernel.org>, Jason Gerecke <killertofu@gmail.com>

On Tue, 14 Mar 2017, Ping Cheng wrote:

> >> Aaron Armstrong Skomra (2):
> >>   HID: wacom: Correct Intuos Pro 2 resolution
> >>   HID: wacom: don't manually release resources for the EKR
> >
> > Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >
> > Aaron told me about the issue in patch 2/2, so it's not news to me.
> >>
> >>  drivers/hid/wacom_sys.c | 4 +++-
> >>  drivers/hid/wacom_wac.c | 4 ++--
> >>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> I don't see the two patches under for-4.11/upstream-fixes. Do you have
> questions about the patches?

Nope (or not yet at least), I haven't processed them yet. -rc3 or -rc4 is 
still a target for those.

-- 
Jiri Kosina
SUSE Labs

