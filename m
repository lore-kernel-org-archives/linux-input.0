From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 0/3] input: evdev: Dynamic buffers (rev4)
Date: Wed, 16 Jun 2010 16:46:12 +0200 (CEST)
Message-ID: <alpine.LRH.2.00.1006161645380.2497@twin.jikos.cz>
References: <1275735869-2185-1-git-send-email-rydberg@euromail.se> <201006101211.51395.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201006101211.51395.dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Mika Kuoppala <mika.kuoppala@nokia.com>, Benjamin Tissoires <tissoire@cena.fr>, Rafi Rubin <rafi@seas.upenn.edu>
List-Id: linux-input@vger.kernel.org

On Thu, 10 Jun 2010, Dmitry Torokhov wrote:

> > This version implements buffer locking using event_lock as you
> > suggested, such that we can proceed with fixing the evdev buffer
> > problem independently from providing a suitable one-to-many buffer.
> > 
> > The first patch converts the per-client buffers to a common buffer,
> > and adds a fixme since the code is expected to be further
> > improved. The second and third patch includes your review comments.
> 
> Henrik,
> 
> Applied to .36 queue with minor adjustments, please take a peek in my
> 'for-linus' branch and see if you spot anything wrong. 

Hi Dmitry,

I guess you forgot to push it to kernel.org? Last change I see in your 
tree is 6 days old.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
