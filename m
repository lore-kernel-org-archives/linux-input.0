From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH 2/2] mfd: twl4030: add twl4030-pwrbutton as our child
Date: Thu, 23 Jul 2009 00:57:48 +0530
Message-ID: <5d5443650907221227w72768b3cna145cea00f1baa05@mail.gmail.com>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com>
	 <200902271358.46863.david-b@pacbell.net>
	 <20090227141212.a2bc4a01.akpm@linux-foundation.org>
	 <200902271520.56696.david-b@pacbell.net>
	 <20090227154220.7099f339.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753846AbZGVT1w@vger.kernel.org>
In-Reply-To: <20090227154220.7099f339.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Brownell <david-b@pacbell.net>, me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-input@vger.kernel.org

Hi Andrew/Samuel,

On Sat, Feb 28, 2009 at 5:12 AM, Andrew Morton<akpm@linux-foundation.or=
g> wrote:
> On Fri, 27 Feb 2009 15:20:56 -0800
> David Brownell <david-b@pacbell.net> wrote:
>
>> On Friday 27 February 2009, Andrew Morton wrote:
>> > > >
>> > > > What has gone wrong here?
>> > >
>> > > Not much I can see. __It's registering a platform_device,
>> > > but only if it could be used on this system.
>> >
>> > Again, that all gets fixed if this is done the right way around. _=
_Run
>> > your probe function. __If the hardware is there, register with the=
 core
>> > and all the nodes appear. __If the hardware is not present: bale.
>>
>> Right. =A0If there's no button hooked up to its "power button"
>> signal, don't register that "twl4030-pwrbutton" node.
>>
>>
>> > The design of the whole subsystem appears to be upside down :(
>>
>> You seem to be missing something. =A0Is it only the lack of that
>> tweak Felipe sent?
>
> I generally just delete unchangelogged patches.
>
> <goes back and finds it>
>
>
> That doesn't address the problem at all. =A0A function called
> "add_children" just shouldn't exist. =A0The general kernel design is =
for
> client drivers to register themselves with the core, so the core does
> not have any hard-wired knowledge of any client drivers.
>
> IOW, twl4030_pwrbutton_probe() should call into twl4030-core,
> registering the powerbutton driver.
>

Reviving this very old thread.

Andrew,

It seems that every driver under "mfd" is following the more or less
approach like twl4030, where the core driver is creating sub-device
driver's platform devices based on either some conditions like
platform data for that sub-device driver is available or not, or
sub-device array with it's "name" and "id" is passed from arch/ board
files.

Samuel,

I don't see any further discussion of points raised by Andrew in this d=
river.


--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
