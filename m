From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [RFC] Reporting "orientation changed" event
Date: Thu, 07 Apr 2011 17:37:35 +0100
Message-ID: <1302194258.12215.10.camel@novo.hadess.net>
References: <20110407181800.27b441b1@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:45070 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755392Ab1DGQhl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Apr 2011 12:37:41 -0400
In-Reply-To: <20110407181800.27b441b1@destiny.ordissimo>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anisse Astier <anisse@astier.eu>
Cc: linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>, Matthew Garrett <mjg@redhat.com>, Andy Ross <andy.ross@windriver.com>, Corentin Chary <corentin.chary@gmail.com>

On Thu, 2011-04-07 at 18:18 +0200, Anisse Astier wrote:
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
> 
> Or we could use the upcoming IIO subsystem which is supposed to be for
> sensors, but then we'd have a mismatch between the device based on ACPI
> with firmware in the middle (driver submitted by Andy Ross) and the
> purpose of IIO ("SPI or I2C device").

How would one know which orientation the device is now in, either from
the event, or when the orientation already changed? How would this be
"key" to user-space in general, and X in particular?

