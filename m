From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/8] i2c: export i2c_client_type structure
Date: Thu, 9 Mar 2017 15:46:24 -0800
Message-ID: <20170309234624.GG20077@dtor-ws>
References: <20170309221644.17035-1-dmitry.torokhov@gmail.com>
 <20170309221644.17035-2-dmitry.torokhov@gmail.com>
 <20170309231246.GA4300@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36584 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751366AbdCIXq3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 9 Mar 2017 18:46:29 -0500
Content-Disposition: inline
In-Reply-To: <20170309231246.GA4300@tetsubishi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jean Delvare <jdelvare@suse.de>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Fri, Mar 10, 2017 at 12:12:46AM +0100, Wolfram Sang wrote:
> Dmitry,
> 
> On Thu, Mar 09, 2017 at 02:16:37PM -0800, Dmitry Torokhov wrote:
> > i2c bus has 2 different types of device belonging to the same bus and
> > bus notifiers use device type to distinguish between adapters and clients.
> > Previously we only had i2c_adapter_type exported, which made code wanting
> > to work with i2c_client devices test for type not equal to adapter type.
> > This unfortunately is not safe if we ever add another type to the bus,
> > so let's export i2c_client_type as well.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> > 
> > Wolfram, this is the patch I was talking about in the other mail.
> 
> I see. From a glimpse, I am fine with the patch. I'll add Jean Delvare
> to CC, though, in case I missed some detail he still knows. Furthermore,
> while I agree that testing for "not adapter" when one means "is client"
> is not nice, is there a bigger benefit than being correct in your queue?

No, just my dislike of testing for "dev->type != &i2c_adapter_type" in
the new i2c bus notifier when we want to work with i2c clients.

Thanks.

-- 
Dmitry
