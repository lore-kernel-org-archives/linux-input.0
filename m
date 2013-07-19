From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] HID: multitouch: do not init reports for multitouch devices
Date: Fri, 19 Jul 2013 10:47:05 +0200
Message-ID: <CAN+gG=G6jw0BkJejZ=Rb+Vzzey1=JdqiiYmMonwjt9G1R779Tg@mail.gmail.com>
References: <1373620101-16113-1-git-send-email-benjamin.tissoires@redhat.com>
	<20130718192416.GA526@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130718192416.GA526@polaris.bitmath.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Henrik,

On Thu, Jul 18, 2013 at 9:24 PM,  <rydberg@euromail.se> wrote:
> Hi Benjamin,
>
>> Some multitouch screens do not like to be polled for input reports.
>> However, the Win8 spec says that all touches should be sent during
>> each report, making the initialization of reports unnecessary.
>> The Win7 spec is less precise, but we can safely assume that when
>> the module is loaded (at boot), no one is touching the screen.
>>
>> Add the quirk HID_QUIRK_NO_INIT_REPORTS so that we do not have to
>> introduce a quirk for each problematic device.
>
> I assume you have tested thoroughly for regressions? How about odd
> eGalax devices, for instance? Changes affecting existing hardware
> makes me nervous. Is it so bad to add this quirk on a per-device
> basis? Or perhaps turned on by default for win8 devices only?

Aargh, I forgot the eGalax... (I don't have it anymore on my desk). I
was pretty confident because Win [7-8] is not doing any quirks for the
multitouch devices, and I had in mind that it did not asked for the
reports at startup (at least, I am sure about it for HID/I2C). I'm not
sure win 8 devices is a sufficient denominator, because this init
sequence is not mentioned anywhere in the Win 8 spec. It's true that
we are going to see fewer Win 7 devices, but I would say it's the
exact same problem for win 7 and 8. Moreover, asking this for Win 8
devices only will forces us to detect it in core before hid-multitouch
is loaded because the init reports is called before the parsing.

If I capture the Win 7 & Win 8 initialization events and I observe
that they do not retrieve the reports, will it be sufficient as a
guarantee to include this patch even if it is not widely tested under
Linux?

Cheers,
Benjamin
