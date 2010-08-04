From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/3] SysRq: do not pass tty argument around
Date: Wed, 4 Aug 2010 10:11:04 +0100
Message-ID: <20100804101104.7f6e7b08@lxorguk.ukuu.org.uk>
References: <20100804075602.30647.91462.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:42372 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756929Ab0HDI5u (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Aug 2010 04:57:50 -0400
In-Reply-To: <20100804075602.30647.91462.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Airlie <airlied@linux.ie>, David Miller <davem@davemloft.net>, Fenghua Yu <fenghua.yu@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, Jason Wessel <jason.wessel@windriver.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Russell King <linux@arm.linux.org.uk>, Tony Luck <tony.luck@intel.com>

On Wed, 04 Aug 2010 00:58:55 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> Hi,
> 
> The following 3 patches get rid of 'tty' argument in SysRq handlers as
> nobody is using it. If noone objects I'd like to get it merged through
> my tree.

Looks good to me.
