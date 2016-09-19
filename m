From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] hid: Misc tablet fixes and improvements
Date: Mon, 19 Sep 2016 14:32:49 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1609191432260.22028@cbobk.fhfr.pm>
References: <20160914101531.GJ25951@mail.corp.redhat.com> <20160914183820.20737-1-spbnick@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40418 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759473AbcISMcv (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 19 Sep 2016 08:32:51 -0400
In-Reply-To: <20160914183820.20737-1-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

On Wed, 14 Sep 2016, Nikolai Kondrashov wrote:

> > For this one and 7/9, I think you forgot the hid-core.c changes to not
> > bind hid-generic on those.
> 
> Thanks, Benjamin! Yes, I forgot those. Perhaps I could have just sent the two
> patches fixed, but I respun the whole set with the hid-core changes added,
> just in case. Hope that's not bothersome.

Thanks, applied the whole lot to hid.git#for-4.9/kye-uclogic-waltop-fixes

-- 
Jiri Kosina
SUSE Labs

