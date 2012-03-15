From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: Re: User space raw hid support
Date: Thu, 15 Mar 2012 17:06:14 -0300
Message-ID: <CAKT1EBfEtKXAcpZ7qz1Z3RSGXR-U8aTai=CuoZ45YHBHYNUqsw@mail.gmail.com>
References: <F0070FBC0FB3174D8D11444EB2D5B0260B44E9F3@DNCE02.ent.ti.com>
	<CANq1E4ScdbDCTBa4H-b-yEwOEnhrX4hKV-a3TxFaOJsyYiAurA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:40136 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161052Ab2COUGP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Mar 2012 16:06:15 -0400
Received: by vcqp1 with SMTP id p1so3532400vcq.19
        for <linux-input@vger.kernel.org>; Thu, 15 Mar 2012 13:06:14 -0700 (PDT)
In-Reply-To: <CANq1E4ScdbDCTBa4H-b-yEwOEnhrX4hKV-a3TxFaOJsyYiAurA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: "Ganir, Chen" <chen.ganir@ti.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi David/Chen:

On Wed, Mar 14, 2012 at 1:47 PM, David Herrmann
<dh.herrmann@googlemail.com> wrote:
> Hi Chen
>
> On Wed, Mar 14, 2012 at 12:47 PM, Ganir, Chen <chen.ganir@ti.com> wrote:
>> Hi all.
>>
>> I'm currently working on a HID Over GATT Implementation (HID over Bluetooth Low energy).
>>
>> As part of the design, it is required to configure the HID subsystem from user space, configure a report descriptor with input/output/feature report points, and send/receive data from and to the kernel HID Subsystem, from user space.
>>
>> Is there anything already supporting this feature ? I was looking at hid-raw, but it is used to send raw data from user space to the hid device - I need to send raw hid from the device to the kernel.
>
> What do you mean with that? hidraw uses the
> hid_input/output_raw_report() callbacks which HIDP/USBHID provide.
> They provide direct access to the HID channels. With the
> Bluetooth-backend you can directly write to the L2CAP channels. I
> don't understand what you mean with "device to the kernel".

HoG encapsulates HID reports using ATT protocol. The userspace needs
to transcode the data and send back to the kernel.
There isn't dynamic L2CAP channel allocation for Bluetooth Low Energy.
Only one fixed data channel is allowed, and more than one profile can
be exposed by the remote: services have a shared channel.

>
> Do you need something more low-level or more high-level? Currently,
> HIDP/USBHID provide the transport layer and register themselves with
> the HID core. The HID core parses the HID protocol and provides input
> devices on top of it. I don't understand where in-between of this you
> want the hooks to be?
>
>> Our basic idea was to develop a new misc char driver, at /dev/uhid. This device will be opened for each remote device we have access to, configured, and then read/write the raw HID packets from the device directly to this driver. We would like our solution to be a simple proxy between the device and the HID system, and we do not want to include a HID parser in our code, to make sure latency stays as low as possible.
>
> Does that mean you want to sit on top of the kernel HID parser or you
> don't want any parser in between? /dev/uhid looks like a HID-backend
> like HIDP/usbhid so hidraw seems to be perfect for this.

How does hidraw interfaces with the userspace?

BR,
Claudio
