From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCH v2] HID: multitouch: Fetch feature reports on demand for
 Win8 devices
Date: Wed, 7 Oct 2015 10:56:20 -0500
Message-ID: <20151007155620.GB118995@ubuntu-hedt>
References: <alpine.LNX.2.00.1510061606440.2758@pobox.suse.cz>
 <1444221223-33481-1-git-send-email-mika.westerberg@linux.intel.com>
 <20151007133409.GA25728@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151007133409.GA25728@mail.corp.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Duggan <aduggan@synaptics.com>
List-Id: linux-input@vger.kernel.org

On Wed, Oct 07, 2015 at 09:34:10AM -0400, Benjamin Tissoires wrote:
> [sorry for the late answer Jiri, I was on vacations last week]
> 
> On Oct 07 2015 or thereabouts, Mika Westerberg wrote:
> > Some newer Intel Skylake based Dell laptops with Win8 precision touchpad
> > fail when initial feature reports are fetched from it. Below is an example
> > output with some additional debug included:
> > 
> >  i2c_hid i2c-DLL0704:01: Fetching the HID descriptor
> >  i2c_hid i2c-DLL0704:01: __i2c_hid_command: cmd=20 00
> >  i2c_hid i2c-DLL0704:01: HID Descriptor: 1e 00 00 01 99 02 21 00 24 ...
> >  ...
> >  i2c_hid i2c-DLL0704:01: i2c_hid_get_report
> >  i2c_hid i2c-DLL0704:01: __i2c_hid_command: cmd=22 00 38 02 23 00
> >  i2c_hid i2c-DLL0704:01: report (len=4): 04 00 08 05
> >  i2c_hid i2c-DLL0704:01: report id 13
> >  i2c_hid i2c-DLL0704:01: i2c_hid_get_report
> >  i2c_hid i2c-DLL0704:01: __i2c_hid_command: cmd=22 00 3d 02 23 00
> >  i2c_hid i2c-DLL0704:01: failed to retrieve report from device.
> >  i2c_hid i2c-DLL0704:01: report id 7
> >  i2c_hid i2c-DLL0704:01: i2c_hid_get_report
> >  i2c_hid i2c-DLL0704:01: __i2c_hid_command: cmd=22 00 37 02 23 00
> >  i2c_hid i2c-DLL0704:01: report (len=259): 03 01 07 fc 28 fe 84 40 ...
> >  i2c_hid i2c-DLL0704:01: report id 4
> >  i2c_hid i2c-DLL0704:01: i2c_hid_get_report
> >  i2c_hid i2c-DLL0704:01: __i2c_hid_command: cmd=22 00 34 02 23 00
> > 
> > We manage to fetch few reports but then the touchpad dies:
> > 
> >  i2c_designware i2c_designware.1: i2c_dw_handle_tx_abort: lost arbitration
> >  i2c_hid i2c-DLL0704:01: failed to retrieve report from device.
> > 
> > it eventually pulls the whole I2C bus low:
> > 
> >  i2c_designware i2c_designware.1: controller timed out
> >  i2c_hid i2c-DLL0704:01: failed to set a report to device.
> > 
> > Fix this by preventing initial feature report retrieval for Win8 devices.
> > Instead we fetch reports as needed in mt_feature_mapping(). This prevents
> > fetching reports which might cause problems with the device in question.
> > 
> > Suggested-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> > Added check for MT_CLS_WIN_8 so that the fix is only done for real Win8
> > devices.
> 
> I think we are good now. I would just like to have Seth or Andrew giving 
> a tested-by for Windows precision touchpads that can be found on the Dell
> laptops.
> 
> If the buttonpad property is set correctly, this is:
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

This is working fine on my XPS 13 9343.

Tested-by: Seth Forshee <seth.forshee@canonical.com>
