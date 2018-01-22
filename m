From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 5/7] Input: libps2 - add debugging statements
Date: Mon, 22 Jan 2018 10:33:49 -0800
Message-ID: <20180122183349.tsojlsejjvpagxam@dtor-ws>
References: <20180119194111.185590-1-dmitry.torokhov@gmail.com>
 <20180119194111.185590-6-dmitry.torokhov@gmail.com>
 <20180121202230.GB23310@beacon.debie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:39120 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751102AbeAVSdx (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 22 Jan 2018 13:33:53 -0500
Content-Disposition: inline
In-Reply-To: <20180121202230.GB23310@beacon.debie>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ulrik.debie-os@e2big.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Lyude Paul <lyude@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hutterer <peter.hutterer@who-t.net>

H Ulrik,

On Sun, Jan 21, 2018 at 09:22:31PM +0100, ulrik.debie-os@e2big.org wrote:
> 
> Hi,
> 
> the patch series looks nice, but best to also include the procedure
> described here in Documentation/input somewhere. I would not expect
> everyone to dig into git commit logs to find the howto :)

Right now we do not have any notes in kernel on debugging PS/2 devices,
although we have a bunch of tools (ps2emu), etc. I wonder if I can get
Benjamin or Lyude or Hans or Peter write something up as they've been
doing a lot of touchpad bringups...

Thanks.

> 
> Best regards,
> Ulrik
> 
> 
> On Fri, Jan 19, 2018 at 11:41:09AM -0800, Dmitry Torokhov wrote:
> > Date:   Fri, 19 Jan 2018 11:41:09 -0800
> > From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede
> >  <hdegoede@redhat.com>, Lyude Paul <lyude@redhat.com>
> > Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
> > Subject: [PATCH 5/7] Input: libps2 - add debugging statements
> > X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
> > X-Mailing-List: linux-input@vger.kernel.org
> > 
> > Debugging via i8042.debug and analyzing raw PS/2 data stream may be
> > cumbersome as you need to locate the boundaries of commands, decipher the
> > sliced commands, etc, etc. Let's add a bit more high level debug statements
> > for ps2_sendbyte(), ps2_command(), and ps2_sliced_command().
> > 
> > We do not introduce a new module parameter, but rater rely on the kernel
> > having dynamic debug facility enabled (which most everyone has nowadays).
> > Enable with:
> > 
> > echo "file libps2.c +pf" > /sys/kernel/debug/dynamic_debug/control
> > 
> > or add "libps2.dyndbg=+pf" to the kernel command line.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/input/serio/libps2.c | 52 +++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 39 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
> > index e96ae477f0b56..82befae4dab04 100644
> > --- a/drivers/input/serio/libps2.c
> > +++ b/drivers/input/serio/libps2.c
> > @@ -26,22 +26,20 @@ MODULE_AUTHOR("Dmitry Torokhov <dtor@mail.ru>");
> >  MODULE_DESCRIPTION("PS/2 driver library");
> >  MODULE_LICENSE("GPL");
> >  
> > -/*
> > - * ps2_sendbyte() sends a byte to the device and waits for acknowledge.
> > - * It doesn't handle retransmission, though it could - because if there
> > - * is a need for retransmissions device has to be replaced anyway.
> > - *
> > - * ps2_sendbyte() can only be called from a process context.
> > - */
> > -
> > -int ps2_sendbyte(struct ps2dev *ps2dev, u8 byte, unsigned int timeout)
> > +static int ps2_do_sendbyte(struct ps2dev *ps2dev, u8 byte, unsigned int timeout)
> >  {
> > +	int error;
> > +
> >  	serio_pause_rx(ps2dev->serio);
> >  	ps2dev->nak = 1;
> >  	ps2dev->flags |= PS2_FLAG_ACK;
> >  	serio_continue_rx(ps2dev->serio);
> >  
> > -	if (serio_write(ps2dev->serio, byte) == 0)
> > +	error = serio_write(ps2dev->serio, byte);
> > +	if (error)
> > +		dev_dbg(&ps2dev->serio->dev,
> > +			"failed to write %#02x: %d\n", byte, error);
> > +	else
> >  		wait_event_timeout(ps2dev->wait,
> >  				   !(ps2dev->flags & PS2_FLAG_ACK),
> >  				   msecs_to_jiffies(timeout));
> > @@ -52,6 +50,24 @@ int ps2_sendbyte(struct ps2dev *ps2dev, u8 byte, unsigned int timeout)
> >  
> >  	return -ps2dev->nak;
> >  }
> > +
> > +/*
> > + * ps2_sendbyte() sends a byte to the device and waits for acknowledge.
> > + * It doesn't handle retransmission, though it could - because if there
> > + * is a need for retransmissions device has to be replaced anyway.
> > + *
> > + * ps2_sendbyte() can only be called from a process context.
> > + */
> > +
> > +int ps2_sendbyte(struct ps2dev *ps2dev, u8 byte, unsigned int timeout)
> > +{
> > +	int retval;
> > +
> > +	retval = ps2_do_sendbyte(ps2dev, byte, timeout);
> > +	dev_dbg(&ps2dev->serio->dev, "%02x - %x\n", byte, ps2dev->nak);
> > +
> > +	return retval;
> > +}
> >  EXPORT_SYMBOL(ps2_sendbyte);
> >  
> >  void ps2_begin_command(struct ps2dev *ps2dev)
> > @@ -186,6 +202,7 @@ int __ps2_command(struct ps2dev *ps2dev, u8 *param, unsigned int command)
> >  	unsigned int receive = (command >> 8) & 0xf;
> >  	int rc = -1;
> >  	int i;
> > +	u8 send_param[16];
> >  
> >  	if (receive > sizeof(ps2dev->cmdbuf)) {
> >  		WARN_ON(1);
> > @@ -197,6 +214,8 @@ int __ps2_command(struct ps2dev *ps2dev, u8 *param, unsigned int command)
> >  		return -1;
> >  	}
> >  
> > +	memcpy(send_param, param, send);
> > +
> >  	serio_pause_rx(ps2dev->serio);
> >  	ps2dev->flags = command == PS2_CMD_GETID ? PS2_FLAG_WAITID : 0;
> >  	ps2dev->cmdcnt = receive;
> > @@ -210,14 +229,14 @@ int __ps2_command(struct ps2dev *ps2dev, u8 *param, unsigned int command)
> >  	 * ACKing the reset command, and so it can take a long
> >  	 * time before the ACK arrives.
> >  	 */
> > -	if (ps2_sendbyte(ps2dev, command & 0xff,
> > -			 command == PS2_CMD_RESET_BAT ? 1000 : 200)) {
> > +	if (ps2_do_sendbyte(ps2dev, command & 0xff,
> > +			    command == PS2_CMD_RESET_BAT ? 1000 : 200)) {
> >  		serio_pause_rx(ps2dev->serio);
> >  		goto out_reset_flags;
> >  	}
> >  
> >  	for (i = 0; i < send; i++) {
> > -		if (ps2_sendbyte(ps2dev, param[i], 200)) {
> > +		if (ps2_do_sendbyte(ps2dev, param[i], 200)) {
> >  			serio_pause_rx(ps2dev->serio);
> >  			goto out_reset_flags;
> >  		}
> > @@ -253,6 +272,12 @@ int __ps2_command(struct ps2dev *ps2dev, u8 *param, unsigned int command)
> >  	ps2dev->flags = 0;
> >  	serio_continue_rx(ps2dev->serio);
> >  
> > +	dev_dbg(&ps2dev->serio->dev,
> > +		"%02x [%*ph] - %x/%08lx [%*ph]\n",
> > +		command & 0xff, send, send_param,
> > +		ps2dev->nak, ps2dev->flags,
> > +		receive, param ?: send_param);
> > +
> >  	return rc;
> >  }
> >  EXPORT_SYMBOL(__ps2_command);
> > @@ -296,6 +321,7 @@ int ps2_sliced_command(struct ps2dev *ps2dev, u8 command)
> >  	}
> >  
> >  out:
> > +	dev_dbg(&ps2dev->serio->dev, "%02x - %d\n", command, retval);
> >  	ps2_end_command(ps2dev);
> >  	return retval;
> >  }
> > -- 
> > 2.16.0.rc1.238.g530d649a79-goog
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-input" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Dmitry
