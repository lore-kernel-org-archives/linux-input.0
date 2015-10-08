From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v8 0/9] Goodix touchscreen enhancements
Date: Thu, 08 Oct 2015 16:32:11 +0200
Message-ID: <53318623.Pp8rvnEWr4@wuerfel>
References: <1444314231-19206-1-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:53024 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753028AbbJHOcP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Oct 2015 10:32:15 -0400
In-Reply-To: <1444314231-19206-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Irina Tirdea <irina.tirdea@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Aleksei Mamlin <mamlinav@gmail.com>, linux-input@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Octavian Purdila <octavian.purdila@intel.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

On Thursday 08 October 2015 17:23:42 Irina Tirdea wrote:
> Add several enhancements to the Goodix touchscreen driver.
> 
> The new functionality is only available for devices that
> declare named gpio pins for interrupt and reset in their
> ACPI/DT configuration.
> 
> Thanks,
> Irina
> 
> Changes in v8:
>  - only allow new functionality for devices that declare named
> gpios (using _DSD properties in ACPI or named DT properties)
> 
> 

Looks much cleaner this way, thanks!

One remaining question: how would you handle the case where
the hardware doesn't support configuring the int-gpios line
as output but you still want to use the named gpios?

I assume you have that case covered, but I don't see it immediately.

	Arnd
