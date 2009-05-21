From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: IS_INPUT_APPLICATION and tablets
Date: Thu, 21 May 2009 07:28:33 -0400
Message-ID: <4A153AE1.1020302@seas.upenn.edu>
References: <33210D89-9534-4B12-B7C3-E7FAEA3C4A5D@enac.fr> <alpine.LNX.2.00.0905211038350.13917@wotan.suse.de> <4A1514CE.6010600@seas.upenn.edu> <alpine.LNX.2.00.0905211105010.13917@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from LION.seas.upenn.edu ([158.130.12.194]:34802 "EHLO
	lion.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339AbZEUL2o (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 May 2009 07:28:44 -0400
In-Reply-To: <alpine.LNX.2.00.0905211105010.13917@wotan.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>, jirislaby@gmail.com, Greg KH <greg@kroah.com>, linux-input@vger.kernel.org

Jiri Kosina wrote:
> On Thu, 21 May 2009, Rafi Rubin wrote:
> 
>> Is there any downside to letting hiddev to cover all devices, even those 
>> that are supported by the hid system?
> 
> That's one of the possible solutions, yes. (we could either make that 
> behavior configurable, with default settings to always create hiddev 
> node, to preserve backwards compatibility with userspace).
> 

Those codes are descriptions, not unique identifiers.  It seems to me that sooner or later a conflict will arise over multiple
devices with the same code where the driver writers for devices have differing philosophies.

You could also leave a legacy version of IS_INPUT_APPLICATION with some old ranges for hiddev while letting hid-input use a version
which is free to expand.  But I think forking like that would be uglier than having hiddev nodes for all devices by default.

As for a configurable solution, there's always the style used by serio_raw.  Though, I think enabling hiddev shouldn't unbind the
normal hid-input driver.

Rafi
