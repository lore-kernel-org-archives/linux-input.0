From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH] HID: hid-magicmouse: Correct touch orientation direction
Date: Wed, 09 Mar 2011 12:44:44 -0500
Message-ID: <4D77BC8C.8040801@canonical.com>
References: <1299692337-1547-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:56783 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932407Ab1CIRot (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Mar 2011 12:44:49 -0500
In-Reply-To: <1299692337-1547-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org, Michael Poole <mdpoole@troilus.org>

On 03/09/2011 12:38 PM, Henrik Rydberg wrote:
> The magic trackpad and mouse both report touch orientation in opposite
> direction to the bcm5974 driver and what is written in
> Documents/input/multi-touch-protocol.txt. This patch reverts the
> direction, so that all in-kernel devices with this feature behave the
> same way.
> 
> Since no known application has been utilizing this information yet, it
> seems appropriate also for stable.
> 
> Cc: stable@kernel.org
> Cc: Michael Poole <mdpoole@troilus.org>
> Cc: Chase Douglas <chase.douglas@canonical.com>
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>

Acked-by: Chase Douglas <chase.douglas@canonical.com>

Thanks for fixing this!
