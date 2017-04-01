From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/8] i2c: export i2c_client_type structure
Date: Sat, 1 Apr 2017 09:43:10 -0700
Message-ID: <20170401164310.GC17130@dtor-ws>
References: <20170309221644.17035-1-dmitry.torokhov@gmail.com>
 <20170309221644.17035-2-dmitry.torokhov@gmail.com>
 <20170401160645.aunntbwuuvowsga4@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33580 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751717AbdDAQnN (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 1 Apr 2017 12:43:13 -0400
Content-Disposition: inline
In-Reply-To: <20170401160645.aunntbwuuvowsga4@ninjato>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Sat, Apr 01, 2017 at 06:06:46PM +0200, Wolfram Sang wrote:
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
> Reviewed-by: Wolfram Sang <wsa@the-dreams.de>
> 
> You can add the above tag to all patches in your branch
> '4.11-rc3-i2c-irq-resources' and after that we declare it immutable and
> I'll pull it into my for-next. Sorry for the delay. I got side-tracked
> and ill. But I am better now.

No worries about the delay - we still have plenty of time till merge
window, and I am glad to hear that you are better now.

I published the branch with your reviewed-bys:

git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git ib/4.11-rc3-i2c-irq-resources

Note the 'ib' prefix - I am tagging immutable branches with it. I also
dropped the old branch to avoid confusion.

> 
> And to keep your heads up: We agreed yesterday that i2c_drivers will get
> a flag to signal I2C core to skip all the irq assignment stuff and let
> the driver do it itself [1]. Maybe this will become useful for you, too.
> 
> [1] http://www.spinics.net/lists/linux-acpi/msg73197.html
> 

Thanks for heads up. I actually do not think it will be useful for me,
as I am trying to make drivers generic and do not care about platform
quirks, and instead enhance board/platform code to give sane data to the
drivers.

I replied in thread.

Thanks.

-- 
Dmitry
