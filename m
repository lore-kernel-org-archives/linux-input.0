From: Andrey Moiseev <o2g.org.ru@gmail.com>
Subject: input: i8042 possible bug
Date: Tue, 03 Sep 2013 21:39:10 +0400
Message-ID: <52261EBE.5010007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Here is an extract from drivers/input/serio/i8042.c:
> 
> static int i8042_flush(void)
> {
> 	unsigned long flags;
> 	unsigned char data, str;
> 	int i = 0;
> 
> 	spin_lock_irqsave(&i8042_lock, flags);
> 
> 	while (((str = i8042_read_status()) & I8042_STR_OBF) && (i < I8042_BUFFER_SIZE)) {
> 		udelay(50);
> 		data = i8042_read_data();
> 		i++;
> 		dbg("%02x <- i8042 (flush, %s)\n",
> 		    data, str & I8042_STR_AUXDATA ? "aux" : "kbd");
> 	}
> 
> 	spin_unlock_irqrestore(&i8042_lock, flags);
> 
> 	return i;
> }
> 
> static int i8042_controller_check(void)
> {
> 	if (i8042_flush() == I8042_BUFFER_SIZE) {
Doesn't it panic needlessly, while the buffer was initially full?
> 		pr_err("No controller found\n");
> 		return -ENODEV;
> 	}
> 
> 	return 0;
> }
