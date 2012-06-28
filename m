From: Olivier Goffart <olivier@woboq.com>
Subject: Re: [PATCH] Fix sentelic multi-touch driver
Date: Thu, 28 Jun 2012 10:25:19 +0200
Message-ID: <1624632.HRAD290WOc@gargamel>
References: <1340829375-4995-1-git-send-email-ogoffart@woboq.com> <1206281559091.19930@cnaqrzbavhz.fragryvp.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail01.worldserver.net ([217.13.200.41]:33820 "EHLO
	mail01.worldserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119Ab2F1IcI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jun 2012 04:32:08 -0400
In-Reply-To: <1206281559091.19930@cnaqrzbavhz.fragryvp.pbz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tai-hwa Liang <avatar@sentelic.com>, linux-input@vger.kernel.org

On Thursday 28 June 2012 16:02:15 Tai-hwa Liang wrote:
> On Wed, 27 Jun 2012, Olivier Goffart wrote:
> > Always report both finger between the sync.  Even if the documentation
> > of input-mt says one can only report one at the time, it does not
> > work otherwise. This fix scrolling in X11 which flickers a lot.
> 
>    I have a similar patch to address this issue. Would you please try to
> see if https://bugzilla.kernel.org/attachment.cgi?id=73991 works for you?


Hi,

That patch also fixes the issue here.  (It fixes scrolling and two finger tap)
But the case in which you put two finger into the touchpad then release one 
finger is not handled properly. (I took care of that issue)

(I have a Asus Zenbook UX31)

 
> > Ignore the duplicate or release events. They keep some gestures from
> > working (such as the two-finger tap)
> > 
> > This seems to fix the problems reported here:
> > https://bugzilla.kernel.org/show_bug.cgi?id=43591
> 
>    FWIW, https://bugzilla.kernel.org/show_bug.cgi?id=43197 is the original
> thread of the aforementioned patch.


