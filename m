From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: Use platform-provided devices as i8042 serio
 parents
Date: Fri, 7 Mar 2014 09:54:16 -0800
Message-ID: <20140307175415.GB25283@core.coreip.homeip.net>
References: <1393174996-27764-1-git-send-email-matthew.garrett@nebula.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:49023 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbaCGRyU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Mar 2014 12:54:20 -0500
Content-Disposition: inline
In-Reply-To: <1393174996-27764-1-git-send-email-matthew.garrett@nebula.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <matthew.garrett@nebula.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com

Hi Matthew,

On Sun, Feb 23, 2014 at 12:03:16PM -0500, Matthew Garrett wrote:
> i8042 devices exposed via platform firmware interfaces such as ACPI or
> Device Tree may provide additional information of use to userspace. Right
> now we don't associate the serio devices with the firmware device, and so
> there's no straightforward way for userspace to make use of that
> information. This patch simply moves the serio parent device to the firmware
> provided device.

Hmm, are we sure it will not mess up power management now that children
serio ports are disconnected from i8042 device?

I also wonder if we need to restructure the whole thing so that we
create AUX and KBD ports separately and convert i8042 code into a
library of sorts...

Thanks.

-- 
Dmitry
