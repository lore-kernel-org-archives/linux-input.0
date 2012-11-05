From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v2 11/11] HID: hid-multitouch: get rid of usbhid depedency
 for general path
Date: Mon, 5 Nov 2012 14:28:52 +0100
Message-ID: <CAN+gG=H1L6vwvxxAR6t2-Lz4aW0tbvLvDKvY-8f-M-qqm35mMw@mail.gmail.com>
References: <1351241067-9521-1-git-send-email-benjamin.tissoires@gmail.com>
	<1351241067-9521-12-git-send-email-benjamin.tissoires@gmail.com>
	<20121029225748.GA15632@polaris.bitmath.org>
	<CAN+gG=GNucfg4-wCBZQtz0yJDjpTD_56Js3d68nm8VFi1UhZAA@mail.gmail.com>
	<20121105125731.GA814@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121105125731.GA814@polaris.bitmath.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Henrik,

On Mon, Nov 5, 2012 at 1:57 PM, Henrik Rydberg <rydberg@euromail.se> wrote:
> Hi Benjamin,
>
>> >> This patch factorizes the hid set_feature command by using
>> >> hid_device->hid_output_raw_report instead of direclty relying on
>> >> usbhid. This makes the driver usb independant.
>> >>
>> >> However I still can't remove the 2 usb related headers because the
>> >> function mt_resume has a specific patch for usb devices.
>> >>
>> >> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
>> >> ---
>> >>  drivers/hid/hid-multitouch.c | 63 ++++++++++++++++++++++++++------------------
>> >>  1 file changed, 37 insertions(+), 26 deletions(-)
>> >
>> > In my drawer, I have a patchset that aims to remove all usbhid
>> > dependence, from all the drivers. Perhaps the attached patch is
>> > something to consider here?
>>
>> yep, removing usbhid dependencies is a good thing.
>> See my review below :)
>
> I have a tentative patch taking your comments into account, and it is
> likely that we want to go that way. However, as to not hold up your
> patchset, perhaps we could do without it for now.
>
> Regarding the hardwired usbhid dependency, I think the solution is to
> move that code to usbhid itself.
>
> Thanks,
> Henrik
