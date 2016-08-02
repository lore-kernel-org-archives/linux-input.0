From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] input/hid: Add a new Saitek mouse device ID (RAT 9)
Date: Tue, 2 Aug 2016 16:46:30 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1608021645320.22028@cbobk.fhfr.pm>
References: <20160730115339.16542-1-mayeul@localhost.localdomain> <20160801092149.GT19383@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59688 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965145AbcHBPXo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Aug 2016 11:23:44 -0400
In-Reply-To: <20160801092149.GT19383@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Mayeul Cantan <mayeul.cantan@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 1 Aug 2016, Benjamin Tissoires wrote:

> >  static int hid_uevent(struct device *dev, struct kobj_uevent_env *env)
> >  {
> > -	struct hid_device *hdev = to_hid_device(dev);	
> > +	struct hid_device *hdev = to_hid_device(dev);
> 
> Usually, if the change is not related to the patch, it needs to be in
> its own patch. The rational being that if we need to revert the patch,
> the cleanups won't.

Yeah, let's fix this once someone is actually touching the code in 
question.

I've removed this hunk, and applied the rest of the patch to 
for-4.8/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs

