From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: cp2112: Fix I2C_BLOCK_DATA transactions
Date: Tue, 21 Nov 2017 17:45:32 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1711211744250.11505@cbobk.fhfr.pm>
References: <20171114000358.GA14433@mail.arista.com> <nycvar.YFH.7.76.1711211742270.11505@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36683 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750794AbdKUQpe (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 21 Nov 2017 11:45:34 -0500
In-Reply-To: <nycvar.YFH.7.76.1711211742270.11505@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eudean Sun <eudean@arista.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 21 Nov 2017, Jiri Kosina wrote:

> > The existing driver erroneously treats I2C_BLOCK_DATA and BLOCK_DATA
> > commands the same. Fix the logic for I2C_BLOCK_DATA reads and writes.
> 
> Addin David, the original author of the driver (and the code in question 
> as well) to CC.

Alright, that address bounces.

In that case -- could you please be a little bit more specific in the 
changelog? Namely: what are the observable effects of this bug (did you 
find it by code inspection or have you seen it triggering) and why this is 
a proper fix for that bug.

Thanks!

-- 
Jiri Kosina
SUSE Labs

