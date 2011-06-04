From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 8/25] sony-laptop: sony_nc_notify rewritten and improved
Date: Sat, 4 Jun 2011 13:42:19 +0100
Message-ID: <20110604124219.GA14809@srcf.ucam.org>
References: <4DE8FC4A.9010401@absence.it>
 <4DE8FFE0.5070506@absence.it>
 <20110604084338.GD7194@kamineko.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:55484 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753891Ab1FDMm3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 4 Jun 2011 08:42:29 -0400
Content-Disposition: inline
In-Reply-To: <20110604084338.GD7194@kamineko.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Marco Chiappero <marco@absence.it>, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Sat, Jun 04, 2011 at 05:43:39PM +0900, Mattia Dongili wrote:
> On Fri, Jun 03, 2011 at 05:38:08PM +0200, Marco Chiappero wrote:
> > sony_nc_notify rewritten (and placed near the other acpi callbacks),
> > the hotkey decoding code move to a new function
> > sony_nc_hotkeys_decode. Now generating acpi netlink events too.
> 
> one thing I'm wondering is if we shouldn't stop sending input
> events also via the acpi bus rather than adding new notification
> methods. The /proc/acpi/event notification will go away on its own one
> day so maybe letting this habit die with it is a reasonable deprecation
> plan for /proc/acpi/event users.

Yeah, it's about time for this to die.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
