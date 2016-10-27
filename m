From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v12 0/5] Goodix touchscreen enhancements
Date: Thu, 27 Oct 2016 15:44:07 +0200
Message-ID: <1477575847.2458.18.camel@hadess.net>
References: <1473530257-7495-1-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:33730 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964923AbcJ0OG5 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 27 Oct 2016 10:06:57 -0400
In-Reply-To: <1473530257-7495-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Irina Tirdea <irina.tirdea@intel.com>, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aleksei Mamlin <mamlinav@gmail.com>, Karsten Merker <merker@debian.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Octavian Purdila <octavian.purdila@intel.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

On Sat, 2016-09-10 at 20:57 +0300, Irina Tirdea wrote:
> This is an update for a previous set of patches [1] with enhancements
> for the Goodix touchscreens. The first 3 patches are leftovers from
> the previous patchset (with minor changes due to rebase), while the
> last 2 patches are new.
> 
> Thanks,
> Irina
> 
> [1] https://lkml.org/lkml/2015/11/19/241
> 
> Changes in v12:
>  - add documentation for configuration firmware update
>  - minor changes due to rebase
>  - add 2 new patches to fix reset sequence and add support for gt9157
> 
> Previous changes:
>   https://lkml.org/lkml/2015/11/19/241
> 
> Irina Tirdea (5):
>   Input: goodix - add sysfs interface to dump config
>   Input: goodix - add support for ESD
>   Input: goodix - add runtime power management support

I tested those 3 patches in their v11, but my test tablet's software is
currently broken. Until I find the time to regenerate install images,
I'll just do code reviews.

I assume the first 3 patches don't break anything on the device I
tested this on, but I'd like to make sure it was at least tested on
ACPI-based systems.

Can you mention somewhere on which devices those patches were tested?

Cheers

>   Input: goodix - fix reset sequence
>   Input: goodix - add support for gt9157
> 
>  .../bindings/input/touchscreen/goodix.txt          |   5 +
>  Documentation/input/goodix.txt                     |  84 +++++
>  drivers/input/touchscreen/goodix.c                 | 346
> +++++++++++++++++++--
>  3 files changed, 415 insertions(+), 20 deletions(-)
>  create mode 100644 Documentation/input/goodix.txt
> 
