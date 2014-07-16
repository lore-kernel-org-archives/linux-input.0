From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Power-managing devices that are not of interest at some point in time
Date: Thu, 17 Jul 2014 01:11:31 +0200
Message-ID: <5611777.bNi5p029gt@vostro.rjw.lan>
References: <20140716013206.GA13409@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20140716013206.GA13409@google.com>
Sender: linux-pm-owner@vger.kernel.org
To: Patrik Fimml <patrikf@chromium.org>
Cc: linux-pm@vger.kernel.org, Dmitry Torokhov <dtor@google.com>, Benson Leung <bleung@google.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tuesday, July 15, 2014 06:32:06 PM Patrik Fimml wrote:
> (Re-sending with correct mailing list addresses.)
> 
> Hi,
> 
> When the lid of a laptop is closed, certain devices can no longer
> provide interesting input or will even produce bogus input, such as:
> 
> - input devices: touchscreen, touchpad, keyboard
> - sensors: ambient light sensor, accelerometer, magnetometer
> - a video camera mounted on the lid
> - display backlight
> 
> Various workarounds cover some of these cases, and we have some ugly
> hacks in ChromeOS to make things work. It would be nice if a userspace
> power management daemon could listen to the lid-close event, and then
> have a way to temporarily power off these devices, potentially through
> sysfs.
> 
> I've been discussing this with Dmitry and Benson (cc'd), and we've been
> wondering whether we could come up with a generic solution that could
> benefit multiple device classes.
> 
> There's some overlap with runtime PM here. The action to be taken in
> such a situation would probably be similar to a runtime suspend. The
> match is not perfect though, since devices with more than two power
> states might want to enter different states depending on the situation.
> 
> It's somewhat difficult to get the semantics right, since handles to
> such devices might still be open. It might be easier to implement
> behavior specific to device classes. On the other hand, it would be nice
> to have a uniform way of shutting devices down, and not introduce
> another possible path for a device to enter a power-saving state.
> 
> Rafael, can you give us your opinion on this?

Let me try to understand the scenario in the first place.

To start with, a number of devices is in use (that is, open, there are
applications listening/talking to them etc).  Now, an event happens, such
as a laptop lid close and you want some of those devices, but possibly
not all of them, to quiesce themselves and go into low-power states.

Is that correct?

Rafael

