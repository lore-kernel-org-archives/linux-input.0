From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH v3] i2c-hid: introduce HID over i2c specification
 implementation
Date: Mon, 19 Nov 2012 11:06:49 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1211191106020.20577@pobox.suse.cz>
References: <1352731379-24683-1-git-send-email-benjamin.tissoires@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1352731379-24683-1-git-send-email-benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephane Chatty <chatty-rXV5z7KbLFk@public.gmane.org>, fabien.andre-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, scott.liu-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, JJ Ding <jj_ding-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, 12 Nov 2012, Benjamin Tissoires wrote:

> Microsoft published the protocol specification of HID over i2c:
> http://msdn.microsoft.com/en-us/library/windows/hardware/hh852380.aspx
> 
> This patch introduces an implementation of this protocol.
> 
> This implementation does not includes the ACPI part of the specification.
> This will come when ACPI 5.0 devices enumeration will be available.
> 
> Once the ACPI part is done, OEM will not have to declare HID over I2C
> devices in their platform specific driver.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> 
> Hi Guys,
> 
> here is the v3 of the HID over I2C driver.
> 
> Changes in v3:
> * fix i2c_hid_alloc_buffers when allocation failed
> * fix error messages to be more "human"
> * fix i2c_hid_set_report as it didn't followed the protocol
> * remove i2c_hid_write_out_report (hid-core doesn't present the callback that
> could use this feature of the protocol)
> * reject HID_OUTPUT_REPORT in i2c_hid_get_raw_report
> * fix output report id in i2c_hid_output_raw_report and reject HID_INPUT_REPORT

Benjamin,

I am now queuing this in for-3.8/i2c-hid branch, so please send any 
potential followup patches on top of that.

Thanks a lot for all your work on this so far.

-- 
Jiri Kosina
SUSE Labs
