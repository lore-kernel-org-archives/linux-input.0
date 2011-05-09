From: Andy Ross <andy.ross@windriver.com>
Subject: Re: [RFC] Reporting "orientation changed" event
Date: Mon, 09 May 2011 08:59:01 -0700
Message-ID: <4DC80F45.2040508@windriver.com>
References: <20110407181800.27b441b1@destiny.ordissimo> <20110509143828.GA2632@srcf.ucam.org> <4DC80A53.7050609@windriver.com> <20110509154729.GA5043@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from li44-10.members.linode.com ([72.14.181.10]:32801 "EHLO
	plausible.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752778Ab1EIP7E (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 9 May 2011 11:59:04 -0400
In-Reply-To: <20110509154729.GA5043@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Anisse Astier <anisse@astier.eu>, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>, Corentin Chary <corentin.chary@gmail.com>

On 05/09/2011 08:47 AM, Matthew Garrett wrote:
> Yes, so the accelerometer driver should (in-kernel) know that a coarse 
> orientation event has occured and then send an appropriate uevent to 
> userspace indiciating that it has new data.

OK, so substituting udev for acpid, but otherwise leaving the
input-polldev device alone.  That certainly sounds nice to me, though
I'm not sure where the "dreadful / don't do that" advice is directed
as the handling in userspace will be virtual identical (moving the
dbus-send from the acpid event file into a udev rule).

> I'm going to NAK anything that reports "Coarse orientation change"
> to userspace without providing any context.

Just to be clear: there's no kernel code to NAK here.  The acpid hook
is raw, and in userspace.  It's not clean, but it's also a single-device
fixup: seems to me to be pretty much exactly what apcid is for, no?

Andy
