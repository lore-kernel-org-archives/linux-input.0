From: Peter Hutterer <peter.hutterer@redhat.com>
Subject: Re: [PATCH 0/2] input/serio: Add a firmware_id sysfs attribute
Date: Mon, 24 Mar 2014 11:07:33 +1000
Message-ID: <532F8555.5070701@redhat.com>
References: <1395310330-3232-1-git-send-email-hdegoede@redhat.com> <20140320172159.GA27400@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20140320172159.GA27400@srcf.ucam.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>, Hans de Goede <hdegoede@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <btissoir@redhat.com>, platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 21/03/14 03:21, Matthew Garrett wrote:
> On Thu, Mar 20, 2014 at 11:12:08AM +0100, Hans de Goede wrote:
>
>> Which in the end turns out to be much nicer too, since it gets rid of needing
>> a udev-helper too. After this much too long introduction I'll let the patches
>> speak for themselves.
>
> Yeah, I was coming to the conclusion that this was probably the best we
> could do. It's unfortunate that "id" is already in use - we'd be able to
> get away without any X server modifications otherwise.

IMO we don't need to worry about that. this is needed for a set of 
devices that need a kernel patch, several synaptics patches and a server 
patch to work properly anyway, so changes are already required. Approach 
looks good, ACK from me.

Cheers,
   Peter

>
> Long term we probably still want to tie serio devices to the ACPI
> devices in case the vendor provides power management calls there, but we
> can leave that until there's an actual example.
>
