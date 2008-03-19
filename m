From: "chris guirl" <thelusiv@gmail.com>
Subject: Re: Improving drivers for Logitech Driving Force Pro and G25 wheels
Date: Wed, 19 Mar 2008 13:43:56 -0400
Message-ID: <9ff0fb570803191043h35ca48f3u277e3b710b6e72a8@mail.gmail.com>
References: <9ff0fb570803141252m5bd2dfd6wb0bcfd293a9a79bb@mail.gmail.com>
	 <6b33c0ac0803172128p1d291a83w1bb8c3788a9e0ba0@mail.gmail.com>
	 <6b33c0ac0803172130l6cbfe5b3wa0aa695008b236bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:19746 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756117AbYCSTgg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Mar 2008 15:36:36 -0400
Received: by fg-out-1718.google.com with SMTP id l27so522913fgb.17
        for <linux-input@vger.kernel.org>; Wed, 19 Mar 2008 12:36:35 -0700 (PDT)
In-Reply-To: <6b33c0ac0803172130l6cbfe5b3wa0aa695008b236bc@mail.gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richie Ward <richies@gmail.com>
Cc: linux-input@vger.kernel.org

On Tue, Mar 18, 2008 at 12:30 AM, Richie Ward <richies@gmail.com> wrote:
> I own a G25, Can you write out some of the knowledge you have acquired?

First off a little info on the G25, and how it works on Windows (for
those unfamiliar). The device allows up to 900 degrees of wheel
rotation (with force feedback), it has a "H" style shifter, and it has
three foot pedals (gas, brake and clutch). It has a total of six axes
and nineteen buttons. How many axes/buttons are reported depends on
what mode the wheel is in. It also has other settings like the limits
of wheel rotation. The wheel can be set to only be allowed to turn as
little as 40 degrees. On Windows, Logitech Profiler allows the user to
change the wheel rotation range, along with other settings. When the
wheel starts up, the Logitech drivers on Windows send a command to the
device to put it into its native mode, so that all the axes/buttons
are present.

In Linux, when the wheel starts up, it is in legacy mode, and only
four axes and twelve buttons are available. I believe this causes the
clutch and shifter to not work as well, if I understand correctly.
Also, the device is limited to its default wheel rotation range of 200
degrees, and the user-oriented tools to change wheel settings do not
exist in Linux.

Another thing missing from all the steering wheel drivers for Linux is
the ability to separate the pedal axes. Basically, most steering
wheels act by default as a generic HID joystick device with two axes,
to ensure backwards-compatibility with games that only support
joysticks with two axes. These two axes are the steering axis, and a
combined brake/gas axis.

When the two pedal axes are combined as one, the pedals do not act
quite normally. When the brake is pressed by itself, the combined axis
goes negative; while the gas is pressed by itself, the combined axis
goes positive. When both pedals are pressed simultaneously they cancel
each other out. To fix this, the Linux steering wheel drivers need to
be able to change from combined to separated pedal axes with a
user-controllable tool similar to the Logitech Profiler in Windows.
For Logitech devices, the raw pedal data is available as a USB stream
unreported when acting as a standard HID device.

Through a contact at Logitech I have been given the information to fix
the deficiencies in the current Linux steering wheel drivers as
outlined above. I have posted a lot of this information already on the
message boards at VDrift.net. This thread [1] contains a Python tool
to send some commands to the DFP/G25. It was made for the G25 and
apparently works well for it, but this and other functionality needs
to be added to the kernel driver. It doesn't quite work for the DFP in
my experience because of some other issues (see my previous posts).

Much of the information I obtained was posted here [2]. I have some
other details and tidbits that might be useful. There are some other
threads on the VDrift forums with a good bit of information on the
force-feedback and other details for the G25 and other wheels, I'll be
happy to link it if anyone's interested.

I haven't had much time lately to start hacking on this, but hopefully
I will by this weekend at the latest.

Chris

[1] http://vdrift.net/Forum/viewtopic.php?t=866
[2] http://vdrift.net/Forum/viewtopic.php?p=7755#7755
