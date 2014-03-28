From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 0/2] input/serio: Add a firmware_id sysfs attribute
Date: Fri, 28 Mar 2014 10:05:00 +0100
Message-ID: <53353B3C.90600@redhat.com>
References: <1395310330-3232-1-git-send-email-hdegoede@redhat.com> <20140320172159.GA27400@srcf.ucam.org> <20140328075655.GE22093@core.coreip.homeip.net> <53352EFB.8000309@redhat.com> <20140328081739.GG22093@core.coreip.homeip.net> <533532FE.2000304@redhat.com> <20140328085207.GN22093@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20140328085207.GN22093@core.coreip.homeip.net>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Benjamin Tissoires <btissoir@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>, platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

On 03/28/2014 09:52 AM, Dmitry Torokhov wrote:
> On Fri, Mar 28, 2014 at 09:29:50AM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 03/28/2014 09:17 AM, Dmitry Torokhov wrote:
>>> On Fri, Mar 28, 2014 at 09:12:43AM +0100, Hans de Goede wrote:
>>>> Hi,
>>>>
>>>> On 03/28/2014 08:56 AM, Dmitry Torokhov wrote:
>>>>> On Thu, Mar 20, 2014 at 05:21:59PM +0000, Matthew Garrett wrote:
>>>>>> On Thu, Mar 20, 2014 at 11:12:08AM +0100, Hans de Goede wrote:
>>>>>>
>>>>>>> Which in the end turns out to be much nicer too, since it gets rid of needing
>>>>>>> a udev-helper too. After this much too long introduction I'll let the patches
>>>>>>> speak for themselves.
>>>>>>
>>>>>> Yeah, I was coming to the conclusion that this was probably the best we 
>>>>>> could do. It's unfortunate that "id" is already in use - we'd be able to 
>>>>>> get away without any X server modifications otherwise.
>>>>>>
>>>>>> Long term we probably still want to tie serio devices to the ACPI 
>>>>>> devices in case the vendor provides power management calls there, but we 
>>>>>> can leave that until there's an actual example.
>>>>>
>>>>> I am still unsure if we shoudl be adding these new IDs to serio core...
>>>>> Can't the X driver take a peek at ACPI devices on it's own?
>>>>
>>>> The problem is there is no way for userspace to know which /sys/devices/pnp0/00:xx
>>>> device is the serio bus host.
>>>
>>> Practically speaking you should not care - there is only one touchpad in
>>> Lenovos.
>>
>> So are you suggesting we simply go over all /sys/devices/pnp0/00:xx devices looking
>> for a pnp-id we're interested  in ?  I'm sorry but that is just a non-sense solution,
>> which reminds me of the good old days of random poking io-ports to probe stuff.
>>
>> We're not blindly going to read every /sys/devices/pnp0/00:xx/id attribute on a
>> system, assuming that if it contains a pnp-id we're interested in it happens to
>> belong to the input device we're enumerating at that time.
> 
> Are we even certain that they will be consistent in use of these special
> PNP ID's? Maybe you should really do DMI match...

They are more consistent with PNP ids then with their DMI strings, that is if they
re-use the exact same touchpad the PNP id stays the same. So PNP ids give us a
better chance of things just working without the user needing to wait for a distro
update which has the new DMI strings in there.

And yes so far the PNP ids use we want to-do is Lenovo only, as we've just discovered
that they are actually storing some useful info in there. If we need quirks for other
vendor laptops in the future, chances are we may want to do pnp-id matching there too.

I've deliberately tried to write this patch-set so that it adds a generic way to export
extra info the platform specific code may have. I could have added a pnp-id pointer to
the serio struct, but I deliberately went with a free-form string so as to make this
as generic as possible. As Matthew has already said we may want to also export extra
info from devicetree through this mechanism for example.

Regards,

Hans
