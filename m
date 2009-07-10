From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Re: [PATCH 0/2] Winbond driver as PNP
Date: Fri, 10 Jul 2009 09:55:27 +0200 (CEST)
Message-ID: <11512ed726f2d6754f46e76c7db191a8.squirrel@www.hardeman.nu>
References: <1246079912-17619-1-git-send-email-david@hardeman.nu>
    <737c7bd0a2f550d21d45b347d018a1ac.squirrel@www.hardeman.nu>
    <200907081052.20142.bjorn.helgaas@hp.com>
    <200907091538.21685.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:57733 "EHLO
	palpatine.hardeman.nu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbZGJHz3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Jul 2009 03:55:29 -0400
In-Reply-To: <200907091538.21685.bjorn.helgaas@hp.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, jbarnes@virtuousgeek.org, Len Brown <lenb@kernel.org>

On Thu, July 9, 2009 23:38, Bjorn Helgaas wrote:
> Here are two sample patches to show you what I was suggesting.  These
> apply on top of the two Winbond patches currently in -mm.

Thanks, great service :)

I'll test the patches as soon as I have time and access to the hardware=
=2E

One question though, the resulting patch series (if AKPM merges these
patches in addition to the existing ones and drops the patch adding
=2Eshutdown to acpi_driver) will be git bisect unfriendly.

Should I roll two new patches instead to replace the three patches
currently in -mm?

--=20
David H=E4rdeman

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
