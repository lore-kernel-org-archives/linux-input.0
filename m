From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [Bugme-new] [Bug 12340] New: [regression] USB keyboard no longer
 recognised
Date: Mon, 5 Jan 2009 10:13:51 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0901051011490.5377@jikos.suse.cz>
References: <bug-12340-10286@http.bugzilla.kernel.org/> <20090101011223.6a10dd66.akpm@linux-foundation.org> <495C8AE3.5000502@freemail.hu> <alpine.LRH.1.10.0901041151510.2418@twin.jikos.cz> <4960A5E2.2050601@freemail.hu> <4961B734.80701@freemail.hu>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="336216065-355684867-1231146831=:5377"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:42018 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751890AbZAEJNy (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 5 Jan 2009 04:13:54 -0500
In-Reply-To: <4961B734.80701@freemail.hu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, bugme-daemon@bugzilla.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--336216065-355684867-1231146831=:5377
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Mon, 5 Jan 2009, Németh Márton wrote:

> > The modules were not autoloaded. This is a minimal test environment 
> > with only a few binaries in the root directory. Is the "modprobe" 
> > binary enough for autoloading?
> I just was able to try the situation: the modules are not autoloaded.

Does autoloading of other modules work well in the limited environment you 
have? I suspect this might be something with your special configuration 
(udev not triggering properly, etc.) rather than kernel problem.

> >> Anyway, in 2.6.28, this keyboard is driven by specialized 'hid-bright' 
> >> driver. Does modprobing it by hand fix the problem?
> > I'll try the hid-bright module as soon as my laptop gets repaired.
> Loading the hid-bright module handles the USB keyboard properly.

Thanks for verifying.

-- 
Jiri Kosina
SUSE Labs
--336216065-355684867-1231146831=:5377--
