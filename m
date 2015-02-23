From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 3/7] thinkpad_acpi: Add adaptive_kbd_mode sysfs attr
Date: Mon, 23 Feb 2015 07:28:32 -0300
Message-ID: <1424687312.3036311.231116905.5FB7021B@webmail.messagingengine.com>
References: <1424443462.22910.15.camel@hadess.net>
 <20150220152032.GB1508@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:35377 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752654AbbBWK2d (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Feb 2015 05:28:33 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 1BA8720995
	for <linux-input@vger.kernel.org>; Mon, 23 Feb 2015 05:28:32 -0500 (EST)
In-Reply-To: <20150220152032.GB1508@lahna.fi.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Bastien Nocera <hadess@hadess.net>
Cc: Darren Hart <dvhart@infradead.org>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On Fri, Feb 20, 2015, at 12:20, Mika Westerberg wrote:
> On Fri, Feb 20, 2015 at 03:44:22PM +0100, Bastien Nocera wrote:
> > Add a sysfs attribute to allow privileged users to change the keyboard
> > mode. This could be used by desktop environments to change the keyboard
> > mode depending on the application focused, as the Windows application
> > does.
> 
> If you are adding new sysfs attributes, you should document them as well
> in Documentation/ABI/*.

The thinkpad-acpi driver has its own documentation, it is in
Documentation/laptops/thinkpad-acpi.txt.

The new adaptative keyboard stuff has to be added to it, please.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
