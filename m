From: Jason Wessel <jason.wessel@windriver.com>
Subject: Re: [PATCH 3/3] USB: drop tty argument from usb_serial_handle_sysrq_char()
Date: Wed, 04 Aug 2010 06:25:13 -0500
Message-ID: <4C594E19.3040806@windriver.com>
References: <20100804075602.30647.91462.stgit@localhost.localdomain> <20100804075911.30647.64907.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100804075911.30647.64907.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Airlie <airlied@linux.ie>, David Miller <davem@davemloft.net>, Fenghua Yu <fenghua.yu@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Russell King <linux@arm.linux.org.uk>, Tony Luck <tony.luck@intel.com>
List-Id: linux-input@vger.kernel.org

On 08/04/2010 02:59 AM, Dmitry Torokhov wrote:
> Since handle_sysrq() does not take tty as argument anymore we can
> drop it from usb_serial_handle_sysrq_char() as well.
>
>   

Acked-by: Jason Wessel <jason.wessel@windriver.com>
