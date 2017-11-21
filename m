From: Eudean Sun <eudean@arista.com>
Subject: Re: [PATCH] HID: cp2112: Fix I2C_BLOCK_DATA transactions
Date: Tue, 21 Nov 2017 10:40:12 -0800
Message-ID: <20171121184012.GA6776@mail.arista.com>
References: <20171114000358.GA14433@mail.arista.com>
 <nycvar.YFH.7.76.1711211742270.11505@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1711211744250.11505@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:32965 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751309AbdKUSkQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 21 Nov 2017 13:40:16 -0500
Received: by mail-it0-f45.google.com with SMTP id o130so7800550itg.0
        for <linux-input@vger.kernel.org>; Tue, 21 Nov 2017 10:40:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1711211744250.11505@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Nov 21, 2017 at 05:45:32PM +0100, Jiri Kosina wrote:
> On Tue, 21 Nov 2017, Jiri Kosina wrote:
> 
> > > The existing driver erroneously treats I2C_BLOCK_DATA and BLOCK_DATA
> > > commands the same. Fix the logic for I2C_BLOCK_DATA reads and writes.
> > 
> > Addin David, the original author of the driver (and the code in question 
> > as well) to CC.
> 
> Alright, that address bounces.
> 
> In that case -- could you please be a little bit more specific in the 
> changelog? Namely: what are the observable effects of this bug (did you 
> find it by code inspection or have you seen it triggering) and why this is 
> a proper fix for that bug.

Thanks for the feedback Jiri, I will send out a new patch shortly with more detail in the changelog.
