From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 3/7] thinkpad_acpi: Add adaptive_kbd_mode sysfs attr
Date: Fri, 20 Feb 2015 16:22:07 +0100
Message-ID: <1424445727.22910.20.camel@hadess.net>
References: <1424443462.22910.15.camel@hadess.net>
	 <20150220152032.GB1508@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:43746 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754369AbbBTPXh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Feb 2015 10:23:37 -0500
In-Reply-To: <20150220152032.GB1508@lahna.fi.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Darren Hart <dvhart@infradead.org>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On Fri, 2015-02-20 at 17:20 +0200, Mika Westerberg wrote:
> On Fri, Feb 20, 2015 at 03:44:22PM +0100, Bastien Nocera wrote:
> > Add a sysfs attribute to allow privileged users to change the keyboard
> > mode. This could be used by desktop environments to change the keyboard
> > mode depending on the application focused, as the Windows application
> > does.
> 
> If you are adding new sysfs attributes, you should document them as well
> in Documentation/ABI/*.

None of the thinkpad_acpi sysfs attributes are documented there, or I'm
missing something obvious.

