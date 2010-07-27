From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/15] STAGING: add lirc device drivers
Date: Tue, 27 Jul 2010 09:09:56 -0700
Message-ID: <20100727160955.GA7528@kroah.com>
References: <20100726232546.GA21225@redhat.com>
 <4C4F0244.2070803@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4C4F0244.2070803@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: Jarod Wilson <jarod@redhat.com>, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Jul 27, 2010 at 12:59:00PM -0300, Mauro Carvalho Chehab wrote:
> Em 26-07-2010 20:25, Jarod Wilson escreveu:

Hm, Jarod, you forgot to cc: the staging maintainer, so I missed these
:)

> Please add a TODO file at staging/lirc, describing what's needed for
> the drivers to move to the IR branch.
> 
> Greg,
> 
> It is probably simpler to merge those files via my tree, as they depend
> on some changes scheduled for 2.6.36.
> 
> Would it be ok for you if I merge them from my tree?

No objection from me for them to go through your tree.

Do you want me to handle the cleanup and other fixes after they go into
the tree, or do you want to also handle them as well (either is fine
with me.)

thanks,

greg k-h
