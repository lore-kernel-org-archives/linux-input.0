From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [RFC v2] input: Introduce device information ioctl
Date: Wed, 15 Dec 2010 16:16:28 -0500
Message-ID: <4D09302C.4000309@canonical.com>
References: <1292440807-18502-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1292440807-18502-1-git-send-email-rydberg@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pingc@wacom.com>, Chris Bagwell <chris@cnpbagwell.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 12/15/2010 02:20 PM, Henrik Rydberg wrote:
> Today, userspace sets up an input device based on the data it emits.
> This is not always enough; a tablet and a touchscreen may emit exactly
> the same data, for instance, but the former should be set up with a
> pointer whereas the latter does not need to. Recently, a new type of
> touchpad has emerged where the buttons are under the pad, which
> changes handling logic without changing the emitted data. This patch
> introduces a new ioctl, EVIOCGPROP, which enables user access to a set
> of device properties useful during setup. The properties are given as
> a bitmap in the same fashion as the event types.
> 
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---
> Hi all,
> 
> Here is version two of the device information proposal. In addition to
> implementing the feedback, this version only defines a single combined
> type/capabilities field. Since we want to support a device being of
> multiple types, it suggests that we are really after the properties
> that make up a type, rather than the types themselves. And since
> quirks are also properties, we end up with a single bitmap of
> properties instead.
> 
> As an example of how this would work for the
> touchpad/tablet/touchscreen triplet, there are two properties defined,
> INPUT_PROP_POINTER and INPUT_PROP_DIRECT. A touchpad is an indirect
> pointer device, a tablet is a direct pointer device, and the
> touchscreen is simply a direct device.
> 
> What do you think?

I must have missed the first version of this patch, but I give two
thumbs way up :). The detection code for touchpad/tablet/touchscreen in
xf86-input-evdev is large and unwieldy, and seemingly simple changes to
an input driver can cause incorrect interpretation. Having this
available should help quite a bit!

Acked-by: Chase Douglas <chase.douglas@canonical.com>
