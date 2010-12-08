From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: mt: Add hovering distance axis
Date: Wed, 8 Dec 2010 10:05:21 -0800
Message-ID: <20101208180521.GA31522@core.coreip.homeip.net>
References: <1291710468-2022-1-git-send-email-rydberg@euromail.se>
 <4CFFC45C.2040107@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53120 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755095Ab0LHSFa (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Dec 2010 13:05:30 -0500
Content-Disposition: inline
In-Reply-To: <4CFFC45C.2040107@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On Wed, Dec 08, 2010 at 09:46:04AM -0800, Chase Douglas wrote:
> On 12/07/2010 12:27 AM, Henrik Rydberg wrote:
> > Touch devices capable of hovering, i.e., fingers detected a distance
> > from the surface, are not supported by the current input MT
> > protocol. This patch adds ABS_MT_DISTANCE, which may be used to
> > indicate the distance between the contact and the surface.
> 
> Have you given thought to calling it ABS_MT_Z instead? I have no real
> problem with ABS_MT_DISTANCE per se, but ABS_MT_Z is more clearly
> defined in my head. If I was new to MT development I may wonder if
> ABS_MT_DISTANCE had anything to do with distance between points or some
> other object.

X/Y/Z imply that we fully engaged the device and it is 3 dimensional.
Distance says that we are approaching the device but have not directly
engaged it yet.

I think ABS_DISTANCE was added at Pings request and ABS_MT_DISTANCE is
modeled after ST one. Ping, could you refresh my memory why we needed
ABS_DISTANCE?

Thanks.

-- 
Dmitry
