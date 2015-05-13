From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: usbhid: Add HID_QUIRK_NOGET for Aten DVI KVM
 switch
Date: Wed, 13 May 2015 13:25:00 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1505131324470.8186@pobox.suse.cz>
References: <1431450000-25236-1-git-send-email-labbott@fedoraproject.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42441 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751921AbbEMLZD (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 13 May 2015 07:25:03 -0400
In-Reply-To: <1431450000-25236-1-git-send-email-labbott@fedoraproject.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Laura Abbott <labbott@fedoraproject.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, stephane.tranchemer@devinci.fr

On Tue, 12 May 2015, Laura Abbott wrote:

> Like other KVM switches, the Aten DVI KVM switch needs a
> quirk to avoid spewing errors:
> 
> [791759.606542] usb 1-5.4: input irq status -75 received
> [791759.614537] usb 1-5.4: input irq status -75 received
> [791759.622542] usb 1-5.4: input irq status -75 received
> 
> Add it.
> 
> Signed-off-by: Laura Abbott <labbott@fedoraproject.org>

Applied for for-4.1/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs
