From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/6] Haptic: add haptic class
Date: Wed, 14 Oct 2009 00:59:19 -0700
Message-ID: <20091014075919.GD5318@core.coreip.homeip.net>
References: <20091007061701.GA7567@july> <359ed6810910130335m45919d6ala921d4cbfa5a341a@mail.gmail.com> <5d5443650910130413t6ecd3d54p214d8f80972ed128@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f186.google.com ([209.85.221.186]:38932 "EHLO
	mail-qy0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756254AbZJNIAB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Oct 2009 04:00:01 -0400
Content-Disposition: inline
In-Reply-To: <5d5443650910130413t6ecd3d54p214d8f80972ed128@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: Jani Nikula <ext-jani.1.nikula@nokia.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Tue, Oct 13, 2009 at 04:43:43PM +0530, Trilok Soni wrote:
> Hi Kyungmin, Dmitry,
> 
> On Tue, Oct 13, 2009 at 4:05 PM, Jani Nikula
> <ext-jani.1.nikula@nokia.com> wrote:
> > On Wed, Oct 7, 2009 at 09:17, Kyungmin Park <kyungmin.park@samsung.com> wrote:
> >> New haptic class support.
> >> This class handles the haptic devices.
> >
> > I'm wondering why a haptic class is needed when there is force
> > feedback support. Admittedly, I don't know the force feedback
> > implementation too well, but could someone please enlighten me on
> > this? Am I missing something here?
> >
> > I see haptics as simple force feedback, just with (usually) small
> > force and short duration. There are devices out there doing haptics
> > using vibra motors, which I think would be limited if implemented
> > using this haptics class driver. Would it be somehow problematic
> > interfacing with the simple haptic hardware using the force feedback
> > API?
> 
> Please share your inputs on ff_device usage instead of haptics class.
> I think Dmitry could add some points here as I don't see much users of
> ff_device and I don't see any embedded device (like mobile) using it.
> 

Using ff_device was considered when Jiri Slaby was trying to merge
PHANTOM driver, bit for that device FF infrastructure was too limited
and this it was decided that phantom would need a special userpsace that
knows what it is and how to handle it.

The curtrent haptic class seems to be bery limited and may be served via
FF (constant or other effect in a single direction) but I don't know
what kind of plans you have to extend it. I guess it warrants another
discussion.

-- 
Dmitry
