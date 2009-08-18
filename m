From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Restoring joydev BTNMAP ioctl compatibility
Date: Mon, 17 Aug 2009 22:25:20 -0700
Message-ID: <20090818055633.B9A4B526EA5@mailhub.coreip.homeip.net>
References: <20090810085242.3676ebc6@sk2.org> <20090810084436.98FFA526EC9@mailhub.coreip.homeip.net> <20090810132905.546a95ba@sk2.org> <20090810211245.73a3b4e5@sk2.org> <20090810205758.C7D3B526EC9@mailhub.coreip.homeip.net> <20090811082032.2aa364eb@sk2.org> <20090811075734.A12DE526EC9@mailhub.coreip.homeip.net> <20090817212416.5c5b0a8b@sk2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.233]:1825 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492AbZHRFZX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Aug 2009 01:25:23 -0400
Received: by rv-out-0506.google.com with SMTP id k40so625711rvb.5
        for <linux-input@vger.kernel.org>; Mon, 17 Aug 2009 22:25:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090817212416.5c5b0a8b@sk2.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Kitt <steve@sk2.org>
Cc: linux-input@vger.kernel.org

Hi Stephen,

On Mon, Aug 17, 2009 at 09:24:16PM +0200, Stephen Kitt wrote:
> Hi Dmitry,
> 
> On Tue, 11 Aug 2009 00:26:53 -0700, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > Yep, exactly, except that don't bother with vmalloc, kmalloc will do
> > nicely since the amout of memory needed is relatively small.
> 
> Did you have a chance to look at the previous patch I sent? In case it's
> easier to review in one go, here's a single patch grouping the changes to the
> ioctls themselves as well as the map validation code!
> 

Yes, the first patch will go into .31; the second one can wait till .32.

-- 
Dmitry
