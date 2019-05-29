From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: hid-related 5.2-rc1 boot hang
Date: Wed, 29 May 2019 11:17:51 +0200
Message-ID: <4689a737-6c40-b4ae-cc38-5df60318adce@redhat.com>
References: <2c1684f6-9def-93dc-54ab-888142fd5e71@intel.com>
 <nycvar.YFH.7.76.1905281913140.1962@cbobk.fhfr.pm>
 <CAO-hwJJzNAuFbdMVFZ4+h7J=bh6QHr_MioyK2yTV=M5R6CTm=A@mail.gmail.com>
 <8a17e6e2-b468-28fd-5b40-0c258ca7efa9@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8a17e6e2-b468-28fd-5b40-0c258ca7efa9@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Hansen <dave.hansen@intel.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi,

On 5/28/19 8:11 PM, Dave Hansen wrote:
> On 5/28/19 10:45 AM, Benjamin Tissoires wrote:
>> On Tue, May 28, 2019 at 7:15 PM Jiri Kosina <jikos@kernel.org> wrote:
>>> Just to confirm -- I guess reverting 4ceabaf79 and a025a18fe would work
>>> this around, right?
> 
> Yes, reverting that pair on top of 5.2-rc1 works around the issue.

Thank you for catching this and for testing the reverts. We've several bug
reports which I suspect are related to this.

/sbin/modprobe really should not hang when called by the kernel, as the
kernel does this in several other places too.

At the same time this clearly is a regression, so I'm afraid we will need
to revert the 2 commits.

Benjamin, Jiri, I really like the improvements these 2 commits bring
combined with Benjamin's changes removing the need for all the device specific
drivers to have  HID_QUIRK_HAVE_SPECIAL_DRIVER quirk.

Maybe instead of reverting them, we wrap them in a Kconfig option, which
defaults to N, with a warning that this requires an userspace where
/sbin/modprobe does not hang ?  It would be useful for the Kconfig
help text if we knew why it hangs. I guess this may have something to do
with it running from the initrd? Maybe this is not the real modprobe but
busybox's modprobe?

Dave, can you try building your initrd without the hid-logitech-dj module
included in the initrd?


Also can you check if your modprobe is provided by module-init-tools
or by kmod ?

I believe we really need more information before we can properly decide
how to deal with this. Luckily we still have same time.

Regards,

Hans
