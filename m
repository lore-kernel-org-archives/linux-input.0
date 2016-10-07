From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] hidraw: fix list->buffer race condition
Date: Fri, 7 Oct 2016 10:43:55 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1610071043080.31629@cbobk.fhfr.pm>
References: <1475628266-4767-1-git-send-email-gary.king@oculus.com> <20161005075329.GZ19261@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58346 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750976AbcJGIoM (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 7 Oct 2016 04:44:12 -0400
In-Reply-To: <20161005075329.GZ19261@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Gary King <gary.king@oculus.com>, linux-input@vger.kernel.org

On Wed, 5 Oct 2016, Benjamin Tissoires wrote:

> > @@ -98,7 +99,9 @@ static ssize_t hidraw_read(struct file *file, char __user *buffer, size_t count,
> >  
> >  		kfree(list->buffer[list->tail].value);
> >  		list->buffer[list->tail].value = NULL;
> > +		smp_wmb();
> >  		list->tail = (list->tail + 1) & (HIDRAW_BUFFER_SIZE - 1);
> > +		smp_wmb();
> 
> How does these barriers be needed? To me, list->tail gets accessed just
> before, so I doubt the compiler would decide to reorder the code without
> changing the semantic.

These are CPU barriers, not compiler barriers.

(that's just a clarification, it doesn't imply in any way that I'd think 
the barriers are correct :) ).

Thanks,

-- 
Jiri Kosina
SUSE Labs

