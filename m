From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] Input: DT binding: Change touchscreen to touch for use
 with touchscreens and touchpads
Date: Thu, 14 Jan 2016 21:29:14 -0600
Message-ID: <20160115032914.GA31562@rob-hp-laptop>
References: <1452814965-22731-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1452814965-22731-1-git-send-email-aduggan@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Chris Healy <cphealy@gmail.com>, Andrey Gusakov <andrey.gusakov@cogentembedded.com>, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Jan 14, 2016 at 03:42:45PM -0800, Andrew Duggan wrote:
> These generic touchscreen bindings can also be used for touchpads.
> Instead of creating new generic bindings this patch just renames then to
> touch-*.
> 
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> ---
> It was suggested that for the synaptics-rmi4 driver I use the generic
> bindings. But, since the rmi4 driver is used for both touchpads and
> touchscreens it seemed weird to have a touchpad with a parameter
> of touchscreen-inverted-y. I changed all of the references to it in the
> source tree. But, I realize this could cause a backwards compatibilty
> issue with device trees which are not included in the kernel.

It does and you cannot do this. Live with the weirdness or support both 
names...

Rob
