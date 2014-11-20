From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v1] Input: elants_i2c: Add Elan touchscreen support
Date: Thu, 20 Nov 2014 09:47:09 -0800
Message-ID: <20141120174709.GA14798@dtor-glaptop>
References: <1388146515-19481-1-git-send-email-scott.liu@emc.com.tw>
 <20141120081113.GA37534@dtor-ws>
 <1416479490.28599.13.camel@linux-0dmf.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:61085 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754913AbaKTRrO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Nov 2014 12:47:14 -0500
Content-Disposition: inline
In-Reply-To: <1416479490.28599.13.camel@linux-0dmf.site>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: scott <scott.liu@emc.com.tw>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Vincent Wang <vincent.wang@emc.com.tw>, Jeff Chuang <jeff.chuang@emc.com.tw>, Benson Leung <bleung@chromium.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, David Herrmann <dh.herrmann@gmail.com>

Hi Oliver,

On Thu, Nov 20, 2014 at 11:31:30AM +0100, Oliver Neukum wrote:
> > +static int elants_i2c_initialize(struct elants_data *ts)
> > +{
> > +       struct i2c_client *client = ts->client;
> > +       int error, retry_cnt;
> > +       const u8 hello_packet[] = { 0x55, 0x55, 0x55, 0x55 };
> > +       const u8 recov_packet[] = { 0x55, 0x55, 0x80, 0x80 };
> > +       u8 buf[HEADER_SIZE];
> > +
> 
> Strictly speaking you should disable preemption here.

Umm, why?

> 
> > +       for (retry_cnt = 0; retry_cnt < MAX_RETRIES; retry_cnt++) {
> > +               error = elants_i2c_sw_reset(client);
> > +               if (error) {
> > +                       /* Continue initializing if it's the last try
> > */
> > +                       if (retry_cnt < MAX_RETRIES - 1)
> > +                               continue;
> > +               }

Thanks.

-- 
Dmitry
