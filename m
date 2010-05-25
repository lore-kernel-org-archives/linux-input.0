From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/2] input: mt: Add EVIOC mechanism for MT slots
Date: Tue, 25 May 2010 10:34:46 -0700
Message-ID: <20100525173446.GA4634@core.coreip.homeip.net>
References: <1274788379-11026-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1274788379-11026-1-git-send-email-rydberg@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Kuoppala <mika.kuoppala@nokia.com>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <tissoire@cena.fr>, Stephane Chatty <chatty@enac.fr>, Rafi Rubin <rafi@seas.upenn.edu>, Michael Poole <mdpoole@troilus.org>
List-Id: linux-input@vger.kernel.org

Hi Henrik,

On Tue, May 25, 2010 at 01:52:57PM +0200, Henrik Rydberg wrote:
> These patches are in response to the discussion about input state
> retrieval.
> 
> The current EVIOCGABS method does not work with MT slots.  These
> patches provides a mechanism where a slot is first selected via a call
> to EVIOCSABS, after which the corresponding MT events can be extracted
> with calls to EVIOCGABS.
> 
> The symmetric operation, to set the MT state via EVIOCSABS, seems to
> violate input data integrity, and is therefore not implemented.
> 

This looks sane, however the question remains - is there any users for
this data? Like I mentioned, I can see the need to fetch state of
switches and ranges of absolute axis, and even non-multitouch ABS values
(due to the fact that some input devices, like sliders, may stay in a
certain position for long periods of time), but I expect multitouch data
to be "refreshed" very quickly.

Thanks.

-- 
Dmitry
