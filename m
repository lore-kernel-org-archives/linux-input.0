From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 9/9] serios: async shutdown
Date: Wed, 13 May 2009 20:49:57 -0700
Message-ID: <20090513204957.39f42059.akpm@linux-foundation.org>
References: <200905122102.n4CL2RUY006919@imap1.linux-foundation.org>
	<20090514032055.GA12778@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37543 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754664AbZENDuH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 May 2009 23:50:07 -0400
In-Reply-To: <20090514032055.GA12778@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, shaohua.li@intel.com, arjan@infradead.org, Greg KH <greg@kroah.com>

On Wed, 13 May 2009 20:20:56 -0700 Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Tue, May 12, 2009 at 01:43:11PM -0700, akpm@linux-foundation.org wrote:
> > From: Shaohua Li <shaohua.li@intel.com>
> > 
> > serio shutdown is quite slow. It sometimes will take 0.2s for each port.
> > 
> 
> This depends on the other patch you sent to Greg,

synchronize-device-shutdown.patch, I assume.

> I think these should
> go together. But I am uncomfortable at the ide of blasting all ports on
> i8042 simultaneously during shutdown. I'd be more comfortable if we were
> taking serio_mutex in serio_cleanup() so only one port is being worked
> on at a time.

OK, more thought is needed.  I dropped the patches.
