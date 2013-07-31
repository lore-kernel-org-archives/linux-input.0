From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [RFC 3/8] HID: input: generic hidinput_input_event handler
Date: Wed, 31 Jul 2013 10:30:17 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1307311029270.18809@pobox.suse.cz>
References: <1373908217-16748-1-git-send-email-dh.herrmann@gmail.com> <1373908217-16748-4-git-send-email-dh.herrmann@gmail.com> <CAN+gG=Hty+R0D38-pJV-3J4oVEGfezh14A2XB0ppkbbXOx5Nuw@mail.gmail.com>
 <CANq1E4QqBrM7AwO5b_T9eQRURTtNeq5b0DafXcbAVOucqdkD1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45860 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752794Ab3GaIaU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 31 Jul 2013 04:30:20 -0400
In-Reply-To: <CANq1E4QqBrM7AwO5b_T9eQRURTtNeq5b0DafXcbAVOucqdkD1g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@euromail.se>, Oliver Neukum <oliver@neukum.org>

On Wed, 17 Jul 2013, David Herrmann wrote:

> >> +
> >> +       /* led_work is spawned by input_dev callbacks, but doesn't access the
> >> +        * parent input_dev at all. Once all input devices are removed, we
> >> +        * know that led_work will never get restarted, so we can cancel it
> >> +        * synchronously and are safe. */
> >> +       cancel_work_sync(&hid->led_work);
> >
> > You missed the multi-lines comment formatting style on this one :)
> 
> The ./net/ subsystem uses these comments quite a lot and there was a
> discussion between davem and linus with the conclusion that these
> comments are ok. But I actually don't care, so I can change to normal
> CodingStyle.

I once got grilled by Dave for submitting patch to netdev with such 
comment, but that didn't change my opinion, and I don't care for my 
subsystem :)

-- 
Jiri Kosina
SUSE Labs
