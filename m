From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v2] HID: i2c-hid: add ACPI support
Date: Thu, 17 Jan 2013 16:52:55 -0500
Message-ID: <CAN+gG=GBYbCxrOKk2S1n9K2e68Rbxvt4CuoV40NJiE9LDNR=Zw@mail.gmail.com>
References: <1357742588-11366-1-git-send-email-mika.westerberg@linux.intel.com>
	<CAN+gG=GrrEdgrCLXvO=xJ6SNeKgHFRobq6RSAfLMfesKkJcijA@mail.gmail.com>
	<alpine.LNX.2.00.1301091551580.12134@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1301091551580.12134@pobox.suse.cz>
Sender: linux-acpi-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-input@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Jan 9, 2013 at 9:52 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Wed, 9 Jan 2013, Benjamin Tissoires wrote:
>
>> <mika.westerberg@linux.intel.com> wrote:
>> > The HID over I2C protocol specification states that when the device is
>> > enumerated from ACPI the HID descriptor address can be obtained by
>> > executing "_DSM" for the device with function 1. Enable this.
>> >
>> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>>
>> I'm eager to test it (hopefully next week).
>>
>> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>
> Perfect. I will wait for your Tested-by: as well before applying to public
> git tree.

Hi Jiri,

well, we tried yesterday to make all those things working, but the
Haswell platform I was able to have access was not very cooperative.
So I wasn't able to test the whole autodetection mechanism through
ACPI (I even not managed to communicate with the various HID over i2c
devices that were available to test).

However, Mika managed to test this ACPI stuff, and he is able to
retrieve the HID descriptor address. Given that, I think it's safe to
include it right now. There will still be the last point with the
gpios, but it will come when someone get access to a device presenting
this feature.

Cheers,
Benjamin

>
> Thanks to both of you,
>
> --
> Jiri Kosina
> SUSE Labs
