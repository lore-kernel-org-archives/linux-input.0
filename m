From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 0/2] input/serio: Add a firmware_id sysfs attribute
Date: Fri, 28 Mar 2014 09:12:43 +0100
Message-ID: <53352EFB.8000309@redhat.com>
References: <1395310330-3232-1-git-send-email-hdegoede@redhat.com> <20140320172159.GA27400@srcf.ucam.org> <20140328075655.GE22093@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:9026 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751153AbaC1IMu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Mar 2014 04:12:50 -0400
In-Reply-To: <20140328075655.GE22093@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Benjamin Tissoires <btissoir@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>, platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org

Hi,

On 03/28/2014 08:56 AM, Dmitry Torokhov wrote:
> On Thu, Mar 20, 2014 at 05:21:59PM +0000, Matthew Garrett wrote:
>> On Thu, Mar 20, 2014 at 11:12:08AM +0100, Hans de Goede wrote:
>>
>>> Which in the end turns out to be much nicer too, since it gets rid of needing
>>> a udev-helper too. After this much too long introduction I'll let the patches
>>> speak for themselves.
>>
>> Yeah, I was coming to the conclusion that this was probably the best we 
>> could do. It's unfortunate that "id" is already in use - we'd be able to 
>> get away without any X server modifications otherwise.
>>
>> Long term we probably still want to tie serio devices to the ACPI 
>> devices in case the vendor provides power management calls there, but we 
>> can leave that until there's an actual example.
> 
> I am still unsure if we shoudl be adding these new IDs to serio core...
> Can't the X driver take a peek at ACPI devices on it's own?

The problem is there is no way for userspace to know which /sys/devices/pnp0/00:xx
device is the serio bus host.

Regards,

Hans
