From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v7 0/9] Goodix touchscreen enhancements
Date: Thu, 08 Oct 2015 13:09:32 +0200
Message-ID: <5148493.XbtXJjEe71@wuerfel>
References: <1444299575-17417-1-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:56527 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932268AbbJHLJl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Oct 2015 07:09:41 -0400
In-Reply-To: <1444299575-17417-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Irina Tirdea <irina.tirdea@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Aleksei Mamlin <mamlinav@gmail.com>, linux-input@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Octavian Purdila <octavian.purdila@intel.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

On Thursday 08 October 2015 13:19:26 Irina Tirdea wrote:
> Add several enhancements to the Goodix touchscreen driver.
> 
> Bastien, the functionality from this patches should be now skipped
> for your devices (Onda v975w, WinBook TW100 and WinBook TW700).
> 
> Aleksei, I have removed your Tested-by tag since I have done some
> non-trivial changes to the "reset device at init" patch.
> 
> 

I've read over all 9 patches now, most of them look good, but I
commented on the one that I have concerns about.

	Arnd
