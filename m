From: simon@mungewell.org
Subject: Re: [PATCH 1/5] USB: HID: SRW-S1 Gaming Wheel Driver
Date: Thu, 31 Jan 2013 10:15:07 -0500
Message-ID: <bc26a4ded50b76e213708a64b857ce1f.squirrel@mungewell.org>
References: <alpine.LNX.2.00.1301291057170.23853@pobox.suse.cz>
    <1359644830-3274-1-git-send-email-simon@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:33093 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458Ab3AaPPJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 31 Jan 2013 10:15:09 -0500
In-Reply-To: <1359644830-3274-1-git-send-email-simon@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, simon@mungewell.org, rosegardener@freeode.co.uk

> Add support the SRW-S1 by patching HID descriptor to read axis
> as Generic Desktop X, Y and Z (rather than Usage page being
> 'Simulation').

Slight glitch in making this patch set, there is no [5/5] - just the 4
parts as sent.... sorry if this causes confusion.

Simon.

