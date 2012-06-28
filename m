From: Olivier Goffart <olivier@woboq.com>
Subject: Re: [PATCH] Fix sentelic multi-touch driver
Date: Thu, 28 Jun 2012 11:44:21 +0200
Message-ID: <1523768.XhBRLqFZzh@gargamel>
References: <1340829375-4995-1-git-send-email-ogoffart@woboq.com> <1624632.HRAD290WOc@gargamel> <12062817144218.19930@cnaqrzbavhz.fragryvp.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail01.worldserver.net ([217.13.200.41]:52640 "EHLO
	mail01.worldserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755483Ab2F1Joq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jun 2012 05:44:46 -0400
In-Reply-To: <12062817144218.19930@cnaqrzbavhz.fragryvp.pbz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tai-hwa Liang <avatar@sentelic.com>
Cc: linux-input@vger.kernel.org

On Thursday 28 June 2012 17:17:50 Tai-hwa Liang wrote:
> On Thu, 28 Jun 2012, Olivier Goffart wrote:
> > On Thursday 28 June 2012 16:02:15 Tai-hwa Liang wrote:
> [...]
> 
> >>    I have a similar patch to address this issue. Would you please try to
> >> 
> >> see if https://bugzilla.kernel.org/attachment.cgi?id=73991 works for you?
> > 
> > Hi,
> > 
> > That patch also fixes the issue here.  (It fixes scrolling and two finger
> > tap) But the case in which you put two finger into the touchpad then
> > release one finger is not handled properly. (I took care of that issue)
> 
>    Would you please be more specific about the steps to reproduce this?
> I've tested both of these two patches but failed to see the difference in
> this case.


 - Touch the touchpad with one finger and move it: this moves the cursor
 - Place a second finger: this allows you to scoll
 - Release a finger: you should now be able to move the cursor again.  This is 
the part that does not work in one of the patch

