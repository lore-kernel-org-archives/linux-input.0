From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC] Input: Remove unused BUS IDs
Date: Mon, 1 Dec 2014 11:57:03 +0100
Message-ID: <0AD2E03A-8FC9-4A08-A647-36FB22B77A47@holtmann.org>
References: <1417431087-30330-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:56214 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752888AbaLAK5G (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 1 Dec 2014 05:57:06 -0500
In-Reply-To: <1417431087-30330-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>

Hi Jarkko,

> There are a few BUS IDs that are not used anywhere in kernel tree:
> 
> - BUS_ISAPNP
>  Has no changes or use in kernel git history
> - BUS_GSC
>  Was added by commit 6ab0f5cd3644 ("[PARISC] Update parisc specific input
>  code from parisc tree") but never used
> - BUS_ATARI
>  Became unused after commit 6615c5b25e0b ("m68k: Atari input drivers
>  cleanup")
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
> I'm not familiar with the input and don't know is there use for these in
> userspace. Therefore I didn't sort these IDs after removal.

actually /dev/uinput can still use these values if it wants to.

Regards

Marcel

