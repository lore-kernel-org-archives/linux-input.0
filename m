From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] Input: hgpk - enable advanced mode through module parameter
Date: Tue, 5 Oct 2010 10:23:33 -0700
Message-ID: <201010051023.34120.dmitry.torokhov@gmail.com>
References: <20101002204235.052959D401B@zog.reactivated.net> <20101004174533.GC8321@core.coreip.homeip.net> <AANLkTinHiCWBb+wZT9niBfGWd3Q-X448CdtMC8yD0NtF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61687 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827Ab0JERXm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Oct 2010 13:23:42 -0400
Received: by iwn5 with SMTP id 5so8565651iwn.19
        for <linux-input@vger.kernel.org>; Tue, 05 Oct 2010 10:23:41 -0700 (PDT)
In-Reply-To: <AANLkTinHiCWBb+wZT9niBfGWd3Q-X448CdtMC8yD0NtF@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-input@vger.kernel.org, pgf@laptop.org

On Tuesday, October 05, 2010 09:59:35 am Daniel Drake wrote:
> On 4 October 2010 18:45, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > Why do you use abs->rel conversion in driver and not rely on the
> > standard userspace component handling thouchpads in absolute mode?
> 
> Thanks for your feedback.
> 
> The justification mainly revolves around a patch that I saved for
> later - one that enables pentablet mode for use with a stylus, which
> relies on advanced mode. I'll include that patch when I come to
> resending them all after this review, so that everything is clear.
> 
> But we don't actually want to use it as a tablet, we want to use it as
> a mouse pointer (since the touchpad way of using the mouse is not very
> reliable)

What does this mean? All laptops that I have use touchpads that work in 
absolute mode (Synaptics or ALPS) and they work fairly well. The Synaptics X 
driver understands the difference in tablet vs. touchpad and does the right 
thing for touchpads.

You just need to make sure that X actually uses Synaptics (xf86-input-
synaptics) with your device, emitting BTN_TOOL_FINGER should help a lot.

-- 
Dmitry
