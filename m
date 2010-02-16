From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/4] HID: hid-ntrig add multi input quirk and clean up
Date: Tue, 16 Feb 2010 13:49:20 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002161349040.30967@pobox.suse.cz>
References: <1265933946-8318-1-git-send-email-rafi@seas.upenn.edu> <1265944448-23436-1-git-send-email-rafi@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:44788 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755432Ab0BPMtW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Feb 2010 07:49:22 -0500
In-Reply-To: <1265944448-23436-1-git-send-email-rafi@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, chatty@enac.fr

On Thu, 11 Feb 2010, Rafi Rubin wrote:

> Added a quirk to enable distinct input devices.  The digitizer utilizes
> three inputs to represent pen, multitouch and a normal touch screen.
> 
> With the Pen partitioned, it behaves well and does not need special
> handling.
> 
> Also, I set names to the input devices to clarify the functions of the
> various inputs.

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
