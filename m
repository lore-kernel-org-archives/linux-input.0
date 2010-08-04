From: Jason Wessel <jason.wessel@windriver.com>
Subject: Re: [PATCH 2/3] Input: sysrq - drop tty argument form handle_sysrq()
Date: Wed, 04 Aug 2010 06:25:07 -0500
Message-ID: <4C594E13.3000204@windriver.com>
References: <20100804075602.30647.91462.stgit@localhost.localdomain> <20100804075906.30647.97136.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100804075906.30647.97136.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Airlie <airlied@linux.ie>, David Miller <davem@davemloft.net>, Fenghua Yu <fenghua.yu@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Russell King <linux@arm.linux.org.uk>, Tony Luck <tony.luck@intel.com>
List-Id: linux-input@vger.kernel.org

On 08/04/2010 02:59 AM, Dmitry Torokhov wrote:
> Sysrq operations do not accept tty argument anymore so no need to pass
> it to us.
>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
>   

Looks fine to me.  The kernel debugger was passing NULL anyway because
A) it was not going to be easy to figure out the tty at the time, and B)
the sysrq was not using the tty at the lowest level.

Acked-by: Jason Wessel <jason.wessel@windriver.com>
