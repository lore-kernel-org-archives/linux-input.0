From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 1/2] char_dev: pin parent kobject
Date: Mon, 22 Oct 2012 06:42:28 +0100
Message-ID: <20121022054228.GX2616@ZenIV.linux.org.uk>
References: <20121021073928.GV2616@ZenIV.linux.org.uk>
 <1350867440-6109-1-git-send-email-dmitry.torokhov@gmail.com>
 <CA+55aFyg_TtKn5ikYBm2i3uSRwjskY1Rowj3mNZ285hh8hKWDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:45994 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753576Ab2JVFmd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Oct 2012 01:42:33 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFyg_TtKn5ikYBm2i3uSRwjskY1Rowj3mNZ285hh8hKWDA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Mon, Oct 22, 2012 at 08:02:12AM +0300, Linus Torvalds wrote:
> This series looks good to me, and looks to fix the issue about as
> cleanly as it can. Al, holler if you have any concerns, but I'm
> planning on applying it ASAP,

Add my ACKed-by.  And from the look of it, we'll need something similar
at least in drivers/mtd/ubi in addition to evdev patch.
