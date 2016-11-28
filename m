From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2 0/3] Support multitouch touchpads in Surface
 TypeCover
Date: Mon, 28 Nov 2016 14:41:33 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1611281440150.29400@cbobk.fhfr.pm>
References: <1480080443-7636-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39078 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932266AbcK1Nl6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 28 Nov 2016 08:41:58 -0500
In-Reply-To: <1480080443-7636-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dennis Chen <barracks510@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 25 Nov 2016, Benjamin Tissoires wrote:

> this is mostly a resubmission of v1, with one patch exchanged.

Alright, I'd be much happier when a chage such as the one done in 1st 
patch to hid-input would be done much earlier in the development process 
so that we'd have much more time for catching potential regressions.

But I've reviewed it really thoroughly and it really seems to be fine(TM) 
:) so I've now put all three patches into for-4.10/microsoft-surface-3.

Thanks,

-- 
Jiri Kosina
SUSE Labs

