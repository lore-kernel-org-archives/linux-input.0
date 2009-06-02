From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] appletouch: Improved finger detection
Date: Tue, 2 Jun 2009 04:29:23 -0700
Message-ID: <200906020429.24264.dmitry.torokhov@gmail.com>
References: <3AC3E247-D85C-4D8A-A73B-34677C32C2D5@freedesktop.org> <20090508025839.GC30616@dtor-d630.eng.vmware.com> <A0EA7857-9F51-44DE-8A88-80733F6057A9@freedesktop.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f177.google.com ([209.85.222.177]:65509 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752345AbZFBNrU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Jun 2009 09:47:20 -0400
Received: by pzk7 with SMTP id 7so6660822pzk.33
        for <linux-input@vger.kernel.org>; Tue, 02 Jun 2009 06:47:21 -0700 (PDT)
In-Reply-To: <A0EA7857-9F51-44DE-8A88-80733F6057A9@freedesktop.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeremy Huddleston <jeremyhu@freedesktop.org>
Cc: linux-input@vger.kernel.org, johannes@sipsolutions.net, jasonparekh@gmail.com

On Monday 01 June 2009 00:35:53 Jeremy Huddleston wrote:
> On May 7, 2009, at 19:59, Dmitry Torokhov wrote:
> > HI Jeremy,
> >
> > On Tue, May 05, 2009 at 12:10:34PM -0700, Jeremy Huddleston wrote:
> >> The appletouch driver is prone to reporting multiple fingers when
> >> only
> >> one is
> >> pressing.  The appletouch driver queries an array of pressure sensors
> >> and
> >> counts local maxima in pressure to determine the number of
> >> fingers.  It
> >> just
> >> does this on the raw values, so a data stream like:
> >>
> >> 0 100 250 300 299 300 250 100 0
> >>
> >> actually registers as 2 fingers.
> >>
> >> This patch updates the logic to ignore small dips in pressure that
> >> are
> >> less
> >> than the threshold.
> >
> > Does it still detect 2 fingers as 2 fingers when they are held
> > together?
>
> I just wanted to follow up on this patch[1], since I haven't seen any
> movement.  It's fairly trivial and I've been using it for the past
> month with great success (yes, it still detects 2 fingers properly).
> Is there hope that this change can get merged soon?
>

Gah, I was sure I applied it to 'next'. Sorry about that, I will
make sure it gets into .31.

-- 
Dmitry
