From: Roel Kluin <12o3l@tiscali.nl>
Subject: Re: mouse bug
Date: Fri, 30 Nov 2007 15:45:01 +0100
Message-ID: <475021ED.3010209@tiscali.nl>
References: <475018E3.5090606@tiscali.nl> <20071130142556.GA14122@ahaupt-debian-vm.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out3.tiscali.nl ([195.241.79.178]:41612 "EHLO
	smtp-out3.tiscali.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932246AbXK3OpF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Nov 2007 09:45:05 -0500
In-Reply-To: <20071130142556.GA14122@ahaupt-debian-vm.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andre Haupt <andre@bitwigglers.org>
Cc: linux-input@vger.kernel.org

Andre Haupt wrote:
> On Fri, Nov 30, 2007 at 03:06:27PM +0100, Roel Kluin wrote:
>
> does cat /dev/input/mice work (i.e. shows weird characters)?
> 
> regards,
> 
> Andre

Actually it did. Note that the problem is not here now, but back then I
did a cat /dev/mouse (which is a symlink to /dev/input/mice) and it did
echo strange characters.

Roel
