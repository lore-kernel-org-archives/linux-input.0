From: Adrian McMenamin <lkmladrian@gmail.com>
Subject: Re: [PATCH RFC] sh: maple: Add support for SEGA Dreamcast VMU and
	clean up maple bus driver (1/3)
Date: Fri, 30 Jan 2009 09:55:38 +0000
Message-ID: <8b67d60901300155n66f86d4ch875d01cd1620409e@mail.gmail.com>
References: <1233186456.6734.16.camel@localhost.localdomain>
	 <1233187069.6734.21.camel@localhost.localdomain>
	 <20090129031341.GD31096@linux-sh.org>
	 <3ca9ec7a13c1a13ea7be6c37bbdfdb0c.squirrel@newgolddream.dyndns.info>
	 <793692118a2f4bdd17326e8bed6c9792.squirrel@newgolddream.dyndns.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <793692118a2f4bdd17326e8bed6c9792.squirrel@newgolddream.dyndns.info>
Sender: linux-sh-owner@vger.kernel.org
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: Paul Mundt <lethal@linux-sh.org>, Greg KH <greg@kroah.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, dwmw2 <dwmw2@infradead.org>, linux-sh <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

2009/1/29 Adrian McMenamin <adrian@newgolddream.dyndns.info>:
> On Thu, January 29, 2009 4:43 pm, Adrian McMenamin wrote:
>> On Thu, January 29, 2009 3:13 am, Paul Mundt wrote:

>>>>
>>> Please do not abuse P2SEGADDR in this fashion. No new code should be
>>> using P2SEGADDR anyways. maple is particularly abusive in this case
>>> since
>>> it bounces back and forth between P2SEGADDR and PHYSADDR to try and
>>> ignore the fact cache flushing has to be handled.
>>>
>>> You may also wish to consider ioremap/ioremap_nocache().
>>>
>>
>> Can I just use dma_cache_sync before each dma run and then use the P1
>> address space?
>>
>
> After the dma run I mean - the cache is flushed before the run - but not
> after.
>


So I have done this:

Removing P2SEGADDR call and flushing caches
---

diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
index 4d9b8b3..5dca308 100644
--- a/drivers/sh/maple/maple.c
+++ b/drivers/sh/maple/maple.c
@@ -186,7 +186,7 @@ static struct mapleq *maple_allocq(struct
maple_device *mdev)
 	mq->recvbuf = kmem_cache_zalloc(maple_queue_cache, GFP_KERNEL);
 	if (!mq->recvbuf)
 		goto failed_p2;
-	mq->recvbuf->buf = (void *)P2SEGADDR(&((mq->recvbuf->bufx)[0]));
+	mq->recvbuf->buf = &((mq->recvbuf->bufx)[0]);

 	return mq;

@@ -639,9 +639,11 @@ static void maple_dma_handler(struct work_struct *work)
 	ctrl_outl(0, MAPLE_ENABLE);
 	if (!list_empty(&maple_sentq)) {
 		list_for_each_entry_safe(mq, nmq, &maple_sentq, list) {
+			mdev = mq->dev;
 			recvbuf = mq->recvbuf->buf;
+			dma_cache_sync(&mdev->dev, recvbuf, 0x400,
+				DMA_FROM_DEVICE);
 			code = recvbuf[0];
-			mdev = mq->dev;
 			kfree(mq->sendbuf);
 			list_del_init(&mq->list);
 			switch (code) {


Seems to work...
