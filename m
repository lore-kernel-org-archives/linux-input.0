From: Hendrik Langer <hendrik.langer@gmx.de>
Subject: Re: [PATCH] HID: rmi: Check that a device is a RMI device before
 calling RMI functions
Date: Wed, 18 Oct 2017 23:00:52 +0200
Message-ID: <53863464-d70b-5970-2408-4cf7c1d3a94b@gmx.de>
References: <1508290656-18871-1-git-send-email-aduggan@synaptics.com>
 <20171018084803.GE24559@mail.corp.redhat.com>
 <nycvar.YFH.7.76.1710181612470.9294@jbgna.fhfr.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <nycvar.YFH.7.76.1710181612470.9294@jbgna.fhfr.qr>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Andrew Duggan <aduggan@synaptics.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 18/10/17 16:13, Jiri Kosina wrote:
> On Wed, 18 Oct 2017, Benjamin Tissoires wrote:
> 
>>> The hid-rmi driver may handle non rmi devices on composite USB devices.
>>> Callbacks need to make sure that the current device is a RMI device before
>>> calling RMI specific functions. Most callbacks already have this check, but
>>> this patch adds checks to the remaining callbacks.
>>>
>>> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
>>> ---
>>> This is the patch which hopefully will address the X1 tablet dock freeze:
>>> http://www.spinics.net/lists/linux-input/msg53582.html
>>>
>>> I was not able to test on a composite USB device so I have not tested confirmed
>>> this will fix the reported issues. But, based on the description I think it will.
>>> I also added a check for rmi_raw_event() since it could be possible that another
>>> hid device using one of the same report IDs as an RMI device could result in calling
>>> into unitialized RMI functions. It was also the only callbacl left not checking the
>>> RMI_DEVICE flag. I wonder if this explains the attach crash.
>>>
>>> Anyway, I would appriciate it if Hendrik or someone else with the device could test this
>>> patch to confirm it fixes the reported behavior.
>>
>> Shouldn't rmi_hid_reset() also get the same check?
> 
> I think so as well.
> 
>>
>> From what I can see, even if the patch doesn't fix the immediate issue, 
>> such a patch should definitively go in as those checks are clearly 
>> missing.
> 
> Agreed; however I'd like to get Hendrik's Tested-by: if possible in case 
> this really fixes the issue, so I am not merging it right away.
> 
> Hendrik, are you by any chance able to test this patch in a reasonable 
> timeframe please?
> 
> Thanks!
> 

Tested-by: Hendrik Langer <hendrik.langer@gmx.de>

Confirmed, the patch fixes the probem for me.
All freezes/Oops and rmi or input related error messages are gone. Even
keyboard and touchpad are working now!

Tested 4.13 and 4.14.0-rc3 (Debian) with the patch, repeated (un)docking
and booting with/without keyboard dock attached.

Thank you very much!
Hendrik
