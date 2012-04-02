From: simon@mungewell.org
Subject: Re: [PATCH v4] HID: lg4ff: Remove sysfs iface before deallocating
 memory
Date: Sun, 1 Apr 2012 21:49:35 -0400
Message-ID: <a4e40aa5c43be934d83240849aa25f3b.squirrel@mungewell.org>
References: <2198552.DMoMTvshKQ@qosmio-x300>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:50705 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753805Ab2DBBth (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 1 Apr 2012 21:49:37 -0400
In-Reply-To: <2198552.DMoMTvshKQ@qosmio-x300>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?=22Michal_Mal=FD=22?= <madcatxster@gmail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, simon@mungewell.org

Hi all,
Looks good to me, built and tested working with a G27.

I also have the 3rd patch (mentioned by Michal) and a 4th which impleme=
nts
LED control on the G27. How do you want these sent? (they need to be bu=
ilt
on top of Michal's patches)

Simon

Signed-off-by: simon@mungewell.org

> Hi,
>
> This patch fixes a possible race condition caused by the sysfs
> interface being removed after the memory used by the interface
> was already kfree'd.
> Please note that this patch depends on "hid-lg: Allow for custom
> device-specific properties to be stored in private drv data" because
> it also fixes a tiny glitch - a leftover #include in the hid-lg.h
>
> I have another lg4ff patch pending that makes use of the new possibil=
ity
> to
> store device-specific data which is currently being review by Simon.
> The patch as it is right now will depend on this patch.
>
> Signed-off-by: Michal Mal=FD <madcatsxter@gmail.com>
>

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
