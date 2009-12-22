From: Andi Kleen <andi@firstfloor.org>
Subject: Re: 2.6.32.1: BUG and panic: unable to handle kernel NULL pointer
	dereference at 000000000000001f
Date: Tue, 22 Dec 2009 19:42:15 +0100
Message-ID: <20091222184215.GJ10314@basil.fritz.box>
References: <20091215162736.GS13850@anguilla.noreply.org> <871vindxkv.fsf@basil.nowhere.org> <20091222183354.GM13850@anguilla.noreply.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:58470 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbZLVSmT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Dec 2009 13:42:19 -0500
Content-Disposition: inline
In-Reply-To: <20091222183354.GM13850@anguilla.noreply.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>, linux-kernel@vger.kernel.org, DSA <debian-admin@lists.debian.org>, linux-input@vger.kernel.org

> This is a static kernel - no module support.  Anyway, I also tried
> without CONFIG_USB_HID (which pulls in all the other HID_* things) but
> no luck.

Try a make distclean + rebuild anyways.

-Andi
-- 
ak@linux.intel.com -- Speaking for myself only.
