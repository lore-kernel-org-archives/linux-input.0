From: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Subject: Re: [PATCH] HID: sony: disable descriptor fixup for FutureMax Dance
 Mat
Date: Mon, 25 Jul 2016 18:23:07 +0300
Message-ID: <0888e980-5511-af8f-bd00-e94916cb6356@kapsi.fi>
References: <20160717172533.8777-1-mikko.perttunen@kapsi.fi>
 <20160718142837.GK4663@mail.corp.redhat.com>
 <78cafd15-850f-3110-f63e-bb41f6b69c5c@kapsi.fi>
 <20160721183439.3edddbc6312555afda517f8c@ao2.it>
 <20160725091404.GD19383@mail.corp.redhat.com>
 <20160725130547.6c9b80c23fef6dfe50ad9979@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:38184 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752867AbcGYPXM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jul 2016 11:23:12 -0400
In-Reply-To: <20160725130547.6c9b80c23fef6dfe50ad9979@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ao2@ao2.it>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: jikos@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>

On 07/25/16 14:05, Antonio Ospite wrote:
> On Mon, 25 Jul 2016 11:14:04 +0200
> Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:
>
>> On Jul 21 2016 or thereabouts, Antonio Ospite wrote:
> [...]
>>> It would be interesting to understand why some (supposedly) compatible
>>> devices break, maybe they rely on the fact that the PS3 would use the
>>> original report?
>>
>> [just speculating]
>> I would be *really* surprised if the Sony software were to overwrite the
>> report descriptor of their own sony controllers. My guess is that their
>> HID stack or their Playstation driver is compatible with the original
>> report descriptors and so they can handle the differences between
>> original and weirdo controllers.
>>
>
> That's basically what I was thinking too, in my last sentence I meant
> to write report _descriptor_ :)
>
> Mikko, if you have some time, could you post the original report
> descriptor for your device?

Sure, here's the output from hidrd-convert:

0x05, 0x01, /*  Usage Page (Desktop),               */
0x09, 0x04, /*  Usage (Joystick),                   */
0xA1, 0x01, /*  Collection (Application),           */
0x09, 0x01, /*      Usage (Pointer),                */
0xA1, 0x00, /*      Collection (Physical),          */
0x05, 0x09, /*          Usage Page (Button),        */
0x19, 0x01, /*          Usage Minimum (01h),        */
0x29, 0x0A, /*          Usage Maximum (0Ah),        */
0x15, 0x00, /*          Logical Minimum (0),        */
0x25, 0x01, /*          Logical Maximum (1),        */
0x75, 0x01, /*          Report Size (1),            */
0x95, 0x0A, /*          Report Count (10),          */
0x81, 0x02, /*          Input (Variable),           */
0x95, 0x06, /*          Report Count (6),           */
0x81, 0x03, /*          Input (Constant, Variable), */
0xC0,       /*      End Collection,                 */
0x15, 0x00, /*      Logical Minimum (0),            */
0x15, 0x00, /*      Logical Minimum (0),            */
0x15, 0x00, /*      Logical Minimum (0),            */
0x15, 0x00, /*      Logical Minimum (0),            */
0x15, 0x00, /*      Logical Minimum (0),            */
0x15, 0x00, /*      Logical Minimum (0),            */
0x15, 0x00, /*      Logical Minimum (0),            */
0x15, 0x00, /*      Logical Minimum (0),            */
0x15, 0x00, /*      Logical Minimum (0),            */
0x15, 0x00, /*      Logical Minimum (0),            */
0x15, 0x00, /*      Logical Minimum (0),            */
0x15, 0x00, /*      Logical Minimum (0),            */
0x15, 0x00, /*      Logical Minimum (0),            */
0x15, 0x00, /*      Logical Minimum (0),            */
0x15, 0x00, /*      Logical Minimum (0),            */
0x15, 0x00, /*      Logical Minimum (0),            */
0x15, 0x00, /*      Logical Minimum (0),            */
0x15, 0x00, /*      Logical Minimum (0),            */
0x15, 0x00, /*      Logical Minimum (0),            */
0x15, 0x00, /*      Logical Minimum (0),            */
0x15, 0x00, /*      Logical Minimum (0),            */
0x15, 0x00, /*      Logical Minimum (0),            */
0x15, 0x00, /*      Logical Minimum (0),            */
0x15, 0x00, /*      Logical Minimum (0),            */
0x15, 0x00, /*      Logical Minimum (0),            */
0x15, 0x00, /*      Logical Minimum (0),            */
0x15, 0x00, /*      Logical Minimum (0),            */
0x15, 0x00, /*      Logical Minimum (0),            */
0x15, 0x00, /*      Logical Minimum (0),            */
0x15, 0x00, /*      Logical Minimum (0),            */
0x15, 0x00, /*      Logical Minimum (0),            */
0x15, 0x00, /*      Logical Minimum (0),            */
0x15, 0x00, /*      Logical Minimum (0),            */
0x15, 0x00, /*      Logical Minimum (0),            */
0x15, 0x00, /*      Logical Minimum (0),            */
0x15, 0x00, /*      Logical Minimum (0),            */
0x25, 0x01, /*      Logical Maximum (1),            */
0x25, 0x01, /*      Logical Maximum (1),            */
0x25, 0x01, /*      Logical Maximum (1),            */
0xC0        /*  End Collection                      */


>
> $ hexdump /sys/bus/hid/devices/XXXX\:YYYY\:ZZZZ.0001/report_descriptor
>
> or
>
> $ hidrd-convert -i natv -o code /sys/bus/hid/devices/XXXX\:YYYY\:ZZZZ.0001/report_descriptor
>
> You can also find out the length of the raw output report with trial and
> error, start with a line like this:
>
> $ sudo hexdump -v -e '49/1 "%02x " "\n"' /dev/hidraw0
>
> and increase/decrease the value (49 works with original controllers)
> until you see a regular pattern when comparing lines.
>

/dev/hidraw0 seems to be all zeroes straight from the beginning

> Anyways this is just for curiosity, we are not going to spend too much
> time on that... or are we? :)

At least it's some reference information.. :)

>
> Thanks,
>    Antonio
>

Cheers,
Mikko.

