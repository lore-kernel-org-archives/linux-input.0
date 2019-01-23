From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 7/9] platform/chrome: Add EC properties
Date: Wed, 23 Jan 2019 10:52:18 -0800
Message-ID: <20190123185218.GB179701@dtor-ws>
References: <20190123183325.92946-1-ncrews@chromium.org>
 <20190123183325.92946-8-ncrews@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190123183325.92946-8-ncrews@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Crews <ncrews@chromium.org>
Cc: linux-kernel@vger.kernel.org, sjg@chromium.org, sre@kernel.org, linux-input@vger.kernel.org, groeck@chromium.org, dlaurie@chromium.org, Nick Crews <ncrews@google.com>, Duncan Laurie <dlaurie@google.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Benson Leung <bleung@chromium.org>
List-Id: linux-input@vger.kernel.org

On Wed, Jan 23, 2019 at 11:33:23AM -0700, Nick Crews wrote:
> From: Nick Crews <ncrews@google.com>
> 
> A Property is typically a data item that is stored to NVRAM.
> Each of these data items has an index associated with it
> known as the Property ID (PID). The Property ID is
> used by the system BIOS (and EC) to refer to the Property.
> Properties may have variable lengths. Many features are
> implemented primarily by EC Firmware with system BIOS
> just supporting user configuration via BIOS SETUP and/or
> SMBIOS changes. In order to implement many of these types of
> features the user configuration information is saved to and
> retrieved from the EC. The EC stores this configuration
> information to NVRAM and then can use it while the system
> BIOS is not running or during early boot. Although this
> is a typical scenario there may be other reasons to store
> information in the EC NVRAM instead of the System NVRAM.
> Most of the property services do not have a valid failure
> condition, so this field can be ignored. For items that
> are write once, a failure is returned when a second
> write is attempted.
> 
> Add a get and set interface for EC properties.
> properties live within the "properties" directory.
> Most of the added properties are boolean, but this also
> provides the interface for non-boolean properties,
> which will be used late for scheduling power routines.

We have proper interfaces for many of the options below (i.e. mic mute
led can be expressed via LED subsystem and controlled via
/sys/class/led/...), wlan is should be controlled by rfkil if we decide
to go that road, etc.

Thanks.

-- 
Dmitry
