From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: sentelic - filter on-pad clicks in absolute mode
Date: Mon, 2 Apr 2012 09:04:16 -0700
Message-ID: <20120402160416.GA6213@core.coreip.homeip.net>
References: <20120401183037.GA23849@timantti.taisia.fi>
 <4F79B620.7030800@canonical.com>
 <4F79BE70.90005@ohmu.fi>
 <4F79C029.3040606@canonical.com>
 <4F79C7A0.6060601@ohmu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46541 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345Ab2DBQEY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Apr 2012 12:04:24 -0400
Received: by iagz16 with SMTP id z16so4277811iag.19
        for <linux-input@vger.kernel.org>; Mon, 02 Apr 2012 09:04:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F79C7A0.6060601@ohmu.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oskari Saarenmaa <os@ohmu.fi>
Cc: Chase Douglas <chase.douglas@canonical.com>, Tai-hwa Liang <avatar@sentelic.com>, linux-input@vger.kernel.org

On Mon, Apr 02, 2012 at 06:37:04PM +0300, Oskari Saarenmaa wrote:
> On 02/04/12 18:05, Chase Douglas wrote:
> >On 04/02/2012 07:57 AM, Oskari Saarenmaa wrote:
> >>On 02/04/12 17:22, Chase Douglas wrote:
> >>>On 04/01/2012 11:30 AM, Oskari Saarenmaa wrote:
> >>>>On-pad clicks in absolute positioning single-finger mode are reported
> >>>>without the PHY_BTN bit set, the on-pad clicks are handled by userspace
> >>>>so the kernel shouldn't report them as real clicks.
> >>>
> >>>What is the definition of an "on-pad" click?
> >>
> >>In this case it's a tap on the pad without actually clicking it.  The
> >>Asus UX21 Zenbook has a touchpad that can be tapped or clicked.
> >>Single-finger taps on it are reported by the touchpad with FSP_PB0_LBTN
> >>flag set and FSP_PB0_PHY_BTN not set.
> >
> >So if I understand correctly, the device currently emits a "physical"
> >left button click event when the clickpad is tapped. Your patch will
> >prevent this event from being sent to userspace, since userspace does
> >its own tap detection. Is that correct?
> 
> Yes.  Without this patch there's no way to disable click-on-tap in
> userspace.

Makes sense to me. Tai-hwa, any objections?

BTW, I think we should suppress creating vscroll, hscroll and probably
flags attributes when touchpad is in absolute mode since they are not
applicable there (via attribute group's visible() methos). I am always
takig patches ;)

Thanks.

-- 
Dmitry
