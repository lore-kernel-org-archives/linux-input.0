From: Aleksei Mamlin <mamlinav@gmail.com>
Subject: Re: [PATCH RFC V3 0/3] Input: goodix - add axis swapping and axis
 inversion support
Date: Wed, 21 Oct 2015 13:44:23 +0300
Message-ID: <20151021134423.cd519ae71b851dc33e7b36cd@gmail.com>
References: <1445183579-29176-1-git-send-email-merker@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:36664 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918AbbJUKoY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Oct 2015 06:44:24 -0400
In-Reply-To: <1445183579-29176-1-git-send-email-merker@debian.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Karsten Merker <merker@debian.org>
Cc: Bastien Nocera <hadess@hadess.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Irina Tirdea <irina.tirdea@intel.com>, linux-input@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>

On Sun, 18 Oct 2015 17:52:56 +0200
Karsten Merker <merker@debian.org> wrote:

> Hello,
> 
> this is v3 of my "Input: goodix - add axis swapping and axis inversion
> support" patchset.
> 
> The goodix touchscreen driver has gained device-tree support in kernel
> 4.1, but doesn't currently support the touchscreen-swapped-x-y,
> touchscreen-inverted-x and touchscreen-inverted-y properties.
> On systems which combine a portrait-mode display with a landscape-mode
> touchscreen, such as e.g. the MSI Primo 81 tablet, support for these
> features is necessary to have the touchscreen and the display use the
> same coordinate system.
> 
> With support for axis inversion, the "rotated_screen" flag in the
> driver can also be removed, as "rotated_screen" is just a special case
> of x/y axis inversion.
> 
> This patchset sits on top of the "[PATCH v9 0/9] Goodix touchscreen
> enhancements" series by Irina Tirdea:
> https://www.spinics.net/lists/linux-input/msg41501.html
> 
> The axis swapping has successfully been tested on an (arm-based)
> MSI Primo 81 tablet; the x/y inversion resp. the rotated_screen
> functionality has successfully been tested on a WinBook TW100.
> 
> @Bastien: You had acked patch No. 1 in v2 of the patchset. I have
>           not transferred that ack to v3 of the same patch
>           because I have have introduced some changes into that
>           patch (based on Irina's review comments, cf. the
>           changelog below) after your ack.  I would apprechiate
>           very much if you could take a look and tell me whether
>           your ack extends to v3 as well.
> 
> Regards,
> Karsten
> 
> Changelog:
> 
> v1: * Initial version (based von v6 of Irina Tirdea's "Goodix
>       touchscreen enhancements" series).
>       Reviewed-by: Bastien Nocera <hadess@hadess.net>
> 
> v2: * Rebase against v8 of Irina Tirdea's "Goodix touchscreen
>       enhancements" series.
>     * Fix a typo in the commit message.
>     * Add an update for the goodix dt bindings documentation
>       (patch No. 3).
>     * Reviews/Tests:
>       Patch 1+2: Tested-by: Bastien Nocera <hadess@hadess.net>
>                  Acked-by: Bastien Nocera <hadess@hadess.net>
>       Patch 2+3: Reviewed-by: Irina Tirdea <irina.tirdea@intel.com>
> 
> v3: * Rebase against v9 of Irina Tirdea's "Goodix touchscreen
>       enhancements" series.
>     * Address the review comments for patch No. 1 by Irina Tirdea
>       (https://www.spinics.net/lists/linux-input/msg41536.html):
>       - Move reading the dt properties from goodix_ts_probe to
>         goodix_configure_dev to make them work properly in all
>         configurations (with and without gpio declarations).
>       - Use the new unified device properties API (device_property_*)
>         instead of the classic DT API (of_property_*). This
>         provides support for ACPI 5.1 DSD properties as well as 
>         for device-tree properties.
> 
> Karsten Merker (3):
>   Input: goodix - add axis swapping and axis inversion support
>   Input: goodix - use "inverted_[xy]" flags instead of "rotated_screen"
>   Input: goodix - update dt bindings documentation (axis
>     swapping/inversion)
> 
>  .../bindings/input/touchscreen/goodix.txt          |  6 +++++
>  drivers/input/touchscreen/goodix.c                 | 31 ++++++++++++++++++----
>  2 files changed, 32 insertions(+), 5 deletions(-)
> 
> -- 
> 2.1.4

Tested on Wexler TAB7200 with device-tree properties.

Tested-by: Aleksei Mamlin <mamlinav@gmail.com>


-- 
Thanks and regards,
Aleksei Mamlin
