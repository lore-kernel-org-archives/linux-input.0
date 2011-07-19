From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH 22/25] sony-laptop: forward Hybrid GFX notifications to
 userspace
Date: Wed, 20 Jul 2011 06:50:35 +0900
Message-ID: <20110719215034.GC16532@kamineko.org>
References: <4DE8FC4A.9010401@absence.it>
 <4DE93584.3070205@absence.it>
 <20110604084820.GE7194@kamineko.org>
 <4DFFB7D2.3080400@absence.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:50461 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952Ab1GSVuH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Jul 2011 17:50:07 -0400
Content-Disposition: inline
In-Reply-To: <4DFFB7D2.3080400@absence.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marco Chiappero <marco@absence.it>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Mon, Jun 20, 2011 at 11:12:50PM +0200, Marco Chiappero wrote:
> Il 04/06/2011 10:48, Mattia Dongili ha scritto:
> >On Fri, Jun 03, 2011 at 09:27:00PM +0200, Marco Chiappero wrote:
> >>Some Vaios come with both integrated and discrete graphics, plus a
> >>switch for choosing one of the two. When the switch position is
> >>changed, a notification is generated, now forwarded to userspace for
> >>example for visual notifications, user scripts, and so on.
> 
> [...]
> 
> >>+		case 0x0128:
> >>+		case 0x0146:
> >>+			/* Hybrid GFX switching, 1 */
> >>+			sony_call_snc_handle(handle, 0x0000,&result);
> >>+			dprintk("sony_nc_notify, Hybrid GFX event received "
> >>+					"(reason: %s)\n", (result&  0x01) ?
> >>+					"switch position change" : "unknown");
> >>+
> >>+			/* verify the switch state
> >>+			   (1: discrete GFX, 0: integrated GFX)*/
> >>+			result = 0;
> >>+			sony_call_snc_handle(handle, 0x0100,&result);
> >>+
> >>+			ev = 5;
> >>+			value = result&  0xff;
> >>+			break;
> >
> >shouldn't this be reported as an input event rather than just an acpi
> >one?
> 
> If so, please someone let me know which keys to use.

the speed/stamina switch is not very useful at the moment as we can't do
anything with it anyway. There is probably no need to send the event to
userspace at all for now. Else a new switch event should be defined for
this.

-- 
mattia
:wq!
