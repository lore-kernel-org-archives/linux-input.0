From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4] Documentation: Add evdev type and code definitions
Date: Wed, 6 Apr 2011 15:07:01 -0700
Message-ID: <20110406220701.GA11611@core.coreip.homeip.net>
References: <1302121172-16703-1-git-send-email-chase.douglas@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64116 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932117Ab1DFWHI (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Apr 2011 18:07:08 -0400
Content-Disposition: inline
In-Reply-To: <1302121172-16703-1-git-send-email-chase.douglas@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Peter Hutterer <peter.hutterer@who-t.net>, Nikolai Kondrashov <spbnick@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Bagwell <chris@cnpbagwell.com>

Hi Chase,

On Wed, Apr 06, 2011 at 04:19:31PM -0400, Chase Douglas wrote:
> This commit adds the file Documentation/input/evdev-codes.txt.
> 
> Cc: Henrik Rydberg <rydberg@euromail.se>
> Cc: Peter Hutterer <peter.hutterer@who-t.net>
> Cc: Nikolai Kondrashov <spbnick@gmail.com>
> Cc: linux-input@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Acked-by: Henrik Rydberg <rydberg@euromail.se>
> Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
> Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>

Thank you very much for doing this. I am very happy with the state of
document at the moment and I want to apply it and get in .39.

The only 2 changes I'd like (I'll do them on my side) is renaming the
file from evdev-codes to event-codes and evdev protocol to input
protocol since the data applicable not only to evdev but to entire input
core.

Thanks.

-- 
Dmitry
