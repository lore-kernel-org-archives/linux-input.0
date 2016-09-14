From: Dennis Wassenberg <dennis.wassenberg@secunet.com>
Subject: Re: [PATCH 1/4] hda: Rename fixup thinkpad_acpi to fixup_thinkpad
Date: Wed, 14 Sep 2016 08:25:45 +0200
Message-ID: <ba554fdf-6b68-2cef-58e3-6a2eb5242c50@secunet.com>
References: <5cb009b2-11a0-fb19-e751-965a874903b0@secunet.com>
 <s5htwdli9q7.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-sound-owner@vger.kernel.org>
In-Reply-To: <s5htwdli9q7.wl-tiwai@suse.de>
Sender: linux-sound-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-input@vger.kernel.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, lukas@wunner.de, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, perex@perex.cz, david.henningsson@canonical.com, vinod.koul@intel.com, hui.wang@canonical.com, rafael.j.wysocki@intel.com, jikos@kernel.org
List-Id: linux-input@vger.kernel.org

Hi Takashi,

ok, I will do so and prepare a v2 of "[PATCH 4/4] hda: thinkpad_helper:
Add support for hid-lenovo LED control" which is affected by this change.

Thank you & best regards,

Dennis

On 12.09.2016 14:27, Takashi Iwai wrote:
> On Mon, 12 Sep 2016 12:44:50 +0200,
> Dennis Wassenberg wrote:
>>
>> This is some preparatory work to not only support led control in
>> thinkpad_helper over thinkpad_acpi.
>>
>> A further patch will introduce led control over hid-lenovo.
>> This will make it possible to use the thinkpad_helper not only with
>> lenovo devices via acpi but also with hid-lenovo driver
>> if there is a hid-lenovo compatible device found.
>>
>> Signed-off-by: Dennis Wassenberg <dennis.wassenberg@secunet.com>
> 
> Since the functionality isn't changed by the name, I'd like to keep it
> as is.  It makes the backporting still available / easier.
> 
> Of course, you can add comments to the fixup function accordingly.
> 
> 
> thanks,
> 
> Takashi
> 
