From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: i2c-hid: allocate hid buffers for real worst case
Date: Wed, 13 Sep 2017 07:52:20 -0700 (PDT)
Message-ID: <nycvar.YFH.7.76.1709130751380.4703@jbgna.fhfr.qr>
References: <20170908175527.GA19720@dtor-ws> <nycvar.YFH.7.76.1709130701170.4703@jbgna.fhfr.qr> <20170913144950.GA1122@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49911 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751686AbdIMOwW (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 13 Sep 2017 10:52:22 -0400
In-Reply-To: <20170913144950.GA1122@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Guenter Roeck <groeck@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 13 Sep 2017, Dmitry Torokhov wrote:

> > > From: Adrian Salido <salidoa@google.com>
> > > 
> > > The buffer allocation is not currently accounting for an extra byte for
> > > the report id. This can cause an out of bounds access in function
> > > i2c_hid_set_or_send_report() with reportID > 15.
> > > 
> > > Signed-off-by: Guenter Roeck <groeck@chromium.org>
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > 
> > Missing signoff from the patch author?
> 
> Oops, I must have cut it off on accident while removing ChromeOS
> specific tags, the original commit is here:
> 
> https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/475212

Ok, thanks, will use that one. How about 

	Reviewed-by: Benson Leung <bleung@chromium.org>

which is missing in the mail you've sent, but is there in the above 
reference commit?

> > Also, I think this should have Cc: stable, right?
> 
> I usually let maintainers decide, but yes.

I'll be adding it. Thanks,

-- 
Jiri Kosina
SUSE Labs

