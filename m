From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 4.2] hid_dr: Fixed HID Descriptor
Date: Fri, 4 Sep 2015 14:52:44 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1509041452350.30132@pobox.suse.cz>
References: <1441309599-17421-1-git-send-email-gzmlke@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36354 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759024AbbIDMwo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 4 Sep 2015 08:52:44 -0400
In-Reply-To: <1441309599-17421-1-git-send-email-gzmlke@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Maciej Zuk <gzmlke@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 3 Sep 2015, Maciej Zuk wrote:

> From: Maciej Zuk <gzmlke@gmail.com>
> 
> Fixed HID descriptor for DragonRise Joystick.
> Replaced default descriptor which doubles Z axis 
> and causes mixing values of X and Z axes.

Applied to for-4.4/dragonrise.

-- 
Jiri Kosina
SUSE Labs

