From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 01/10] Input: eeti_ts - rename eeti_ts_priv to eeti_ts
Date: Wed, 1 Mar 2017 09:34:53 -0800
Message-ID: <20170301173453.GB30349@dtor-ws>
References: <20170228224632.3401-1-dmitry.torokhov@gmail.com>
 <38cb7df6-9b3c-4e61-c680-4a404f04f474@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36758 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750813AbdCARfC (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 1 Mar 2017 12:35:02 -0500
Content-Disposition: inline
In-Reply-To: <38cb7df6-9b3c-4e61-c680-4a404f04f474@zonque.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Wed, Mar 01, 2017 at 10:28:14AM +0100, Daniel Mack wrote:
> Hi Dmitry,
> 
> On 02/28/2017 11:46 PM, Dmitry Torokhov wrote:
> > Also rename 'priv' variables to eeti.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> > 
> > Hi,
> > 
> > This is all is not tested as I do not have the hardware, so if anyone
> > has raumfeld device that would be awesome.
> 
> I have no access to such hardware for the time being, and the platform
> does not currently boot a mainline kernel either.
> 
> So I think we should just merge this set, the changes to the driver look
> all good to me. If, at some point, I manage to revive that hardware, I
> can give platform bits a try.

OK, I'll be putting you as reviewed-by then.

Thank you for taking a look.

-- 
Dmitry
