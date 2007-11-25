From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Suspend-devel] No keyboard after suspend & resume - help with diagnosing
Date: Mon, 26 Nov 2007 00:36:33 +0100
Message-ID: <200711260036.33841.rjw@sisk.pl>
References: <4749FA52.9070001@pastornet.net.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:36303 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755634AbXKYXSU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 25 Nov 2007 18:18:20 -0500
In-Reply-To: <4749FA52.9070001@pastornet.net.au>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Campbell <david@pastornet.net.au>, linux-input@vger.kernel.org
Cc: suspend-devel@lists.sourceforge.net, Dmitry Torokhov <dtor@insightbb.com>

On Sunday, 25 of November 2007, David Campbell wrote:
> Hi,
> 
> I have a Clevo D870P notebook running fedora 8, kernel 2.6.23.1-49.fc8 
> and I usually use an external keyboard (PS2 connection).
> 
> However I find that when I suspend the notebook and then resume out of 
> suspend, neither keyboards work most times.  The same was true under 
> fedora 7.
> 
> If I then proceed to unplug the external keyboard and plug it back in 
> again, then both keyboards work and dmesg reports something like:
>    input: AT Translated Set 2 keyboard as /class/input/input11
> 
> I can't see any other related messages logged.
> 
> How can I diagnose and solve such a problem?

This is a kernel problem, forwarding to the right people.

Greetings,
Rafael
