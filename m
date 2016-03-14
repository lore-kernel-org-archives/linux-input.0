From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: Input: synaptics-rmi4 - add support for Synaptics RMI4 devices
Date: Mon, 14 Mar 2016 23:45:18 +0300
Message-ID: <20160314204518.GA29433@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:35177 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbcCNUp1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Mar 2016 16:45:27 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: aduggan@synaptics.com
Cc: linux-input@vger.kernel.org

Hello Andrew Duggan,

The patch 2b6a321da9a2: "Input: synaptics-rmi4 - add support for
Synaptics RMI4 devices" from Mar 10, 2016, leads to the following
static checker warning:

	drivers/input/rmi4/rmi_driver.c:129 process_one_interrupt()
	warn: this array is probably non-NULL. 'fn->irq_mask'

drivers/input/rmi4/rmi_driver.c
   120  static void process_one_interrupt(struct rmi_driver_data *data,
   121                                    struct rmi_function *fn)
   122  {
   123          struct rmi_function_handler *fh;
   124  
   125          if (!fn || !fn->dev.driver)
   126                  return;
   127  
   128          fh = to_rmi_function_handler(fn->dev.driver);
   129          if (fn->irq_mask && fh->attention) {
                    ^^^^^^^^^^^^
Always true.

   130                  bitmap_and(data->fn_irq_bits, data->irq_status, fn->irq_mask,
   131                                  data->irq_count);
   132                  if (!bitmap_empty(data->fn_irq_bits, data->irq_count))
   133                          fh->attention(fn, data->fn_irq_bits);
   134          }
   135  }

See also:
drivers/input/rmi4/rmi_driver.c:175 rmi_process_interrupt_requests() warn: this array is probably non-NULL. 'entry->irq_mask'


regards,
dan carpenter
