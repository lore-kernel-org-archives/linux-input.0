From: simon@mungewell.org
Subject: Re: [PATCH v2 0/5] Support for the Sony Motion Controller and other
 cleanups
Date: Wed, 27 May 2015 11:46:42 -0400
Message-ID: <8f8f23bf33147705c4430c9ec4bb32fe.squirrel@mungewell.org>
References: <1430873253-11765-1-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:40054 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbbE0QCs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 May 2015 12:02:48 -0400
In-Reply-To: <1430873253-11765-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, pavel@ucw.cz, Frank Praznik <frank.praznik@oh.rr.com>

> This set of patches adds initial support for the Sony Motion Controller
> via
> cleaned-up initial patches from Pavel Machek, streamlines LED
> initialization
> and state updates, adds a comment to explain why the Sixaxis has so many
> axes
> and why they spill over into the multi-touch space and makes some general
> cosmetic corrections.

Maybe a little pointless as Jiri as already accepted, but I wanted to
confirm that these patches appear work OK on my 3rd party (Intec)
controller which has been problematic in the past.


I have also acquired a PS Move Motion controller and note that LED
settings work, but are then overridden (LED goes dark) after ~5s when
connected with USB. I believe that this is a 'feature' of the controller
with USB connection (and note there is no HID stream coming from the
device).

Does any one know of a trigger/command which will enable full USB operation?
Simon.

PS. I did not try BT connection as that apparently requires Bluez > 5.0,
which is a pain on _that_ machine.

