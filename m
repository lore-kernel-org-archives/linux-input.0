From: Jarod Wilson <jarod@redhat.com>
Subject: Re: Hacking on ati_remote driver
Date: Sun, 26 Sep 2010 15:22:26 -0400
Message-ID: <20100926192226.GA24012@redhat.com>
References: <20100923012720.14819.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32899 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758062Ab0IZTWe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 26 Sep 2010 15:22:34 -0400
Content-Disposition: inline
In-Reply-To: <20100923012720.14819.qmail@science.horizon.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: George Spelvin <linux@horizon.com>
Cc: linux-input@vger.kernel.org

On Wed, Sep 22, 2010 at 09:27:20PM -0400, George Spelvin wrote:
> I dusted off my ATI all-in-wonder remote and was trying to get it to
> work with VLC (so far unsuccessfully; I'm still untangling the
> multiple mapping layers between hardware scancode and X event), and
> I had a look at the ati_remote.c driver.
> 
> I started hacking on it.  Mostly I thought the ati_remote_tbl[]
> array was wastefully large.  It gets a lot simpler when you
> realize that, in the 4-byte report, data[1] is actually a checksum
> and not part of the keycode.  data[1] = data[2] + data[3] + 0xE5.
> 
> Having looked over the input layer documentation, I have decided that
> the ati_remote driver could use some love.  I'd like to convert it to
> use the generic scancode to keycode mapping and autorepeat logic.

IMO, ati_remote.c and ati_remote2.c should be adapted to use the ir-core
(soon to be rc-core) interfaces. I've got remote2 hardware myself, so
doing the conversion for that driver is already on my personal TODO list,
but its a long queue of more important things ahead of it first...

-- 
Jarod Wilson
jarod@redhat.com

