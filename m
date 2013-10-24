From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 4/8] input: Remove OOM message after
 input_allocate_device
Date: Thu, 24 Oct 2013 12:20:25 -0700
Message-ID: <1382642425.22433.79.camel@joe-AO722>
References: <cover.1382555436.git.joe@perches.com>
	 <cc5e6a317bc9ef33cfdfae3ed9d3a47b5319a47b.1382555436.git.joe@perches.com>
	 <20131024183707.GA5281@core.coreip.homeip.net>
	 <1382640339.22433.73.camel@joe-AO722>
	 <20131024191032.GA5553@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20131024191032.GA5553@core.coreip.homeip.net>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Wan ZongShun <mcuos.com@gmail.com>, Andrey Moiseev <o2g.org.ru@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Josh Wu <josh.wu@atmel.com>, Ferruh Yigit <fery@cypress.com>, Pau Oliva Fora <pof@eslack.org>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 2013-10-24 at 12:10 -0700, Dmitry Torokhov wrote:
> On Thu, Oct 24, 2013 at 11:45:39AM -0700, Joe Perches wrote:
> > On Thu, 2013-10-24 at 11:37 -0700, Dmitry Torokhov wrote:
> > > Hi Joe,
> > > 
> > > On Wed, Oct 23, 2013 at 12:14:50PM -0700, Joe Perches wrote:
> > > > Emitting an OOM message isn't necessary after input_allocate_device
> > > > as there's a generic OOM and a dump_stack already done.
> > > 
> > > No, please don't. The kzalloc may get changed in the future to not dump
> > > stack (that was added originally because not everyone was handling OOM
> > > properly, right?), input core might get changed to use something else
> > > than kzalloc, etc, etc.
> > > 
> > > The majority of errors use dev_err so we also get idea what device
> > > failed (if there are several), and more.
> > 
> > I think that's not valuable as input_allocate_device already has
> > dozens of locations that don't emit a specific OOM and centralizing
> > the location for any generic message would work anyway.
> 
> Not having diagnostic messages in some of the drivers is hardly a
> justification to remove them from everywhere else.

But standardization is.

If a diagnostic message is really desired
without the already existing dump_stack(),
it's a small matter of adding something like:

 drivers/input/input.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index c044699..98570c2 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1736,19 +1736,23 @@ struct input_dev *input_allocate_device(void)
 {
 	struct input_dev *dev;
 
-	dev = kzalloc(sizeof(struct input_dev), GFP_KERNEL);
-	if (dev) {
-		dev->dev.type = &input_dev_type;
-		dev->dev.class = &input_class;
-		device_initialize(&dev->dev);
-		mutex_init(&dev->mutex);
-		spin_lock_init(&dev->event_lock);
-		INIT_LIST_HEAD(&dev->h_list);
-		INIT_LIST_HEAD(&dev->node);
-
-		__module_get(THIS_MODULE);
+	dev = kzalloc(sizeof(struct input_dev), GFP_KERNEL | __GFP_NOWARN);
+	if (!dev) {
+		pr_err("%pf: input_allocate_device failed\n",
+		       __builtin_return_address(1));
+		return NULL;
 	}
 
+	dev->dev.type = &input_dev_type;
+	dev->dev.class = &input_class;
+	device_initialize(&dev->dev);
+	mutex_init(&dev->mutex);
+	spin_lock_init(&dev->event_lock);
+	INIT_LIST_HEAD(&dev->h_list);
+	INIT_LIST_HEAD(&dev->node);
+
+	__module_get(THIS_MODULE);
+
 	return dev;
 }
 EXPORT_SYMBOL(input_allocate_device);
