From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] Input: wacom - Add POINTER and DIRECT device properties
Date: Wed, 14 Sep 2011 09:15:24 +0200
Message-ID: <20110914071524.GA3422@polaris.bitmath.org>
References: <1314892843-1475-1-git-send-email-killertofu@gmail.com>
 <20110913080911.GA4986@polaris.bitmath.org>
 <CAPHpN5OAPdPQ1SmwrGT6pMvgWESBOSnRvb0jKUszkU_31MFXWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:40938 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755774Ab1INHLv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Sep 2011 03:11:51 -0400
Received: from ipb1.telenor.se (ipb1.telenor.se [195.54.127.164])
	by smtprelay-b12.telenor.se (Postfix) with ESMTP id 5D570EA4EA
	for <linux-input@vger.kernel.org>; Wed, 14 Sep 2011 09:11:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAPHpN5OAPdPQ1SmwrGT6pMvgWESBOSnRvb0jKUszkU_31MFXWg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mohamed Ikbel Boulabiar <boulabiar@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>

On Tue, Sep 13, 2011 at 10:18:28AM +0200, Mohamed Ikbel Boulabiar wrote:
> Hi,
> 
> On Tue, Sep 13, 2011 at 10:09 AM, Henrik Rydberg <rydberg@euromail.se> wrote:
> >
> > . The question is then what behavior should be assigned to
> > a large tablet without an embedded screen. It should have POINTER set
> > for sure, but should it also have DIRECT set?
> 
> Any large tablet without an embedded screen can be used in the 2 different ways:
> 1. The projection on top of it so it becomes a direct device.
> (this case is also used when you project 3d 120hz on top of multitouch
> devices: iMuts)
> 
> 2. Simple indirect device, even if it's large:
> http://10gui.com/video/

Two-finger scroll is actually used in a direct manner in that
video. (Which, btw, does display some fresh concepts. :-))

I think the bottom line is that even if the "directness" of a device
is configurable, it still needs to have a default. Moreover, the
notion of kernel mode settings could be applicable here too.

Henrik
