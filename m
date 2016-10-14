From: Gary King <gary.king@oculus.com>
Subject: Re: [PATCH] hidraw: fix list->buffer race condition
Date: Thu, 13 Oct 2016 18:29:16 -0700
Message-ID: <alpine.OSX.1.10.1610131823240.28437@cromulentg-mba.dhcp.thefacebook.com>
References: <1475628266-4767-1-git-send-email-gary.king@oculus.com> <alpine.LNX.2.00.1610071038340.31629@cbobk.fhfr.pm> <alpine.OSX.1.10.1610071027351.23556@cromulentg-mba.local> <alpine.LNX.2.00.1610101019040.31629@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47609 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753497AbcJNDvB (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 13 Oct 2016 23:51:01 -0400
In-Reply-To: <alpine.LNX.2.00.1610101019040.31629@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Gary King <gary.king@oculus.com>, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org

> > [snip]
> > 
> > list_lock does not appear to be a good solution for this, since it is
> > currently an IRQ-safe spinlock on the device. Using it would cause 
> > _read() to have unnecessary lock contention if the device is opened 
> > and read simultaneously from multiple fds, and every loop iteration would 
> > need to acquire the spinlock / disable interrupts at least once.
> 
> We could make the spinlock per struct file *, which'd remove the 
> contention bottleneck when the same device is accessed from through 
> multiple fds, but still maintain the correctness (as the list itself is a 
> per-fd thing anyway).
> 
> Probably introducing new spinlock would make more sense, as list_lock is 
> currently being used mostly to protect accessing of the dev->list linked 
> list.

I've got a patch I'm testing that follows Dmitry's suggestion to add
a per-struct file spinlock and change dev->list to use RCU.

Thanks,

- Gary
