From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: wiimote: fix FF deadlock
Date: Mon, 7 Oct 2013 17:09:51 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1310071709400.29701@pobox.suse.cz>
References: <1380714448-878-1-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1380714448-878-1-git-send-email-dh.herrmann@gmail.com>
Sender: stable-owner@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 2 Oct 2013, David Herrmann wrote:

> The input core has an internal spinlock that is acquired during event
> injection via input_event() and friends but also held during FF callbacks.
> That means, there is no way to share a lock between event-injection and FF
> handling. Unfortunately, this is what is required for wiimote state
> tracking and what we do with state.lock and input->lock.
> 
> This deadlock can be triggered when using continuous data reporting and FF
> on a wiimote device at the same time. I takes me at least 30m of
> stress-testing to trigger it but users reported considerably shorter
> times (http://bpaste.net/show/132504/) when using some gaming-console
> emulators.
> 
> The real problem is that we have two copies of internal state, one in the
> wiimote objects and the other in the input device. As the input-lock is
> not supposed to be accessed from outside of input-core, we have no other
> chance than offloading FF handling into a worker. This actually works
> pretty nice and also allows to implictly merge fast rumble changes into a
> single request.
> 
> Due to the 3-layered workers (rumble+queue+l2cap) this might reduce FF
> responsiveness. Initial tests were fine so lets fix the race first and if
> it turns out to be too slow we can always handle FF out-of-band and skip
> the queue-worker.
> 
> Cc: <stable@vger.kernel.org> # 3.11+
> Reported-by: Thomas Schneider
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>

Applied, thanks David.

-- 
Jiri Kosina
SUSE Labs
