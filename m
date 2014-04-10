From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [patch]GPIO button is supposed to wake the system up if the
 wakeup attribute is set
Date: Thu, 10 Apr 2014 11:48:10 +0100
Message-ID: <20140410114810.73e1d4b6@alan.etchedpixels.co.uk>
References: <5345FDBD.9090908@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:38623 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965557AbaDJKsW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Apr 2014 06:48:22 -0400
In-Reply-To: <5345FDBD.9090908@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, linux-input@vger.kernel.org

On Thu, 10 Apr 2014 10:11:09 +0800
"Li, Aubrey" <aubrey.li@linux.intel.com> wrote:

> When the wakeup attribute is set, GPIO button is supposed to set
> irqflag - IRQF_NO_SUSPEND to request irq. So when the system enters
> the suspend sleep mode, the GPIO irq keeps enabled and is able to
> wake the system up.
> 
> The affected/tested machines include Dell Venue 11 Pro and Asus T100TA.
> 
> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>

Tested-by: Alan Cox <alan@linux.intel.com>
