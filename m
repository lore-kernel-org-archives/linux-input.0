From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
Subject: Re: usbtouchscreen: version 0.4
Date: Sun, 07 Jun 2015 02:25:17 +0200
Message-ID: <55738F6D.10001@swissonline.ch>
References: <20150606165213.GA28331@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fep12.mx.upcmail.net ([62.179.121.32]:60486 "EHLO
	fep12.mx.upcmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbbFGBMf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 6 Jun 2015 21:12:35 -0400
In-Reply-To: <20150606165213.GA28331@mwanda>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-input@vger.kernel.org

Hi Dan

On 2015-06-06 18:52 , Dan Carpenter wrote:
> Hi Daniel,
>
> I had a question about patch 5d8926658ce4: "usbtouchscreen: version 0.4"
> from Jul 31, 2006.
That's ancient :)
>
> drivers/input/touchscreen/usbtouchscreen.c
>   1326  static void usbtouch_process_multi(struct usbtouch_usb *usbtouch,
>   1327                                     unsigned char *pkt, int len)
>   1328  {
>   1329          unsigned char *buffer;
>   1330          int pkt_len, pos, buf_len, tmp;
>   1331  
>   1332          /* process buffer */
>   1333          if (unlikely(usbtouch->buf_len)) {
>   1334                  /* try to get size */
>   1335                  pkt_len = usbtouch->type->get_pkt_len(
>   1336                                  usbtouch->buffer, usbtouch->buf_len);
>
> ->get_pkt_len() returns -1 on error.

No, it doesn't and never has. In 62aa366d9b015 I added a bit of documentation:

/*
 * used to get the packet len. possible return values:
 * > 0: packet len
 * = 0: skip one byte
 * < 0: -return value more bytes needed
 */
int (*get_pkt_len) (unsigned char *pkt, int len);

So -1 means "need one more byte for a complete data packet". That byte will be
in delivered in the next invocation of usbtouch_irq(). One "touchscreen data packet"
can be split across multiple "usb packets" for some devices.

regards
-Daniel

