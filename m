From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH 4/8] HID: input: use the Resolution Multiplier for
 high-resolution scrolling
Date: Fri, 23 Nov 2018 09:28:39 +1000
Message-ID: <20181122232839.GA10747@jelly>
References: <20181122063409.15816-1-peter.hutterer@who-t.net>
 <20181122063409.15816-5-peter.hutterer@who-t.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181122063409.15816-5-peter.hutterer@who-t.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Harry Cutts <hcutts@chromium.org>, torvalds@linux-foundation.org, Nestor Lopez Casado <nlopezcasad@logitech.com>, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

On Thu, Nov 22, 2018 at 04:34:05PM +1000, Peter Hutterer wrote:
> Windows uses a magic number of 120 for a wheel click. High-resolution
> scroll wheels are supposed to use a fraction of 120 to signal smaller
> scroll steps. This is implemented by the Resolution Multiplier in the
> device itself.

I scooped a dirty old MS Wireless Mobile Mouse 4000 out of a mate's bin and
it breaks this assumption. The resolution multiplier is 16 which isn't an
integer fraction of 120. Real multiplier is 7.5.

The device sends hi-res values of 4, so it should end up as REL_WHEEL_HI_RES
30. We are getting 28 instead which doesn't add up to a nice 120.
Basic assumption: MS uses something other than plain 120 internally.

The choices we have now are:
- use 1200 or 12000 internally and divide by 10 before sending the
  final value
- just make the evdev API use 1200 or 12000 and let userspace deal with it.
  much simpler.

Any suggestions/comments?

Cheers,
   Peter
