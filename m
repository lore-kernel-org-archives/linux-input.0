From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: Input: cyapa - add gen5 trackpad device basic functions support
Date: Wed, 21 Jan 2015 16:19:49 +0300
Message-ID: <20150121131949.GA4622@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:39220 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562AbbAUNTN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Jan 2015 08:19:13 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dudl@cypress.com
Cc: linux-input@vger.kernel.org

Hello Dudley Du,

This is a semi-automatic email about new static checker warnings.

The patch 6972a859601a: "Input: cyapa - add gen5 trackpad device
basic functions support" from Jan 17, 2015, leads to the following
Smatch complaint:

drivers/input/mouse/cyapa_gen5.c:2564 cyapa_gen5_irq_cmd_handler()
	 warn: variable dereferenced before check 'gen5_pip->resp_len' (see line 2559)

drivers/input/mouse/cyapa_gen5.c
  2558				 */
  2559				length = *gen5_pip->resp_len;
                                         ^^^^^^^^^^^^^^^^^^^
Patch introduces a dereference.

  2560				cyapa_empty_pip_output_data(cyapa,
  2561						gen5_pip->resp_data,
  2562						&length,
  2563						gen5_pip->resp_sort_func);
  2564				if (gen5_pip->resp_len && length != 0) {
                                    ^^^^^^^^^^^^^^^^^^
Patch introduces a check.

  2565					*gen5_pip->resp_len = length;
  2566					atomic_dec(&gen5_pip->cmd_issued);

regards,
dan carpenter
