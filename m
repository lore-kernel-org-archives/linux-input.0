From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [RFC 05/12] HID: wiimote: Synchronize wiimote input and hid event handling
Date: Thu, 16 Jun 2011 12:42:31 +0200
Message-ID: <201106161242.31354.oneukum@suse.de>
References: <1308095157-4699-1-git-send-email-dh.herrmann@googlemail.com> <201106161218.55279.oneukum@suse.de> <BANLkTinwT3CSwkiytCoVbb4Q6UMzDx8tag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:44522 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753777Ab1FPKkf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Jun 2011 06:40:35 -0400
In-Reply-To: <BANLkTinwT3CSwkiytCoVbb4Q6UMzDx8tag@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, padovan@profusion.mobi

Am Donnerstag, 16. Juni 2011, 12:29:40 schrieb David Herrmann:
> On Thu, Jun 16, 2011 at 12:18 PM, Oliver Neukum <oneukum@suse.de> wrote:
> > Am Donnerstag, 16. Juni 2011, 11:20:18 schrieb Jiri Kosina:
> >> > Here an smp_wmb()
> >> > It is redundant because input_register_device takes a spinlock which
> >> > implies a barrier, but you'll make the automated checking tools happier.
> >>
> >> Yeah, spinlock implies SMP barrier implicitly.
> >>
> >> I don't think adding barriers just to make some buggy automatic checker
> >> happy is worth it.
> >
> > Fine by me as long as the problem is understood.
> 
> Does that mean that I can omit the smp_rmb(), too? I do not like
> relying on input_register_device to use a spinlock. It makes reading
> the code hard, so I added both barriers. Should I remove them again or
> keep them?

The full explanation is in Documentation/atomic-ops.txt
Basically, whenever you do

if (!descriptor->flag)
	return -ERR;

descriptor->pointer->member = expression; //or anything else with the pointer

you need smp_rmb() in between

If you do

if (!descriptor->flag)
	return -ERR;

// no use of pointer here

spin_lock(&lock);

descriptor->pointer->member = expression; //or anything else with the pointer

You are save and can do without the smp_rmb()

But, you still need smp_rmb() if you do:

if (!descriptor->flag)
	return -ERR;

// no use of pointer here

spin_lock(&descriptor->pointer->lock);

All clear? I must say I stopped listing and checking all the places you use
the flag, but I think some were buggy.

	Regards
		Oliver
