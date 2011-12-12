From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/2] Input: wacom: Add support for Cintiq 24HD
Date: Mon, 12 Dec 2011 00:14:53 -0800
Message-ID: <20111212081453.GF4682@core.coreip.homeip.net>
References: <1323299097-1576-1-git-send-email-killertofu@gmail.com>
 <CAF8JNhJmDWtTGm3GQjH1_5YO=KYghxEfQynhvPVy=Rts1Fdxpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48590 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690Ab1LLIO7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Dec 2011 03:14:59 -0500
Received: by mail-iy0-f174.google.com with SMTP id h11so2850219iae.19
        for <linux-input@vger.kernel.org>; Mon, 12 Dec 2011 00:14:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAF8JNhJmDWtTGm3GQjH1_5YO=KYghxEfQynhvPVy=Rts1Fdxpg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Jason Gerecke <killertofu@gmail.com>, linux-input@vger.kernel.org

On Thu, Dec 08, 2011 at 04:34:52PM -0800, Ping Cheng wrote:
> On Wed, Dec 7, 2011 at 3:04 PM, Jason Gerecke <killertofu@gmail.com> wrote:
> > Adds support for the Cintiq 24HD. There are two quirks about this
> > model that haven't been seen in prior tablets. First, a second
> > touch ring is present on this display; it is being exposed via the
> > ABS_THROTTLE axis. Second, three capacitive buttons at the top of
> > the unit are available; though physically a touch strip, we report
> > the use of these buttons with generic KEY_ events.
> >
> > Signed-off-by: Jason Gerecke <killertofu@gmail.com>
> 
> Reviewed-by: Ping Cheng <pingc@wacom.com>

Applied, thank you.

-- 
Dmitry
