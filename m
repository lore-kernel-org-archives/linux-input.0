From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: mcs5000 - Add MCS5000 touchkey support
Date: Thu, 20 May 2010 01:15:57 -0700
Message-ID: <20100520081556.GA18414@core.coreip.homeip.net>
References: <4BF4DA4D.1090407@samsung.com>
 <20100520070655.GA8080@core.coreip.homeip.net>
 <4BF4E7E5.5000006@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:54824 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753426Ab0ETIQD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 May 2010 04:16:03 -0400
Received: by pwi5 with SMTP id 5so1971787pwi.19
        for <linux-input@vger.kernel.org>; Thu, 20 May 2010 01:16:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4BF4E7E5.5000006@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: riverful.kim@samsung.com, kyungmin.park@samsung.com, linux-input@vger.kernel.org

On Thu, May 20, 2010 at 04:42:29PM +0900, Joonyoung Shim wrote:
> On 5/20/2010 4:06 PM, Dmitry Torokhov wrote:
> > Hi Joonyoung,
> > 
> > On Thu, May 20, 2010 at 03:44:29PM +0900, Joonyoung Shim wrote:
> >> The MELPAS MCS5000 can use to touchkey controller. This is patch to
> >> support touchkey at original MCS5000 touchscreen driver.
> >>
> > 
> > Not much of the touchscreen code ends up being reused it seems. Would
> > not creating a separate keypad driver make more sense?
> > 
> 
> OK, i will make a separate keypad driver and it will support MCS5080
> keypad together.
> 
> > Also, please amke sure that driver allows remapping the keymap (by
> > setting keycode, kmeycodemax, keycodesize in input device).
> > 
> 
> Do you mean a implementation of setkeycode and getkeycode functions?
> 

That is another possibility, it all depends on how you organize the
keymap.

-- 
Dmitry
