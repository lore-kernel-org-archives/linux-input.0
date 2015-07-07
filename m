From: Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH] HID: i2c-hid: Call device suspend callback before
 disabling irq
Date: Tue, 7 Jul 2015 22:49:30 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1507072248020.10183@pobox.suse.cz>
References: <1436299082-3526-1-git-send-email-gabriele.mzt@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:43409 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932630AbbGGUtq (ORCPT
	<rfc822;groupwise-linux-input@vger.kernel.org:0:0>);
	Tue, 7 Jul 2015 16:49:46 -0400
In-Reply-To: <1436299082-3526-1-git-send-email-gabriele.mzt@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: benjamin.tissoires@redhat.com, aduggan@synaptics.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 7 Jul 2015, Gabriele Mazzotta wrote:

> The irq is most likely required by the suspend callback, so disable it
> only after the callback had been executed.

It would be nice to have a more verbose changelog here -- i.e. why we want 
to do such change and what could go wrong if IRQ is disabled too early 
(i.e. what bug is this exactly fixing).

> 
> Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>

I'd see this as a 4.2 material still. Please let me know if you'd rather 
want to wait for 4.3.

Thanks,

-- 
Jiri Kosina
SUSE Labs
