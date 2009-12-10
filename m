From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/7] msi-wmi driver and cleanups
Date: Thu, 10 Dec 2009 09:47:50 -0800
Message-ID: <20091210174749.GA23717@core.coreip.homeip.net>
References: <1260451099-25620-1-git-send-email-anisse@astier.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:41001 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761006AbZLJRrw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Dec 2009 12:47:52 -0500
Content-Disposition: inline
In-Reply-To: <1260451099-25620-1-git-send-email-anisse@astier.eu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anisse Astier <anisse@astier.eu>
Cc: linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Matt Chen <machen@novell.com>

On Thu, Dec 10, 2009 at 02:18:12PM +0100, Anisse Astier wrote:
> This driver adds support for WMI-based hotkeys and backlight for some MSI 
> laptops and all-in-one computers.
> 
> This driver was sent in the end of october by Thomas Renninger
> (cf http://patchwork.kernel.org/patch/55944/ ). I'm re-sending it as-is (I
> just added my Reviewed-by:); it is the first patch of this serie because 
> it doesn't look like it has been integrated yet in Len's ACPI tree.
> 
> Other patches are just a follow-up to my previous comments on this driver,
> that I would like to see merged for 2.6.33.
> 
> Please note that the last patch of this serie requires Dmitry's input next
> tree to have the sparse keymap library.
> 

FWIW sparse keymap module is in mainline now. The last patch looks good
BTW.

-- 
Dmitry
