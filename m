From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: Add quirk driver for NTI USB-SUN adapter
Date: Mon, 6 Mar 2017 13:50:57 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1703061350330.31814@cbobk.fhfr.pm>
References: <20170201195457.31060-1-jktomer@google.com> <alpine.LSU.2.20.1703061317150.31814@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55678 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753021AbdCFMvA (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 6 Mar 2017 07:51:00 -0500
In-Reply-To: <alpine.LSU.2.20.1703061317150.31814@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Tomer <jktomer@google.com>
Cc: benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Mon, 6 Mar 2017, Jiri Kosina wrote:

> > These adapters allow pre-USB Sun keyboards to be connected to USB-only
> > machines, but include the wrong maximum keycode in their report
> > descriptor, making most of the keys present on Sun keyboards but not
> > 101-key PC keyboards nonfunctional.
> > 
> > This patch implements a quirk that overrides the maximum keycode in the
> > report descriptor.
> > 
> > Signed-off-by: Jonathan Tomer <jktomer@google.com>
> > ---
> > Changes in v2:
> >   - Remove unneeded guard in Kconfig
> >   - Simplify registration code by using module_hid_driver() instead of
> >     module_{init,exit}
> >   - add MODULE_{AUTHOR,DESCRIPTION}
> 
> Applied to for-4.11/nti. Thanks,

This should've read for-4.12, sorry for the noise.

-- 
Jiri Kosina
SUSE Labs

