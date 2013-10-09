From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: logitech - lg2ff: Add IDs for Formula Vibration
 Feedback Wheel
Date: Wed, 9 Oct 2013 12:09:34 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1310091208260.13289@pobox.suse.cz>
References: <1381164492-27145-1-git-send-email-anssi.hannula@iki.fi> <cec1e0ca61cf17ceb6e52faa4f2baad9.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42913 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753111Ab3JIKJn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Oct 2013 06:09:43 -0400
In-Reply-To: <cec1e0ca61cf17ceb6e52faa4f2baad9.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Wood <simon@mungewell.org>
Cc: Anssi Hannula <anssi.hannula@iki.fi>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Elias Vanderstuyft <elias.vds@gmail.com>, stable@vger.kernel.org, =?ISO-8859-15?Q?=22Michal_Mal=FD=22?= <madcatxster@prifuk.cz>

On Mon, 7 Oct 2013, simon@mungewell.org wrote:

> > The lg2ff force feedback subdriver is used for vibration and
> > HID_GD_MULTIAXIS is set to avoid deadzone like other Logitech wheels.
> >
> > Kconfig description etc are also updated accordingly.
> >
> > Signed-off-by: Elias Vanderstuyft <Elias.vds@gmail.com>
> > [anssi.hannula@iki.fi: added description and CCs]
> > Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
> > Cc: Simon Wood <simon@mungewell.org>
> > Cc: <stable@vger.kernel.org>
> > ---
> >
> > Simon, does this look OK to you, or do you think it should be an lg4ff
> > device? Though I guess lg2ff is better than nothing even in that case.
> 
> Signed-off-by: Simon Wood <simon@mungewell.org>

Thanks, I have now applied the patch. In case you are going to work 
further on splitting break/accel into different axes, please send it as a 
followup patch.

Thanks.

-- 
Jiri Kosina
SUSE Labs
