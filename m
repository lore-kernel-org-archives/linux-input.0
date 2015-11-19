From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] hid: usbhid: hid-core: fix recursive deadlock
Date: Thu, 19 Nov 2015 10:10:19 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1511191005240.20111@pobox.suse.cz>
References: <1447874755-8673-1-git-send-email-adi@adirat.com> <alpine.LNX.2.00.1511182137020.20111@pobox.suse.cz> <20151118230544.5c6f0c26@adipc> <20151118235856.GA30351@jcartwri.amer.corp.natinst.com> <20151119084743.08d11238@adipc>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151119084743.08d11238@adipc>
Sender: linux-kernel-owner@vger.kernel.org
To: Ioan-Adrian Ratiu <adi@adirat.com>
Cc: Josh Cartwright <joshc@ni.com>, pinglinux@gmail.com, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 19 Nov 2015, Ioan-Adrian Ratiu wrote:

> First part of lockdep report:
> http://imgur.com/clLsCWe
> 
> Second part:
> http://imgur.com/Wa2PzRl
> 
> Here are some printk's of mine while reproducing + debugging the issue:
> http://imgur.com/SETOHT7

So the real problem is that Intuos driver is calling hid_hw_request() 
(which tries to grab the lock in usbhid_submit_report()) while handling 
the CTRL IRQ (lock gets acquired there).

So the proper way to fix seems to be delaying the scheduling of the 
proximity read event in wacom_intuos_inout() to workqueue.

> I'll continue to research this more in depth, but progress is slow 
> because I don't have much time, I'm doing this in my spare time because 
> it's my girlfriend's tablet.

Oh, now I understand the level of severity of this bug! :-)

Thanks,

-- 
Jiri Kosina
SUSE Labs
