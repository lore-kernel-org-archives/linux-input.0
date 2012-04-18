From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] HID: hid-input: default HID_BATTERY_STRENGTH to no
Date: Wed, 18 Apr 2012 10:12:33 -0700
Message-ID: <4F8EF601.1050804@goop.org>
References: <20120418140517.GM19507@zod.bos.redhat.com> <1334758134.8818.132.camel@novo.hadess.net> <20120418141131.GN19507@zod.bos.redhat.com> <20120418142450.GA30083@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120418142450.GA30083@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Josh Boyer <jwboyer@redhat.com>, Bastien Nocera <hadess@hadess.net>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@fedoraproject.org, Richard Hughes <richard@hughsie.com>
List-Id: linux-input@vger.kernel.org

On 04/18/2012 07:24 AM, Matthew Garrett wrote:
> On Wed, Apr 18, 2012 at 10:11:31AM -0400, Josh Boyer wrote:
>> On Wed, Apr 18, 2012 at 03:08:54PM +0100, Bastien Nocera wrote:
>>> Don't. The only bit of user-space that's broken is upower, and it's
>>> getting a fixed release shortly.
>> Matthew suggested that additional kernel patches were required to add a
>> scope parameter so upower could understand that the battery is powering
>> a device and not the system.
>>
>> Also, when did it become OK to force-enable a new feature that is
>> _known_ to not work properly on recent userspace?  That makes no sense
>> to me.
> I agree. It's a great feature, but it shouldn't be default y if 
> userspace isn't ready for it yet.

Dammit, I should have pushed harder to get the scope into the same
release.  Oh well.

Does upower trigger a shutdown/hibernation if *any* power supply is low,
or just if all of them are?  Are the failing cases ones where the BT
keyboard is the only visible power supply?

In any case, no objections to disabling it if its the only way to
prevent regressions for now.

    J
