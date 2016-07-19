From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v3 1/8] Input: synaptics-rmi4: Use of_get_child_by_name()
 instead of of_find_node_by_name()
Date: Tue, 19 Jul 2016 11:37:15 +0200
Message-ID: <20160719093714.GU4663@mail.corp.redhat.com>
References: <1468476488-7935-1-git-send-email-aduggan@synaptics.com>
 <20160718144820.GL4663@mail.corp.redhat.com>
 <578D627C.3020800@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35834 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753160AbcGSJhW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Jul 2016 05:37:22 -0400
Content-Disposition: inline
In-Reply-To: <578D627C.3020800@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Vincent Huang <vincent.huang@tw.synaptics.com>, Nick Dyer <nick@shmanahar.org>, Chris Healy <cphealy@gmail.com>

On Jul 18 2016 or thereabouts, Andrew Duggan wrote:
> On 07/18/2016 07:48 AM, Benjamin Tissoires wrote:
> >On Jul 13 2016 or thereabouts, Andrew Duggan wrote:
> >>Calling of_find_node_by_name() assumes that the caller has incremented
> >>the refcount of the of_node being passed in. Currently, the caller is
> >>not incrementing the refcount of the of_node which results in the node
> >>being prematurely freed when of_find_node_by_name() calls of_node_put()
> >>on it. Instead use of_get_child_by_name() which does not call put on the
> >>of_node.
> >There are 2 other differences in using of_get_child_by_name() in place
> >of of_find_node_by_name(). One is that now we are following the OF tree
> >while the spinlock is not held. I think it's fine in our case. The
> >other difference is that the returned of_node has not been called
> >of_node_get() on it. I am not 100% sure, but I think it might be good to
> >call of_node_get() on the of node here, and in remove call
> >of_node_put(), just to be sure we don't use the of_node while it has
> >been freed.
> 
> The comment for of_get_child_by_name() says that it returns an of_node with
> the refcount incremented (drivers/of/base.c:717). Also, that the caller
> needs to call of_node_put() when finished with it. I take that to mean that
> the of_node_get() has been done for me by of_get_child_by_name(). Then
> rmi_unregister_function() calls of_node_put() when unregistered the function
> device undoing of_get_child_by_name()'s increment of the refcount.
> 
> Unless I am missing something I think the current implementation is correct.
> Hopefully, it is since this patch has already landed in Linus's tree.

Oh, then OK. Sorry for coming late in the party then :)

Cheers,
Benjamin

> 
> Andrew
> 
> >
> >Cheers,
> >Benjamin
> >
> >>Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> >>---
> >>  drivers/input/rmi4/rmi_bus.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >>diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
> >>index b368b05..253df96 100644
> >>--- a/drivers/input/rmi4/rmi_bus.c
> >>+++ b/drivers/input/rmi4/rmi_bus.c
> >>@@ -157,11 +157,11 @@ static int rmi_function_match(struct device *dev, struct device_driver *drv)
> >>  static void rmi_function_of_probe(struct rmi_function *fn)
> >>  {
> >>  	char of_name[9];
> >>+	struct device_node *node = fn->rmi_dev->xport->dev->of_node;
> >>  	snprintf(of_name, sizeof(of_name), "rmi4-f%02x",
> >>  		fn->fd.function_number);
> >>-	fn->dev.of_node = of_find_node_by_name(
> >>-				fn->rmi_dev->xport->dev->of_node, of_name);
> >>+	fn->dev.of_node = of_get_child_by_name(node, of_name);
> >>  }
> >>  #else
> >>  static inline void rmi_function_of_probe(struct rmi_function *fn)
> >>-- 
> >>2.5.0
> >>
> 
