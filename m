From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [PATCH] HID: add IRTOUCH infrared USB to hid_have_special_driver
Date: Wed, 16 Feb 2011 10:54:24 +0100
Message-ID: <AANLkTi=QF-9QtGK8V795R9ZO4-c6sQ8MSTW+JMxwd2+d@mail.gmail.com>
References: <1297780428-3805-1-git-send-email-benjamin.tissoires@enac.fr>
	<alpine.LNX.2.00.1102160003420.2160@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1102160003420.2160@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Jiri,

Thanks for applying those two patches.
BTW I'm a little worried: apparently you applied this patch in the
branch upstream-fixes but you didn't applied "HID: hid-multitouch:
introduce IrTouch Infrared USB..." and it's parents in this branch....
I'm afraid this will broke compilation of the upstream branch
(USB_VENDOR_ID_IRTOUCHSYSTEMS and USB_DEVICE_ID_IRTOUCH_INFRARED_USB
are not defined).

Thanks,
Benjamin

On Wed, Feb 16, 2011 at 00:04, Jiri Kosina <jkosina@suse.cz> wrote:
> On Tue, 15 Feb 2011, Benjamin Tissoires wrote:
>
>> Without this patch, the device is handled by hidinput and does
>> not have the right behavior.
>>
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
>> ---
>> Hi guys,
>>
>> In the previous patch including the support to IRTOUCH devices, I forgot
>> to add it to hid_have_special_driver. Sorry.
>
> Hmm, this happens quite often to people submitting patches, but I normally
> catch it. This time my eyes have failed.
>
> Thanks for the fix, applied.
>
> --
> Jiri Kosina
> SUSE Labs, Novell Inc.
>
