From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: Add a detailed multi-touch finger data report
	protocol
Date: Fri, 21 Nov 2008 11:04:36 -0500
Message-ID: <20081121110128.ZZRA012@mailhub.coreip.homeip.net>
References: <49142351.9080805@euromail.se> <20081119113508.ZZRA012@mailhub.coreip.homeip.net> <4926C95C.7000609@bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756202AbYKUQEx@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4926C95C.7000609@bitmath.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.org>
Cc: Henrik Rydberg <rydberg@euromail.se>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Henrik,

On Fri, Nov 21, 2008 at 03:44:44PM +0100, Henrik Rydberg wrote:
> Dmitry,
> 
> My patch is all wrong. It would certainly benefit from using the
> EV_SYN/SYN_MT_REPORT, but the defuzz mechanism of the EV_ABS class
> simply will not work when sending data for several different fingers
> using the same event.
> 
> I can see two clear alternatives: either add a new event class, EV_MT,
> which sends all data without trying to limit the bandwidth, or forget
> about the whole serial-finger-data idea and expand the current EV_ABS
> class with an array of MT finger data [1]. I would very much appreciate
> your input on this. Maybe there is a third option.
> 

I don't like the idea of a new class since the finger data is a part
of absolute device state (in my opinion anyway). I am not sure if we
really need to pre-allocate space for 10 fingers either. Could we just
mark certain EV_ABS events as uncacheable in the input core? It could
be implemented with one static bitmap.

-- 
Dmitry
