From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 4/4] input: dynamically allocate ABS information
Date: Sat, 7 Aug 2010 17:23:09 +0200
Message-ID: <20100807152309.GF17833@buzzloop.caiaq.de>
References: <1274289757-2723-1-git-send-email-daniel@caiaq.de>
 <1274289757-2723-5-git-send-email-daniel@caiaq.de>
 <20100524160805.GO30801@buzzloop.caiaq.de>
 <20100524161527.GC3182@core.coreip.homeip.net>
 <20100616083903.GU17833@buzzloop.caiaq.de>
 <20100721083048.GA21558@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100721083048.GA21558@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

sorry for the late reply on this, I guess I haven't been much help
around here lately.

On Wed, Jul 21, 2010 at 01:30:48AM -0700, Dmitry Torokhov wrote:
> The approach is pretty solid, with the exception that I do not think
> we'd save much if we allocate every axis data separately (as I mentioned
> in one of my earlier mails).

Agreed. We at least save the memory for all input devices that don't
have absolute axis at all.

> Coudl you please take a look at the following patches and let me know if
> you see something wrong.

I checked the patches and tried them locally on my desktop, and I can't
see any breakage, but we might need more coverage for testing.

Will you push them to the .36 merge window or is it too late for this?

Many thanks for your help :)

Daniel
