From: Andy Ross <andy.ross@windriver.com>
Subject: Re: [RFC] Reporting "orientation changed" event
Date: Mon, 09 May 2011 08:37:55 -0700
Message-ID: <4DC80A53.7050609@windriver.com>
References: <20110407181800.27b441b1@destiny.ordissimo> <20110509143828.GA2632@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from li44-10.members.linode.com ([72.14.181.10]:36870 "EHLO
	plausible.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752105Ab1EIPqH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 9 May 2011 11:46:07 -0400
In-Reply-To: <20110509143828.GA2632@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Anisse Astier <anisse@astier.eu>, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>, Corentin Chary <corentin.chary@gmail.com>

On 05/09/2011 07:38 AM, Matthew Garrett wrote:
> On Thu, Apr 07, 2011 at 06:18:00PM +0200, Anisse Astier wrote:
> > Pegatron Lucid tablet sends an ACPI hotkey event(0xEA) when the
> > accelerometer detects coarse orientation change
>
> I'd say that it ought to be hooked into the accelerometer driver and
> that should indicate that the orientation has changed.

How would that work?  If it's an extra sysfs node, it would require an
extra file descriptor in the reader.  And if it's an event inside the
input stream, that would require the reader implement handling to throttle
the polling rate.  The point here was to avoid having to poll the
(noisy) accelerometer stream just for gross orientation changes.

Just to add a little iconoclasm, is this really something that needs
to be designed?  Right now, it's limited to one device.  And the only
reason we care about this event is that the accelerometer device* is
noisy and very slow.  If it worked like "regular" accelerometers we'd
just use the standard code path for polling an accelerometer device
and do it all in userspace.

The specific use case here is the MeGo integration for the
ExoPC/WeTab.  You can see the code here:

http://build.meego.com/package/files?package=sensorfw-pegatron&project=Trunk

It's just a one-liner acpid hook which uses dbus-send to tickle a
method in the sensor daemon plugin.  It's clean, works well, and owing
to acpid's configuration scheme is trivial to package.

Does it really need to be "fixed"?  If this were a whole class of
hardware, then I guess I'd agree.  But right now it's one quirky
device.

Andy

* The upstreaming of which is still waiting on me to get back to the
  panics I saw and triage them.  I haven't forgotten Corentin, I just
  haven't been able to find the time.
