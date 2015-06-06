From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: usbtouchscreen: version 0.4
Date: Sat, 6 Jun 2015 19:52:13 +0300
Message-ID: <20150606165213.GA28331@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:19244 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663AbbFFQw2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 6 Jun 2015 12:52:28 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: daniel.ritz-ml@swissonline.ch
Cc: linux-input@vger.kernel.org

Hi Daniel,

I had a question about patch 5d8926658ce4: "usbtouchscreen: version 0.4"
from Jul 31, 2006.

drivers/input/touchscreen/usbtouchscreen.c
  1326  static void usbtouch_process_multi(struct usbtouch_usb *usbtouch,
  1327                                     unsigned char *pkt, int len)
  1328  {
  1329          unsigned char *buffer;
  1330          int pkt_len, pos, buf_len, tmp;
  1331  
  1332          /* process buffer */
  1333          if (unlikely(usbtouch->buf_len)) {
  1334                  /* try to get size */
  1335                  pkt_len = usbtouch->type->get_pkt_len(
  1336                                  usbtouch->buffer, usbtouch->buf_len);

->get_pkt_len() returns -1 on error.

  1337  
  1338                  /* drop? */
  1339                  if (unlikely(!pkt_len))
  1340                          goto out_flush_buf;
  1341  
  1342                  /* need to append -pkt_len bytes before able to get size */
  1343                  if (unlikely(pkt_len < 0)) {
  1344                          int append = -pkt_len;

But then we treat the -1 as a length of 1.  Is that really what we
intended?

  1345                          if (unlikely(append > len))
  1346                                 append = len;
  1347                          if (usbtouch->buf_len + append >= usbtouch->type->rept_size)
  1348                                  goto out_flush_buf;
  1349                          memcpy(usbtouch->buffer + usbtouch->buf_len, pkt, append);
  1350                          usbtouch->buf_len += append;
  1351  
  1352                          pkt_len = usbtouch->type->get_pkt_len(
  1353                                          usbtouch->buffer, usbtouch->buf_len);
  1354                          if (pkt_len < 0)
  1355                                  return;
  1356                  }
  1357  
  1358                  /* append */
  1359                  tmp = pkt_len - usbtouch->buf_len;

regards,
dan carpenter
