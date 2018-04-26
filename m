From: "Vittorio Gambaletta (VittGam)" <linuxbugs@vittgam.net>
Subject: Re: [PATCH v2] input/touchscreen: =?UTF-8?Q?atmel=5Fmxt=5Fts=3A?=
 =?UTF-8?Q?=20Add=20correct=20touchpad=20button=20mapping=20for=20the=20Ca?=
 =?UTF-8?Q?roline=20Chromebook=2E?=
Date: Thu, 26 Apr 2018 07:37:10 +0200
Message-ID: <ff623f6afb4e7910f3bb6d211f0f187f@vittgam.net>
References: <201804251232.w3PCWweA028076@mail.vittgam.net>
 <20180425222650.GC200812@dtor-ws> <20180425225734.GD200812@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180425225734.GD200812@dtor-ws>
Sender: stable-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org, nick@shmanahar.org, bleung@chromium.org, Salvatore Bellizzi <lkml@seppia.net>, groeck@chromium.org
List-Id: linux-input@vger.kernel.org

Hello,

On 26/04/2018 00:57:34 CEST, Dmitry Torokhov wrote:
> On Wed, Apr 25, 2018 at 03:26:50PM -0700, Dmitry Torokhov wrote:
>> On Wed, Apr 25, 2018 at 02:32:58PM +0200, Vittorio Gambaletta (VittGam) wrote:
>> > This patch adds the correct platform data information for the Caroline
>> > Chromebook, so that the mouse button does not get stuck in pressed state
>> > after the first click.
>> >
>> > The Samus button keymap and platform data definition are the correct
>> > ones for Caroline, so they have been reused here.
>> >
>> > v2: updated patch offset after 20180409 changes.
>> >
>> > Cc: stable@vger.kernel.org
>> > Signed-off-by: Vittorio Gambaletta <linuxbugs@vittgam.net>
>> > Signed-off-by: Salvatore Bellizzi <lkml@seppia.net>
>> >
>>
>> Applied, thank you.
>>
>> > ---
>> >
>> > --- a/drivers/input/touchscreen/atmel_mxt_ts.c
>> > +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
>> > @@ -3035,6 +3035,15 @@
>> >  		.driver_data = samus_platform_data,
>> >  	},
>> >  	{
>> > +		/* Samsung Chromebook Pro */
>> > +		.ident = "Samsung Chromebook Pro",
>> > +		.matches = {
>> > +			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
> 
> I've been alerted that shipping BIOS has vendor not capitalized; where
> did you get the firmware that has vendor all capitals?

Upstream coreboot and mrchromebox's coreboot, which do support loading Linux
natively or with UEFI, both use capitalized GOOGLE as DMI System Vendor
as far as I know.

By the way, the shipping BIOS (coreboot customized by Google) does not support
mainline Linux natively (eg. without seabios and nasty tricks), but only
Chromium OS, which for Caroline is an old 3.something fork of Linux, so this
patch does not really apply to Chromium OS or to Linux running on shipping BIOS.

Anyway if I recall correctly, the DMI System Vendor should be GOOGLE in
Google's coreboot for Caroline too, but I'm not 100% sure and cannot check
right now.

By the way please note that this is the DMI System Vendor and not the DMI
BIOS version string, which indeed starts with "Google_" in the shipping BIOS
(but not in coreboot, see f56db262e46d3368ee4e5c9e19797853cab382cd).

> Thanks.

Cheers,
Vittorio G

>> > +			DMI_MATCH(DMI_PRODUCT_NAME, "Caroline"),
>> > +		},
>> > +		.driver_data = samus_platform_data,
>> > +	},
>> > +	{
>> >  		/* Other Google Chromebooks */
>> >  		.ident = "Chromebook",
>> >  		.matches = {
>>
>> --
>> Dmitry
