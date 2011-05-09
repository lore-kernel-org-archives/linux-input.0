From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC] Reporting "orientation changed" event
Date: Mon, 9 May 2011 15:38:28 +0100
Message-ID: <20110509143828.GA2632@srcf.ucam.org>
References: <20110407181800.27b441b1@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110407181800.27b441b1@destiny.ordissimo>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Anisse Astier <anisse@astier.eu>
Cc: linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>, Andy Ross <andy.ross@windriver.com>, Corentin Chary <corentin.chary@gmail.com>
List-Id: linux-input@vger.kernel.org

(Sorry for taking so long to respond)

On Thu, Apr 07, 2011 at 06:18:00PM +0200, Anisse Astier wrote:

> Pegatron Lucid tablet sends an ACPI hotkey event(0xEA) when the
> accelerometer detects coarse orientation change. My initial thought was
> to just translate this event into KEY_DIRECTION, which seems to be the
> norm from what we can see in hp-wmi driver. (See patch below for an
> implementation.)
> 
> But this isn't just a key per se like on the HP touchsmart tablet, this
> is an event that is triggered when the device is rotated.
> 
> This could be defined as a new Misc (EV_MSC) event:
> MSC_ORIENTATION_CHANGED ?

I'd say that it ought to be hooked into the accelerometer driver and 
that should indicate that the orientation has changed.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
