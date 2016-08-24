From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 0/6] Intel Integrated Sensor Hub Support (ISH)
Date: Wed, 24 Aug 2016 22:23:42 +0100
Message-ID: <4ab0f3f3-43e3-f815-dd7b-9f6aa0bf6833@kernel.org>
References: <1466574038-20613-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <b81da639-0ec5-bb30-1f77-b71d8e7ad434@secretlab.ca>
 <CACxGe6v6pDisF9FpKPJrojGS7qUn13xUUd-Uydr7B1701Y4szg@mail.gmail.com>
 <alpine.LNX.2.00.1608242313540.22028@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1608242313540.22028@cbobk.fhfr.pm>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Grant Likely <glikely@secretlab.ca>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, benjamin.tissoires@redhat.com, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-iio@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On 24/08/16 22:14, Jiri Kosina wrote:
> On Wed, 24 Aug 2016, Grant Likely wrote:
> 
>>>> v2:
>>>> - Overview in documentation show analogy with usbhid implementation
>>>> - sparse errors for statics. Also pointed by Jiri
>>>> - Clearly marking exported function header file. Clean up all exports
>>>> unused inteface functions
>>>> - Changed to tristate from boolean as pointed by Jiri:
>>>> this required remove/unload functions
>>>> - Prevent crash when ISH enabled on non supported platform
>>>> - Break client.c to smaller part by seprating buffer allocations
>>>> - move bus register/unregister to ishtp module
>>>> - There is only one config symbol INTEL_ISH_HID, removed silent
>>>> config for TRANSPORT and IPC
>>>
>>> Tested-by: Grant Likely <grant.likely@secretlab.ca>
>>>
>>> On an HP Spectre x360 laptop using v4.7-rc5.
>>
>> Hey Srinivas. Any progress on this patch series?
> 
> The HID part (with patch #5 omitted) should be in linux-next through 
> hid.git already.
> 
The one IIO patch was pulled by Greg KH last night so hit linux next
today.  Hence all on it's way by the sound of it!

Jonathan
