From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH RFC V2 0/3] Input: goodix - add axis swapping and axis
 inversion support
Date: Mon, 12 Oct 2015 15:09:58 +0200
Message-ID: <1444655398.28661.84.camel@hadess.net>
References: <1444413352-24529-1-git-send-email-merker@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:53678 "EHLO
	relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbbJLNKO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Oct 2015 09:10:14 -0400
In-Reply-To: <1444413352-24529-1-git-send-email-merker@debian.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Karsten Merker <merker@debian.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Irina Tirdea <irina.tirdea@intel.com>, Aleksei Mamlin <mamlinav@gmail.com>, linux-input@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>

On Fri, 2015-10-09 at 19:55 +0200, Karsten Merker wrote:
> Hello,
> 
> this is v2 of my "Input: goodix - add axis swapping and axis
> inversion
> support" patchset.
> The goodix touchscreen driver has gained device-tree support in
> kernel
> 4.1, but doesn't currently support the touchscreen-swapped-x-y,
> touchscreen-inverted-x and touchscreen-inverted-y properties.
> 
> On systems which combine a portrait-mode display with a landscape-
> mode
> touchscreen, such as e.g. the MSI Primo 81 tablet, support for these
> features is necessary to have the touchscreen and the display use the
> same coordinate system.
> 
> With support for axis inversion, the "rotated_screen" flag in the
> driver can also be removed, as "rotated_screen" is just a special
> case
> of x/y axis inversion.
> 
> This patchset sits on top of the "[PATCH v8 0/9] Goodix touchscreen
> enhancements" series by Irina Tirdea:
> https://www.spinics.net/lists/linux-input/msg41437.html
> 
> I have successfully tested the axis swapping on an (arm-based) MSI
> Primo 81 tablet, but I lack appropriate hardware to do a real-world
> test of the "rotated_screen" code path, so I would appreciate very
> much if somebody with appropriate hardware (WinBook TW100 or TW700)
> could give it a try.


I've pushed the first 2 patches of this patchset to:
https://github.com/hadess/gt9xx/tree/karsten-merker

And tested on the TW100. You can add:
Tested-by: Bastien Nocera <hadess@hadess.net>

To the first 2 patches.

Cheers
