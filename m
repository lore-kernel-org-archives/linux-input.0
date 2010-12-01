From: simon@mungewell.org
Subject: Re: Rewriting wheels HID descriptor for complete functionality
Date: Wed, 1 Dec 2010 17:18:58 -0500
Message-ID: <c7586f68fbd9dc8403b1dc74a028f906.squirrel@host171.canaca.com>
References: <e0bdb04c6bf793ed464934fd4f8b663e.squirrel@host171.canaca.com>
    <20101201222022.b2e49a1b.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:43728 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844Ab0LAWTA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 1 Dec 2010 17:19:00 -0500
In-Reply-To: <20101201222022.b2e49a1b.ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: simon@mungewell.org, linux-input@vger.kernel.org, Marcin Tolysz <tolysz@gmail.com>


> have you tried Marcin Tolysz's approach of loading the new HID
> descriptor from an external file?
>
> Look at:
> https://patchwork.kernel.org/patch/69723/
>

This looks plausable, and would be helpful to the hard-core hacker or
developer. However it would not really help with 'out of the box'
experience unless the distros would carry additional files for all known
'patches'.

As it stands it would require a file for each USB bus (presumably to allow
different settings for similar devices on a PC).

Given that you can bind/unbind USB devices via the
'/sys/bus/usb/drivers/usb-hid/[un]bind' interface, could it be possible to
present a HID descriptor file into which could be cat'ed a new descriptor
by the hard-core hacker?

Simon

