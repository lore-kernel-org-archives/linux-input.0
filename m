From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: hiddev: fix returned errno code in
 hiddev_connect()
Date: Mon, 5 Oct 2015 16:24:08 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1510051616280.2758@pobox.suse.cz>
References: <1443606749-6028-1-git-send-email-luisbg@osg.samsung.com> <alpine.LNX.2.00.1509302138380.30132@pobox.suse.cz> <561049F1.5040507@osg.samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <561049F1.5040507@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis de Bethencourt <luisbg@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, 3 Oct 2015, Luis de Bethencourt wrote:

> > But I am not really sure where you are seeing the bug (mapping to 
> > -EPERM) in this case? I think the only caller of hiddev_connect() 
> > should be hid_connect(), and the only thing that guy cares about 
> > whether individual callbacks succeed or fail, so that it sets 
> > hdev->clamed flags accordingly.
> > 
> > Could you please be more specific about the -EPERM mapping you are 
> > talking about?
> > 
> I agree with you. The only caller of hiddev_connect() only checks if the
> callback succeded. It checks if the return < 0.
> What I meant is that -1 means -EPERM. [0]

I still don't understand what problem you are chasing here, sorry. EPERM 
is defined to be 1, yes. So are many other completely unrelated #defines.

> This patch is purely about the correctness of using -ENOMEM. The word 
> "propagated" was not the best way to describe this problem. I could edit 
> the commit message if you would like.

You seem to imply that someone might be interpreting that -1 as a define 
from errno.h. But that's not the case.

Are you going to look at every 'return -1' occurence in the kernel and 
convert it to something else? That can keep you busy for quite some time:

	$ git grep 'return -1' | wc -l
	9167

The only cleanup I'd imagine at least remotely possible in this case would 
be to convert the ->connect() callbacks return bool.

-- 
Jiri Kosina
SUSE Labs
