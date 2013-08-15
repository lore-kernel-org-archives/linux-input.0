From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elantech - fix packet check for v3 and v4 hardware
Date: Thu, 15 Aug 2013 00:12:51 -0700
Message-ID: <20130815071251.GC15691@core.coreip.homeip.net>
References: <1376473037-11211-1-git-send-email-kendatsuba@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:41624 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758756Ab3HOHMy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Aug 2013 03:12:54 -0400
Received: by mail-pb0-f43.google.com with SMTP id md4so444869pbc.2
        for <linux-input@vger.kernel.org>; Thu, 15 Aug 2013 00:12:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1376473037-11211-1-git-send-email-kendatsuba@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matteo Delfino <kendatsuba@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Matteo,

On Wed, Aug 14, 2013 at 11:37:17AM +0200, Matteo Delfino wrote:
> The signatures of v3 and v4 packets change depending on the value of a
> hardware flag called 'crc_enabled'. The packet type detection must change
> accordingly.
> 
> This patch also restores a consistency check for v4 packets inadvertently
> removed by commit:
> 
> 9eebed7de660c0b5ab129a9de4f89d20b60de68c
> Input: elantech - fix for newer hardware versions (v7)
> 
> A note about the naming convention: v3 hardware is associated with IC body
> v5 while v4 hardware is associated with IC body v6 and v7. The above commit
> refers to IC body v7, not to v7 hardware.
> 
> Tested on Samsung NP730U3E (fw = 0x675f05, ICv7, crc_enabled = 1)
> 
> Tested-by: Giovanni Frigione <gio.frigione@gmail.com>
> Signed-off-by: Matteo Delfino <kendatsuba@gmail.com>
> ---
> 
> Hello Dmitry,
> this patch is based on some information provided by elantech. It has
> been successfully tested on the above v4 hardware so the information
> seems to be reliable. More testing is needed on v3 hardware with
> crc_enabled=1 (if there's such hardware out there..). The behaviour
> should be unchanged for v3 and v4 hardware with crc_enabled=0 (the
> vast majority).
> 
> I was asked to CC stable kernels too since this patch restores a
> consistency check on v4 packets removed by a previous commit already
> queued in linux-3.5.y-queue but, considering the above, I think it's
> best to leave this decision to you.

Once again, I think it should bake a bit in the trees before heading for
next, so I won't mark it for stable. Feel free to forward it later, once
it survives a few -rcs.

Thanks!

-- 
Dmitry
