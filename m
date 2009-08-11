From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Restoring joydev BTNMAP ioctl compatibility
Date: Tue, 11 Aug 2009 00:26:53 -0700
Message-ID: <20090811075734.A12DE526EC9@mailhub.coreip.homeip.net>
References: <20090810085242.3676ebc6@sk2.org> <20090810084436.98FFA526EC9@mailhub.coreip.homeip.net> <20090810132905.546a95ba@sk2.org> <20090810211245.73a3b4e5@sk2.org> <20090810205758.C7D3B526EC9@mailhub.coreip.homeip.net> <20090811082032.2aa364eb@sk2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.234]:17318 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864AbZHKLvZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Aug 2009 07:51:25 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1291291rvb.1
        for <linux-input@vger.kernel.org>; Tue, 11 Aug 2009 04:51:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090811082032.2aa364eb@sk2.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Kitt <steve@sk2.org>
Cc: linux-input@vger.kernel.org

On Tue, Aug 11, 2009 at 08:20:32AM +0200, Stephen Kitt wrote:
> Hi Dmitry,
> 
> On Mon, 10 Aug 2009 13:27:26 -0700, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > Actually I think we need to return "len" here to let userspace know how
> > much data we produced. Also, could you please give the same treatment to
> > JSIOCGAXMAP and JSIOCSAXMAP and I will apply it.
> 
> Here goes! I'm not too familiar with kernel memory handling, I'll send the
> fixes for the FIXMEs later on as a separate patch once I've figured things
> out; I'm thinking along these lines:
> * vmalloc() a buffer
> * return -ENOMEM if no memory is available
> * copy_from_user the data into the temporary buffer
> * validate the data
> * on error vfree() the buffer and return -EINVAL
> * copy the data from the temporary buffer to the destination array
> * vfree() the buffer
> 

Yep, exactly, except that don't bother with vmalloc, kmalloc will do
nicely since the amout of memory needed is relatively small.

-- 
Dmitry
