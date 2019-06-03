From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: hid-related 5.2-rc1 boot hang
Date: Mon, 3 Jun 2019 11:32:11 +0200
Message-ID: <e602db44-c792-1abe-e389-a71fca6d2ddd@redhat.com>
References: <2c1684f6-9def-93dc-54ab-888142fd5e71@intel.com>
 <nycvar.YFH.7.76.1905281913140.1962@cbobk.fhfr.pm>
 <CAO-hwJJzNAuFbdMVFZ4+h7J=bh6QHr_MioyK2yTV=M5R6CTm=A@mail.gmail.com>
 <8a17e6e2-b468-28fd-5b40-0c258ca7efa9@intel.com>
 <4689a737-6c40-b4ae-cc38-5df60318adce@redhat.com>
 <a349dfac-be58-93bd-e44c-080ed935ab06@intel.com>
 <nycvar.YFH.7.76.1906010014150.1962@cbobk.fhfr.pm>
 <e158d983-1e7e-4c49-aaab-ff2092d36438@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e158d983-1e7e-4c49-aaab-ff2092d36438@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Dave Hansen <dave.hansen@intel.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi,

On 03-06-19 11:11, Hans de Goede wrote:
> Hi,
> 
> On 01-06-19 00:15, Jiri Kosina wrote:
>> On Thu, 30 May 2019, Dave Hansen wrote:
>>
>>> On 5/29/19 2:17 AM, Hans de Goede wrote:
>>> ...
>>>> Dave, can you try building your initrd without the hid-logitech-dj module
>>>> included in the initrd?
>>>
>>> I did this on a vanilla 5.2-rc2 kernel (without the reverts) and still
>>> experienced the boot hang while the device was inserted.
>>>
>>>> Also can you check if your modprobe is provided by module-init-tools
>>>> or by kmod ?
>>>
>>> $ dpkg -S `which modprobe`
>>> kmod: /sbin/modprobe
>>
>> Benjamin, Hans, are you looking into this?
> 
> Not really, I cannot reproduce the request_module problem. I was hoping some
> of the info from Dave would help to pinpoint it, but it does not :|
> 
>> If not, I think we should start reverting (at least the request_module()
>> changes
> 
> I agree we need to do something about the request_module changes.
> 
> I myself was thinking about somehow making them conditional, e.g. we
> could add a (temporary) module option defaulting to false for this
> while we investigate further.
> 
> I'm afraid that if we just revert we will never find the root cause and then
> we will be stuck with the suboptimal behavior of first the generic hid driver
> binding followed by a unbind + bind of the new driver shortly afterwards,
> which also leads to a ton of udev events being fired to userspace (well I
> guess this does make for a good stress test of the userspace hotplug code).

Quick update, we have another report of module-loading related problems
which are likely related:

https://bugzilla.kernel.org/show_bug.cgi?id=203741

In this case there is no hang, instead there is a 1 to 3 minute delay.

Regards,

Hans
