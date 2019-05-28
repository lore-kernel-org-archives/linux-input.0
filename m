From: Jiri Kosina <jikos@kernel.org>
Subject: Re: hid-related 5.2-rc1 boot hang
Date: Tue, 28 May 2019 19:14:43 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1905281913140.1962@cbobk.fhfr.pm>
References: <2c1684f6-9def-93dc-54ab-888142fd5e71@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2c1684f6-9def-93dc-54ab-888142fd5e71@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Hansen <dave.hansen@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, 28 May 2019, Dave Hansen wrote:

> I have a system that works fine on 5.1.  When updating to 5.2-rc1, it
> hangs at boot waiting on an instance of systemd-udevd.  The kernel
> backtrace (https://photos.app.goo.gl/EV8rf7FofWouvdeE8) looks like it's
> doing an finit_module() that dives into the hid code and is waiting on a
> request_module().

Dave,

thanks for the report.

Just to confirm -- I guess reverting 4ceabaf79 and a025a18fe would work 
this around, right?

-- 
Jiri Kosina
SUSE Labs
