From: Tai-hwa Liang <avatar@sentelic.com>
Subject: Re: [PATCH] Fix sentelic multi-touch driver
Date: Thu, 28 Jun 2012 16:02:15 +0800 (CST)
Message-ID: <1206281559091.19930@cnaqrzbavhz.fragryvp.pbz>
References: <1340829375-4995-1-git-send-email-ogoffart@woboq.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hermod.sentelic.com ([203.69.18.19]:15997 "EHLO
	hermod.sentelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752048Ab2F1ICT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jun 2012 04:02:19 -0400
In-Reply-To: <1340829375-4995-1-git-send-email-ogoffart@woboq.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Olivier Goffart <ogoffart@woboq.com>
Cc: linux-input@vger.kernel.org

On Wed, 27 Jun 2012, Olivier Goffart wrote:
> Always report both finger between the sync.  Even if the documentation
> of input-mt says one can only report one at the time, it does not
> work otherwise. This fix scrolling in X11 which flickers a lot.

   I have a similar patch to address this issue. Would you please try to
see if https://bugzilla.kernel.org/attachment.cgi?id=73991 works for you?

> Ignore the duplicate or release events. They keep some gestures from
> working (such as the two-finger tap)
>
> This seems to fix the problems reported here:
> https://bugzilla.kernel.org/show_bug.cgi?id=43591

   FWIW, https://bugzilla.kernel.org/show_bug.cgi?id=43197 is the original
thread of the aforementioned patch.

Thanks,

Tai-hwa Liang
