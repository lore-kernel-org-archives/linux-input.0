From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: How to use force feedback correctly?
Date: Tue, 17 Mar 2009 15:15:47 +0200
Message-ID: <49BFA283.6000307@gmail.com>
References: <200903161142.12123.alexander.stein@informatik.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mta-out.inet.fi ([195.156.147.13]:35354 "EHLO kirsi1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752114AbZCQNPv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Mar 2009 09:15:51 -0400
In-Reply-To: <200903161142.12123.alexander.stein@informatik.tu-chemnitz.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>
Cc: linux-input@vger.kernel.org

Alexander Stein wrote:
> Hello,

Hi!

> I've read the documentation about force feedback in 
> Documentation/input/ff.txt. But I'm rather unsure how to use it actually. So 
> far I understood this you have to use /dev/input/eventX to access your ff-
> device. But normally only root has read and write access to this device files, 
> while a joystick is used normally using /dev/input/jsX which can be used by a 
> non-root user.
> 
> So my actual question is: How can I use force feedback of a joystick without 
> setting global read/write permissions to /dev/input/eventX?

The distribution should configure joystick eventX devices to
either have global read/write access, or read/write access for one group
(which the user is in), or have it chown the device to logged-in user,
depending on distribution conventions.

One can identify joystick devices from other eventX devices with udev
variable ENV{ID_CLASS}="joystick", or with existence of
"/dev/input/by-path/*-event-joystick", which is a symlink to the eventX
device.

On Mandriva Linux, permissions are granted to logged-in user with
pam_console / ConsoleKit, with /dev/input/by-path/*-event-joystick.

> Or may I even be 
> able to use force feedback using /dev/input/jsX?

Nope.

> Other thing: Is it possible that on line 52 in Documentation/input/ff.txt the 
> declaration of the features array is wrong?
>> #52 unsigned long features[1 + FF_MAX/sizeof(unsigned long)];
> IMO it has to be declared like this:
>> unsigned long features[1 + FF_MAX/ (8 * sizeof(unsigned long))];
> Which creates actually a Bit array, not an Byte array.

Right, seems to be wrong.

-- 
Anssi Hannula


