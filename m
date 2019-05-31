From: Jiri Kosina <jikos@kernel.org>
Subject: Re: hid-related 5.2-rc1 boot hang
Date: Sat, 1 Jun 2019 00:15:48 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1906010014150.1962@cbobk.fhfr.pm>
References: <2c1684f6-9def-93dc-54ab-888142fd5e71@intel.com> <nycvar.YFH.7.76.1905281913140.1962@cbobk.fhfr.pm> <CAO-hwJJzNAuFbdMVFZ4+h7J=bh6QHr_MioyK2yTV=M5R6CTm=A@mail.gmail.com> <8a17e6e2-b468-28fd-5b40-0c258ca7efa9@intel.com> <4689a737-6c40-b4ae-cc38-5df60318adce@redhat.com>
 <a349dfac-be58-93bd-e44c-080ed935ab06@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a349dfac-be58-93bd-e44c-080ed935ab06@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Hansen <dave.hansen@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, 30 May 2019, Dave Hansen wrote:

> On 5/29/19 2:17 AM, Hans de Goede wrote:
> ...
> > Dave, can you try building your initrd without the hid-logitech-dj module
> > included in the initrd?
> 
> I did this on a vanilla 5.2-rc2 kernel (without the reverts) and still
> experienced the boot hang while the device was inserted.
> 
> > Also can you check if your modprobe is provided by module-init-tools
> > or by kmod ?
> 
> $ dpkg -S `which modprobe`
> kmod: /sbin/modprobe

Benjamin, Hans, are you looking into this?

If not, I think we should start reverting (at least the request_module() 
changes, not sure about the rest of logitech issues yet) next week.

Thanks,

-- 
Jiri Kosina
SUSE Labs
