From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 1/2] char_dev: allow setting up and pinning parent devices
Date: Sun, 21 Oct 2012 08:39:28 +0100
Message-ID: <20121021073928.GV2616@ZenIV.linux.org.uk>
References: <20121019175046.GP2616@ZenIV.linux.org.uk>
 <1350804271-2449-1-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:40632 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667Ab2JUHjc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 21 Oct 2012 03:39:32 -0400
Content-Disposition: inline
In-Reply-To: <1350804271-2449-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Sun, Oct 21, 2012 at 12:24:30AM -0700, Dmitry Torokhov wrote:
> In certain cases (for example when a cdev structure is embedded into
> another object whose lifetime is controlled by a separate device object)
> it is beneficial to tie lifetime of another struct device to the lifetime
> of character device so that related object is not freed until after
> char_dev object is freed. To achieve this allow setting a "parent" device
> for character devices and pin them when doing cdev_add() and unpin when
> last reference to cdev structure is being released.

Why struct device and not simply struct kobject?
