From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 0/3] SysRq: do not pass tty argument around
Date: Wed, 4 Aug 2010 12:44:41 -0700
Message-ID: <20100804194441.GB30722@suse.de>
References: <20100804075602.30647.91462.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100804075602.30647.91462.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Airlie <airlied@linux.ie>, David Miller <davem@davemloft.net>, Fenghua Yu <fenghua.yu@intel.com>, Jason Wessel <jason.wessel@windriver.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Russell King <linux@arm.linux.org.uk>, Tony Luck <tony.luck@intel.com>
List-Id: linux-input@vger.kernel.org

On Wed, Aug 04, 2010 at 12:58:55AM -0700, Dmitry Torokhov wrote:
> Hi,
> 
> The following 3 patches get rid of 'tty' argument in SysRq handlers as
> nobody is using it. If noone objects I'd like to get it merged through
> my tree.

Nice job.

No objection from me for you to take this through your tree:
	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>

thanks,

greg k-h
