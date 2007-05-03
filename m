From: Jan Kratochvil <honza@jikos.cz>
Subject: Re: [PATCH 1/3] xpad.c: Added flags into xpad_device structure and
 removed dpad_mapping.
Date: Thu, 3 May 2007 14:40:30 +0200 (CEST)
Message-ID: <alpine.LRH.0.98.0705031438220.22353@twin.jikos.cz>
References: <Pine.LNX.4.64.0705021644580.13550@twin.jikos.cz>
 <200705022238.36454.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200705022238.36454.dtor@insightbb.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-input@atrey.karlin.mff.cuni.cz, linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On Wed, 2 May 2007, Dmitry Torokhov wrote:

> Hi Jan,
>
> On Wednesday 02 May 2007 11:01, Jan Kratochvil wrote:
>> This changes are expected to simplify further improves of this driver,
>> We will need to add information if the driver is xbox360 device or not.
>>
>> Second option was to simply add u8 is_360, but what if we'll need to know
>> if device is a wheel? Or if the device can have keyboard (or headset) attached.
>>
>
> ...
>
>> -#define MAP_DPAD_TO_BUTTONS    0
>> -#define MAP_DPAD_TO_AXES       1
>> -#define MAP_DPAD_UNKNOWN       -1
>> +#define XPAD_FLAGS_DPAD_TO_BUTTONS    (1 << 0)
>> +#define XPAD_FLAGS_DPAD_TO_AXES       (1 << 1)
>> +#define XPAD_FLAGS_DPAD_UNKNOWN       (1 << 2)
>>
>
> Turning this into bitmaps suggests that all of these could be set which is
> not the case. Since there are 3 spare bytes in xpad_device structure to
> use for additional flags/bitmaps I'd leave dpad_mapping alone.

Ok. Lets ignore this patch.

>
> --
> Dmitry
>

Jan Kratochvil
