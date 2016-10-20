From: Nick Dyer <nick@shmanahar.org>
Subject: Re: [-next, 1/2] Input: synaptics-rmi4 - add support for F55 sensor
 tuning
Date: Thu, 20 Oct 2016 23:51:07 +0100
Message-ID: <20161020225107.GA13204@lava.h.shmanahar.org>
References: <1475292168-20961-1-git-send-email-linux@roeck-us.net>
 <20161017213008.GA20263@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avasout06.plus.net ([212.159.14.18]:51989 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756654AbcJTWvO (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 20 Oct 2016 18:51:14 -0400
Content-Disposition: inline
In-Reply-To: <20161017213008.GA20263@roeck-us.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chris Healy <cphealy@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hans.verkuil@cisco.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Mon, Oct 17, 2016 at 02:30:08PM -0700, Guenter Roeck wrote:
> On Fri, Sep 30, 2016 at 08:22:47PM -0700, Guenter Roeck wrote:
> > Sensor tuning support is needed to determine the number of enabled
> > tx and rx electrodes for use in F54 functions.
> > 
> > The number of enabled electrodes is not identical to the total number
> > of electrodes as reported with F55:Query0 and F55:Query1. It has to be
> > calculated by analyzing F55:Ctrl1 (sensor receiver assignment) and
> > F55:Ctrl2 (sensor transmitter assignment).
> > 
> > Support for additional sensor tuning functions may be added later.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> Ping ... any comments on this patch and on
> https://patchwork.kernel.org/patch/9359061/ ?
> 
> Both patches now apply to mainline.
> 
> Thanks,
> Guenter

Hi Guenter-

I've reviewed and tested (on S7300 and S7813) both these patches now
- you can add my sign-off.

However, on the S7813 firmware, F55 is on PDT page 3, and nothing
on page 2, so the default behaviour of the mainline driver means it is
not initialised.

So I think we need to revert this change in mainline:
https://patchwork.kernel.org/patch/3796971/

See below the PDT scan with it reverted and some debug added.

Christopher/Andrew: is there a better heuristic than scanning all 255
pages, given that some firmwares contain gaps?

cheers

Nick

[    2.181199] rmi4_physical rmi4-00: Creating functions.
[    2.181210] rmi4_physical rmi4-00: rmi_scan_pdt page 0
[    2.181221] rmi4_physical rmi4-00: rmi_scan_pdt_page addr 233
[    2.182218] rmi4_physical rmi4-00: rmi_read_pdt_entry: F34 V2
[    2.182230] rmi4_physical rmi4-00: Initializing F34.
[    2.182325] rmi4_physical rmi4-00: Registered F34.
[    2.182337] rmi4_physical rmi4-00: rmi_scan_pdt_page addr 227
[    2.183003] rmi4_physical rmi4-00: rmi_read_pdt_entry: F01 V0
[    2.183014] rmi4_physical rmi4-00: Initializing F01.
[    2.187358] rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer: Synaptics, product: s7813, fw id: 2174259
[    2.198822] rmi4_physical rmi4-00: Registered F01.
[    2.198834] rmi4_physical rmi4-00: rmi_scan_pdt_page addr 221
[    2.199494] rmi4_physical rmi4-00: rmi_read_pdt_entry: F12 V0
[    2.199505] rmi4_physical rmi4-00: Initializing F12.
[    2.199612] rmi4_f12 rmi4-00.fn12: rmi_f12_probe
[    2.210721] rmi4_physical rmi4-00: Registered F12.
[    2.210732] rmi4_physical rmi4-00: rmi_scan_pdt_page addr 215
[    2.211393] rmi4_physical rmi4-00: rmi_read_pdt_entry: F00 V0
[    2.211404] rmi4_physical rmi4-00: rmi_scan_pdt_page end of page
[    2.211414] rmi4_physical rmi4-00: rmi_scan_pdt page 1
[    2.211424] rmi4_physical rmi4-00: rmi_scan_pdt_page addr 489
[    2.212419] rmi4_physical rmi4-00: rmi_read_pdt_entry: F54 V0
[    2.212431] rmi4_physical rmi4-00: Initializing F54.
[    2.214241] rmi4_f54 rmi4-00.fn54: F54 num_rx_electrodes: 60
[    2.214253] rmi4_f54 rmi4-00.fn54: F54 num_tx_electrodes: 36
[    2.214263] rmi4_f54 rmi4-00.fn54: F54 capabilities: 0x44
[    2.214274] rmi4_f54 rmi4-00.fn54: F54 clock rate: 0x5aa0
[    2.214283] rmi4_f54 rmi4-00.fn54: F54 family: 0x2
[    2.214695] rmi4_physical rmi4-00: Registered F54.
[    2.214708] rmi4_physical rmi4-00: rmi_scan_pdt_page addr 483
[    2.215372] rmi4_physical rmi4-00: rmi_read_pdt_entry: F00 V0
[    2.215384] rmi4_physical rmi4-00: rmi_scan_pdt_page end of page
[    2.215395] rmi4_physical rmi4-00: rmi_scan_pdt page 2
[    2.215405] rmi4_physical rmi4-00: rmi_scan_pdt_page addr 745
[    2.216404] rmi4_physical rmi4-00: rmi_read_pdt_entry: F00 V0
[    2.216415] rmi4_physical rmi4-00: rmi_scan_pdt_page end of page
[    2.216426] rmi4_physical rmi4-00: rmi_scan_pdt page 3
[    2.216436] rmi4_physical rmi4-00: rmi_scan_pdt_page addr 1001
[    2.217431] rmi4_physical rmi4-00: rmi_read_pdt_entry: F55 V0
[    2.217442] rmi4_physical rmi4-00: Initializing F55.
[    2.224189] rmi4_f55 rmi4-00.fn55: F55 num_rx_electrodes: 48 (raw 60)
[    2.224201] rmi4_f55 rmi4-00.fn55: F55 num_tx_electrodes: 30 (raw 36)
[    2.224220] rmi4_physical rmi4-00: Registered F55.
[    2.224231] rmi4_physical rmi4-00: rmi_scan_pdt_page addr 995
[    2.224889] rmi4_physical rmi4-00: rmi_read_pdt_entry: F00 V0
[    2.224900] rmi4_physical rmi4-00: rmi_scan_pdt_page end of page
[    2.224911] rmi4_physical rmi4-00: rmi_scan_pdt page 4
[    2.224921] rmi4_physical rmi4-00: rmi_scan_pdt_page addr 1257
[    2.225915] rmi4_physical rmi4-00: rmi_read_pdt_entry: F51 V1
[    2.225927] rmi4_physical rmi4-00: Initializing F51.
[    2.226005] rmi4_physical rmi4-00: Registered F51.
[    2.226016] rmi4_physical rmi4-00: rmi_scan_pdt_page addr 1251
[    2.226677] rmi4_physical rmi4-00: rmi_read_pdt_entry: F00 V0
[    2.226689] rmi4_physical rmi4-00: rmi_scan_pdt_page end of page
[    2.226699] rmi4_physical rmi4-00: rmi_scan_pdt page 5
