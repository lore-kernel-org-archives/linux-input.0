From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 8/25] sony-laptop: sony_nc_notify rewritten and improved
Date: Sat, 4 Jun 2011 15:30:12 +0100
Message-ID: <20110604143012.GA16615@srcf.ucam.org>
References: <4DE8FC4A.9010401@absence.it>
 <4DE8FFE0.5070506@absence.it>
 <20110604084338.GD7194@kamineko.org>
 <20110604124219.GA14809@srcf.ucam.org>
 <4DEA3FBD.8020602@absence.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49301 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756465Ab1FDOaV (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 4 Jun 2011 10:30:21 -0400
Content-Disposition: inline
In-Reply-To: <4DEA3FBD.8020602@absence.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marco Chiappero <marco@absence.it>
Cc: Mattia Dongili <malattia@linux.it>, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Sat, Jun 04, 2011 at 04:22:53PM +0200, Marco Chiappero wrote:
> Il 04/06/2011 14:42, Matthew Garrett wrote:
> >>one thing I'm wondering is if we shouldn't stop sending input
> >>events also via the acpi bus rather than adding new notification
> >>methods. The /proc/acpi/event notification will go away on its own one
> >>day so maybe letting this habit die with it is a reasonable deprecation
> >>plan for /proc/acpi/event users.
> >
> >Yeah, it's about time for this to die.
> 
> Sorry, I don't understand what should be changed and the desired behavior:
> 1) no acpi notification at all, neither proc nor netlink (but we
> need some new entries in input.h first).
> 2) no acpi notification for hotkeys events only.
> 3) no acpi notification to the deprecated /proc/acpi/event only

No acpi notification at all. There's no good way for userspace to make 
use of them without knowing the hardware they're running on, which is 
far from ideal.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
