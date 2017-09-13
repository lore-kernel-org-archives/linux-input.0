From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] HID: i2c-hid: allocate hid buffers for real worst case
Date: Wed, 13 Sep 2017 07:49:50 -0700
Message-ID: <20170913144950.GA1122@dtor-ws>
References: <20170908175527.GA19720@dtor-ws>
 <nycvar.YFH.7.76.1709130701170.4703@jbgna.fhfr.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36217 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751581AbdIMOty (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 13 Sep 2017 10:49:54 -0400
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1709130701170.4703@jbgna.fhfr.qr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Guenter Roeck <groeck@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Sep 13, 2017 at 07:02:05AM -0700, Jiri Kosina wrote:
> On Fri, 8 Sep 2017, Dmitry Torokhov wrote:
> 
> > From: Adrian Salido <salidoa@google.com>
> > 
> > The buffer allocation is not currently accounting for an extra byte for
> > the report id. This can cause an out of bounds access in function
> > i2c_hid_set_or_send_report() with reportID > 15.
> > 
> > Signed-off-by: Guenter Roeck <groeck@chromium.org>
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Missing signoff from the patch author?

Oops, I must have cut it off on accident while removing ChromeOS
specific tags, the original commit is here:

https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/475212

> 
> Also, I think this should have Cc: stable, right?

I usually let maintainers decide, but yes.

Thanks.

-- 
Dmitry
