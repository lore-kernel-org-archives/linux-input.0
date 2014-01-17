From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/4] Input: synaptics-rmi4 - switch to using
 i2c_transfer()
Date: Thu, 16 Jan 2014 16:35:31 -0800
Message-ID: <20140117003531.GE837@core.coreip.homeip.net>
References: <1389339867-8399-1-git-send-email-dmitry.torokhov@gmail.com>
 <1389339867-8399-4-git-send-email-dmitry.torokhov@gmail.com>
 <52D4F4C7.8000706@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52D4F4C7.8000706@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Linux Input <linux-input@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Jan 14, 2014 at 12:26:47AM -0800, Christopher Heiny wrote:
> On 01/09/2014 11:44 PM, Dmitry Torokhov wrote:
> >
> >-	dev_dbg(&client->dev, "writes 1 bytes: %02x\n", txbuf[0]);
> >+	retval = i2c_transfer(client->adapter, msgs, sizeof(msgs));
> >+	if (retval == sizeof(msgs))
> 
> I think this should be:
> 	retval = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
> 	if (retval == ARRAY_SIZE(msgs))
> At least, that change resolved some random misbehaviors, including
> kernel panics.

You are absolutely right, I just committed a fix for that.

Thanks.

-- 
Dmitry
