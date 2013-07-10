From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH 2/2] Input: Adding DT support for keyreset tuneables
Date: Wed, 10 Jul 2013 16:14:57 +0100
Message-ID: <20130710151457.D0B863E1168@localhost>
References: <1372349605-4500-1-git-send-email-mathieu.poirier@linaro.org> <1372349605-4500-2-git-send-email-mathieu.poirier@linaro.org> <20130627162820.GA12070@core.coreip.homeip.net> <51CC7CD5.5090508@linaro.org> <20130627182500.GB12961@core.coreip.homeip.net> <51CC8786.1070200@linaro.org> <20130628060945.GA17523@core.coreip.homeip.net> <51CD8D4A.10207@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:45808 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571Ab3GJPPM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Jul 2013 11:15:12 -0400
Received: by mail-wg0-f43.google.com with SMTP id z11so6093033wgg.22
        for <linux-input@vger.kernel.org>; Wed, 10 Jul 2013 08:15:10 -0700 (PDT)
In-Reply-To: <51CD8D4A.10207@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mathieu Poirier <mathieu.poirier@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: devicetree-discuss@lists.ozlabs.org, john.stultz@linaro.org, kernel-team@android.com, linux-input@vger.kernel.org

On Fri, 28 Jun 2013 07:19:06 -0600, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
> On 13-06-28 12:09 AM, Dmitry Torokhov wrote:
> >>>> I do not agree.  We want the binding to be generic and not tied
> >>>> specifically to the keyreset functionality.  As such 'input-keyset' or
> >>>> 'input-keychord' are more appropriate.
> >>>
> >>> The binding is defined specifically for sysrq and specifically to
> >>> perform reset action.
> >>
> >> Yes for now but as the examples in the binding show, it is easy to
> >> envision how other drivers could use it.
> > 
> > I think you over-complicate things here. Unlike matrix-keypad binding,
> > where you have a common parsing code, here we have an individual driver.
> > I really do not see anyone else using such sequences or chords as such
> > processing should be done in userspace. Sysrq is quite an exception.
> 
> To be honest I don't have a very strong opinion on the binding.  I made
> it as generic as possible on the guidance of the DT people.  Let's see
> what they think of it.

Hi Mathieu,

As per our conversation just now at Connect, the binding should probably
look like this:

Sysrq keyset binding:

The /chosen node can contain a linux,input-keyset-sysrq child node to
define a set of keys that will generate a sysrq when pressed together.

Required properties:
keyset: array of keycodes
timeout-ms: duration keys must be pressed together in microseconds
before generating a sysrq

g.
