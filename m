From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v2 0/9] Support of Nexio 42" and new default class for hid-multitouch
Date: Wed, 6 Feb 2013 12:04:34 +0100
Message-ID: <CAN+gG=F5KHmq2F_op6RbvXiSp=T0oD_cTgPuBHptXVHyHZwpjA@mail.gmail.com>
References: <1359649351-11092-1-git-send-email-benjamin.tissoires@gmail.com>
	<20130203130731.GA2677@polaris.bitmath.org>
	<CAN+gG=GRS+fx4c3Kdba-89+ba8soimMm_rv7HDuaZLZWseQGuQ@mail.gmail.com>
	<20130204115443.GA4405@polaris.bitmath.org>
	<alpine.LNX.2.00.1302051212550.2260@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1302051212550.2260@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Feb 5, 2013 at 12:13 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Mon, 4 Feb 2013, Henrik Rydberg wrote:
>
>> > Thanks for the review. However, before sending a new patch series, I'd
>> > like to have your answers to my comments as I mostly disagree on
>> > everything :)
>>
>> With good reason, apparently. :-) I see no major problem with your
>> patches, although the discussed details show that there is room for
>> some refactoring.
>
> Thanks to both of you. As I don't object to the HID core change, I have
> now applied the patchset, so please send any further additions on top of
> for-3.9/multitouch branch of my tree.

Ok. Thanks Jiri. I will send the patch in a minute.

>
> Also, Benjamin, perhaps it'd make sense to put a link somewhere into
> in-tree documentation, with pointer to your testing suite?

Good idea. However, I prefer removing the dependencies between hid
drivers and usbhid before including such reference to avoid testers
getting kernel oops while trying to access the usb layer from the uhid
device... So, yesterday and this morning, I rebased/updated Henrik's
patches on this topic. They should be ready soon.

Do you mind if I send the usbhid dependency and the pen+multitouch
series this week, or we are too close to the 3.9 opening window?

Cheers,
Benjamin
