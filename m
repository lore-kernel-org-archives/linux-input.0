From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] char_dev: allow setting up and pinning parent devices
Date: Sun, 21 Oct 2012 01:13:29 -0700
Message-ID: <20121021081329.GA1959@core.coreip.homeip.net>
References: <20121019175046.GP2616@ZenIV.linux.org.uk>
 <1350804271-2449-1-git-send-email-dmitry.torokhov@gmail.com>
 <20121021073928.GV2616@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20121021073928.GV2616@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, Oct 21, 2012 at 08:39:28AM +0100, Al Viro wrote:
> On Sun, Oct 21, 2012 at 12:24:30AM -0700, Dmitry Torokhov wrote:
> > In certain cases (for example when a cdev structure is embedded into
> > another object whose lifetime is controlled by a separate device object)
> > it is beneficial to tie lifetime of another struct device to the lifetime
> > of character device so that related object is not freed until after
> > char_dev object is freed. To achieve this allow setting a "parent" device
> > for character devices and pin them when doing cdev_add() and unpin when
> > last reference to cdev structure is being released.
> 
> Why struct device and not simply struct kobject?

It was more convenient for my uses and I also think that parents of
character devices will be struct devices... I however will not insist
and if you prefer using more generic kobject I can change it,

Thanks.

-- 
Dmitry
