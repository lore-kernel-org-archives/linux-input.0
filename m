From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: atkbd - add forced release keys quirk for
	Positivo I30
Date: Sun, 18 Oct 2009 00:07:32 -0700
Message-ID: <20091018070732.GA3935@core.coreip.homeip.net>
References: <1255731495-27552-1-git-send-email-herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f171.google.com ([209.85.216.171]:42638 "EHLO
	mail-px0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076AbZJRHHc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 18 Oct 2009 03:07:32 -0400
Received: by pxi1 with SMTP id 1so486511pxi.33
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2009 00:07:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1255731495-27552-1-git-send-email-herton@mandriva.com.br>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Cc: linux-input@vger.kernel.org

Hi Herton,

On Fri, Oct 16, 2009 at 07:18:14PM -0300, Herton Ronaldo Krzesinski wrote:
> Positivo I30 doesn't send release key event for volume up/down/mute
> keys. The key list is the same as previous added Soltech TA12 quirk,
> so integrate this using same list.
> 

Thank you for the patch but starting with 2.6.32 there is a way to
adjust the force release bitmap from userspace (via sysfs attribute) so
I will not be accepting any more quirks for the kernel.

-- 
Dmitry
