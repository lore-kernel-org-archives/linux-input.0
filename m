From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] psmouse: Expose drift duration for IBM trackpoints
Date: Wed, 17 Dec 2014 15:31:58 -0800
Message-ID: <20141217233158.GB21713@dtor-ws>
References: <5491B8DB.6070102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:56005 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbaLQXcD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Dec 2014 18:32:03 -0500
Received: by mail-ie0-f171.google.com with SMTP id rl12so107274iec.2
        for <linux-input@vger.kernel.org>; Wed, 17 Dec 2014 15:32:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5491B8DB.6070102@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: haarp <main.haarp@googlemail.com>
Cc: linux-input@vger.kernel.org

On Wed, Dec 17, 2014 at 06:09:47PM +0100, haarp wrote:
> Hello,
> 
> IBM Trackpoints have a feature to compensate for drift by
> recalibrating themselves periodically. If for 0.5 seconds
> there is no change in position, it uses this as the new zero.
> 
> This happens often when the trackpoint is in fact being used.
> This is frustrating.
> 
> Raising the time solves the problem.
> IBM's Trackpoint Engineering Specifications offer a
> configuration register for this (rstdft1). It just needs to
> be exposed by the driver, as others already are.
> 
> Cheers!
> -Mike
> 
> 
> IBM Trackpoints have a feature to compensate for drift by recalibrating
> themselves periodically. By default, if for 0.5 seconds there is no change in
> position, it's used as the new zero. This duration is too low. Often, the
> calibration happens when the trackpoint is in fact being used.
> 
> IBM's Trackpoint Engineering Specifications show a configuration register that
> allows changing this duration, rstdft1.
> 
> Expose it via sysfs among the other settings.
> 
> Signed-off-by: Mike Murdoch <main.haarp@gmail.com>

Applied, thank you.

-- 
Dmitry
