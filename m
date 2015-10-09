From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v8 0/9] Goodix touchscreen enhancements
Date: Fri, 09 Oct 2015 16:27:18 +0200
Message-ID: <1444400838.28661.31.camel@hadess.net>
References: <1444314231-19206-1-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444314231-19206-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Irina Tirdea <irina.tirdea@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aleksei Mamlin <mamlinav@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-input@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Octavian Purdila <octavian.purdila@intel.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 2015-10-08 at 17:23 +0300, Irina Tirdea wrote:
> Add several enhancements to the Goodix touchscreen driver.
> 
> The new functionality is only available for devices that
> declare named gpio pins for interrupt and reset in their
> ACPI/DT configuration.


You can add

Tested-by: Bastien Nocera <hadess@hadess.net>

to the whole patchset. The features that don't work on my system
(broken GPIO configuration) don't actually cause problems, the
configuration dump doesn't appear, etc.

In the future, I should probably try and see _why_ it doesn't work (or
maybe the hardware maker didn't think it was necessary to flog their
cheap hardware).

Thanks a lot for your patience.

Cheers
