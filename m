From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 3/7] thinkpad_acpi: Add adaptive_kbd_mode sysfs attr
Date: Fri, 20 Feb 2015 17:20:32 +0200
Message-ID: <20150220152032.GB1508@lahna.fi.intel.com>
References: <1424443462.22910.15.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1424443462.22910.15.camel@hadess.net>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Darren Hart <dvhart@infradead.org>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org

On Fri, Feb 20, 2015 at 03:44:22PM +0100, Bastien Nocera wrote:
> Add a sysfs attribute to allow privileged users to change the keyboard
> mode. This could be used by desktop environments to change the keyboard
> mode depending on the application focused, as the Windows application
> does.

If you are adding new sysfs attributes, you should document them as well
in Documentation/ABI/*.
