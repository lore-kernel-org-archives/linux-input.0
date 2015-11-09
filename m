From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH] Input: parkbd - Drop bogus __init from
 parkbd_allocate_serio()
Date: Mon, 9 Nov 2015 18:35:27 +0530
Message-ID: <20151109130440.GC3868@sudip-pc>
References: <1446911603-21242-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33460 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398AbbKINFe (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Nov 2015 08:05:34 -0500
Content-Disposition: inline
In-Reply-To: <1446911603-21242-1-git-send-email-geert@linux-m68k.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Nov 07, 2015 at 04:53:23PM +0100, Geert Uytterhoeven wrote:
> WARNING: vmlinux.o(.text+0x1056606): Section mismatch in reference from the function parkbd_attach() to the function .init.text:parkbd_allocate_serio()
> The function parkbd_attach() references
> the function __init parkbd_allocate_serio().
> This is often because parkbd_attach lacks a __init
> annotation or the annotation of parkbd_allocate_serio is wrong.
> 
> Commit 33ca8ab97cbb676d ("Input: parkbd - use parallel port device
> model") dropped the __init attribute from the sole caller of
> parkbd_allocate_serio(), but forgot to remove it from
> parkbd_allocate_serio() itself.
> 
> Fixes: 33ca8ab97cbb676d ("Input: parkbd - use parallel port device model")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

I don't see this with allmodconfig on i386 or on x86_64. How did you get
this warning? But anyway, looking at the code, i did miss attribute.

Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

regards
sudip
