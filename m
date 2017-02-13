From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: synaptics-rmi4 - create firmware update sysfs
 attribute in F34
Date: Sun, 12 Feb 2017 16:02:51 -0800
Message-ID: <20170213000251.GA528@dtor-ws>
References: <20170209212508.GA24684@dtor-ws>
 <20170212225056.GB17938@lava.h.shmanahar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33565 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbdBMACz (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 12 Feb 2017 19:02:55 -0500
Content-Disposition: inline
In-Reply-To: <20170212225056.GB17938@lava.h.shmanahar.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick@shmanahar.org>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, linux-kernel@vger.kernel.org, Chris Healy <cphealy@gmail.com>

Hi Nick,

On Sun, Feb 12, 2017 at 10:50:56PM +0000, Nick Dyer wrote:
> On Thu, Feb 09, 2017 at 01:25:08PM -0800, Dmitry Torokhov wrote:
> > There is no need to create sysfs attributes in the main driver core,
> > let F34 implementation do that.
> 
> Hi Dmitry-
> 
> I haven't tested this yet, but I did try creating/removing the sysfs
> entries in the f34 function probe/remove as you're suggesting when I
> wrote the F34 support.
> 
> The problem is that when we do a firmware update, we have to tear down
> the function list (because most of the functions are not there during
> firmware update and they may in fact come back different). Which removes
> the sysfs entries, meaning it's rather like sawing off the branch you're
> sitting on, and it crashes almost immediately. I couldn't think of a
> cleaner way to solve it that the current implementation.

Oh, I see. Well, that means that the current implementation is quite
broken, as you'll end up referencing freed and potentially reused memory
after firmware update. It looks like we'll need to make sure we do not
reference F34 memory unless we know it is there. That means we'll have
to pull update status and FW update mutex into the RMI device itself as
it is something that stays around even if we destroy and rebuild
function list.

Thanks.

-- 
Dmitry
