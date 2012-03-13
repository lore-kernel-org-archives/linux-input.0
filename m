From: simon@mungewell.org
Subject: Re: [PATCH] HID: hig-lg, hif-lg4ff: Allow for custom device
 properties to be stored as private driver data
Date: Mon, 12 Mar 2012 22:02:37 -0400
Message-ID: <accc05306e390e8e20948ceeaf1ce264.squirrel@mungewell.org>
References: <2576330.lyEl61c5nA@qosmio-x300>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:33970 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755247Ab2CMCCj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Mar 2012 22:02:39 -0400
In-Reply-To: <2576330.lyEl61c5nA@qosmio-x300>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?=22Michal_Mal=FD=22?= <madcatxster@gmail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, simon@mungewell.org


> Because of the scope of the changes, Simon's
> implementation of the G27 LEDs code is unfortunately incompatible with
> this patch because it uses the linked list I'm trying to get rid of.

Unfortunately Michal's patch seems to be corrupt and won't 'take'. That
said I'm very happy to re-work my patches to work with Michal's (and take
on-board Mark's suggestions about the LED subsystem).

> The patch also introduces some spinlocking to hid-lg and hid-lg4ff to
> (hopefully) prevent any nasty
> race conditions you were concerned about.

Jiri: Is this the spin lock you were looking for?

Simon


