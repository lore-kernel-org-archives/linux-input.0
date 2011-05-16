From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/5] tsc2007: Add max_rt module parameter.
Date: Mon, 16 May 2011 09:53:00 -0700
Message-ID: <20110516165300.GB21232@core.coreip.homeip.net>
References: <1305534783-4917-1-git-send-email-thierry.reding@avionic-design.de>
 <1305534783-4917-2-git-send-email-thierry.reding@avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f173.google.com ([209.85.212.173]:50969 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959Ab1EPQxH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 May 2011 12:53:07 -0400
Received: by pxi16 with SMTP id 16so3196856pxi.4
        for <linux-input@vger.kernel.org>; Mon, 16 May 2011 09:53:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1305534783-4917-2-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: linux-input@vger.kernel.org, Kwangwoo Lee <kwlee@mtekvision.com>

Hi Thierry,

On Mon, May 16, 2011 at 10:33:00AM +0200, Thierry Reding wrote:
> Finger touch events or very quick stylus events on low-quality panels
> can cause the tsc2007 to read bogus values. Looking at oscilloscope
> snapshots, this seems to be caused by the touch event disappearing
> during the measurements. These bogus values result in misclicks, where
> the X and Y values deviate from the real position.
> 
> Most of these misclicks can be filtered out by setting a low enough
> threshold for the maximum resistance (which is loosely the inverse of
> the pressure) allowed to consider a set of values valid. Since this
> behaviour is largely dependent on the type and quality of the panel,
> this commit introduces the max_rt parameter. The default value is kept
> at MAX_12BIT.

I expect that the values, once selected, will not be changed for a given
panel, so why don't we pass max_rt (and poll_delay and poll_interval) vi
platform (board) data instead of being module parameters?

Thanks.

-- 
Dmitry
