From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 6/9] platform/chrome: Add event handling
Date: Wed, 23 Jan 2019 10:45:01 -0800
Message-ID: <20190123184501.GA179701@dtor-ws>
References: <20190123183325.92946-1-ncrews@chromium.org>
 <20190123183325.92946-7-ncrews@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190123183325.92946-7-ncrews@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Crews <ncrews@chromium.org>
Cc: linux-kernel@vger.kernel.org, sjg@chromium.org, sre@kernel.org, linux-input@vger.kernel.org, groeck@chromium.org, dlaurie@chromium.org, Duncan Laurie <dlaurie@google.com>, Nick Crews <ncrews@google.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Benson Leung <bleung@chromium.org>
List-Id: linux-input@vger.kernel.org

Hi Nick, Duncan,

On Wed, Jan 23, 2019 at 11:33:22AM -0700, Nick Crews wrote:
> From: Duncan Laurie <dlaurie@google.com>
> 
> The Wilco Embedded Controller can return extended events that
> are not handled by standard ACPI objects.  These events can
> include hotkeys which map to standard functions like brightness
> controls, or information about EC controlled features like the
> charger or battery.
> 
> These events are triggered with an ACPI Notify(0x90) and the
> event data buffer is read through an ACPI method provided by
> the BIOS which reads the event buffer from EC RAM.
> 
> These events are then processed, with hotkey events being sent
> to the input subsystem and other events put into a queue which
> can be read by a userspace daemon via a sysfs attribute.

I thought we agreed that brightness keys will be routed through normal
keyboard interface, not separate input device?

Looking at the driver more, I do not see why it needs to be toed to EC,
this seems to be a straightforward ACPI driver that should bind to and
ACPI device by its HID, since the only thing it does is installing ACPI
notify handler and shuffling the events over to userspace.

I do not think we want to use a binary attribute for this, as it does
not support polling well and in general is not well suitable for
pumping data to userspace. I'd recommend char misc device for that.

What kind of events will be delivered over this interface?

Thanks.

-- 
Dmitry
