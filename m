From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] TiVo USB IR Dongle support
Date: Mon, 14 Dec 2009 14:28:43 -0800
Message-ID: <20091214222843.GE2373@core.coreip.homeip.net>
References: <20091206214543.GA5290@acer.drzhang.net> <20091212190143.GA3591@acer.drzhang.net> <20091212233259.GB16760@core.coreip.homeip.net> <20091214220059.GA16776@drzhang.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:35039 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932615AbZLNW2v (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Dec 2009 17:28:51 -0500
Received: by pwj9 with SMTP id 9so2219303pwj.21
        for <linux-input@vger.kernel.org>; Mon, 14 Dec 2009 14:28:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091214220059.GA16776@drzhang.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chaogui Zhang <czhang@marywood.edu>
Cc: linux-input@vger.kernel.org

On Mon, Dec 14, 2009 at 05:00:59PM -0500, Chaogui Zhang wrote:
> On Sat, Dec 12, 2009 at 03:32:59PM -0800, Dmitry Torokhov wrote:
> > Hi Chaogui,
> > 
> > On Sat, Dec 12, 2009 at 02:01:43PM -0500, Chaogui Zhang wrote:
> > > +/* Check the inital AGC burst and space value to match the NEC protocol */
> > > +static inline int is_nec(int leadpulse, int leadspace)
> > > +{
> > > +	/* leadpulse should be 9 ms = 9000 us and leadspace should be
> > > +	 * 4.5 ms = 4500 us. We allow +/- 200 microseconds for both.
> > > +	 * Time is measured in units of 50 microseconds.
> > > +	 * 170 == 8800/50, 184 == 9200/50,
> > > +	 * 86 == 4300/50, 94 == 4700/50.
> > > +	 */
> > > +	return (leadpulse >= 170 && leadpulse <= 184) 
> > > +	    && (leadspace >= 86 && leadspace <= 94);
> > 
> > That surely should be '||'. I prefer it at the end too.
> 
> I think it should be && as the protocol specifies both the 9ms AGC burst
> and the 4.5ms space following it.
> 

Ah, yes, I misread the statement and did not see that it involved 2
different variables: leadpulse and leadspace.

> +	{ KE_KEY, 0x28, { KEY_1 } },
> +	{ KE_KEY, 0x29, { KEY_2 } },
> +	{ KE_KEY, 0x2a, { KEY_3 } },
> +	{ KE_KEY, 0x2b, { KEY_4 } },
> +	{ KE_KEY, 0x2c, { KEY_5 } },
> +	{ KE_KEY, 0x2d, { KEY_6 } },
> +	{ KE_KEY, 0x2e, { KEY_7 } },
> +	{ KE_KEY, 0x2f, { KEY_8 } },
> +	{ KE_KEY, 0x30, { KEY_9 } },
> +	{ KE_KEY, 0x31, { KEY_0 } },

Hm, I forgot to mention this in my previous mail - I am trying to move
RC and phones to KEY_NUMERIC_X keycodes which are supposed to be
independent on state of shift and NumLock. I will change it locally -
and if users want old definitions - why, EVIOSKEYCODE now works ;)

> +	{ KE_KEY, 0x32, { KEY_CLEAR } },
> +	{ KE_KEY, 0x33, { KEY_ENTER } },
> +	{ KE_KEY, 0x34, { KEY_VIDEO } },	/* TV Input */
> +	{ KE_KEY, 0x36, { KEY_EPG } },		/* Guide */
> +	{ KE_KEY, 0x44, { KEY_ZOOM } },		/* Aspect */
> +	{ KE_KEY, 0x48, { KEY_STOP } },
> +	{ KE_KEY, 0x4a, { KEY_DVD } },		/* DVD Menu */
> +	{ KE_KEY, 0x5f, { KEY_CYCLEWINDOWS } },	/* Window */
> +	{ KE_END, 0}
> +};
> +
> +/* table of devices that work with this driver */
> +static struct usb_device_id tivoir_table[] = {
> +	{USB_DEVICE(USB_TIVOIR_VENDOR_ID, USB_TIVOIR_PRODUCT_ID)},
> +	{}			/* Terminating entry */
> +};
> +
> +/* Structure to hold all of our driver specific stuff */
> +struct usb_tivoir {
> +	char name[128];
> +	char phys[64];
> +	struct usb_device *udev;
> +	struct input_dev *input;
> +	struct usb_interface *interface;
> +	struct usb_endpoint_descriptor *in_endpoint;
> +	struct urb *irq_urb;
> +	dma_addr_t in_dma;
> +	unsigned char *in_buffer;
> +
> +	/* variables used to parse messages from remote. */
> +	int stage;
> +	int pulse;
> +	int space;
> +	u32 code;	/* 32 bit raw code from the remote */
> +	int repeat;
> +	int bitcount;
> +};
> +
> +static struct usb_driver tivoir_driver;
> +
> +/*
> + * Debug routine that prints out what we've received from the remote.
> + */
> +static void tivoir_print_packet(struct usb_tivoir *remote)
> +{
> +	u8 codes[4 * TIVOIR_RECV_SIZE];
> +	int i, length;
> +
> +	/* The lower 5 bits of the first byte of each packet indicates the size
> +	 * of the transferred buffer, not including the first byte itself.
> +	 */
> +
> +	length = (remote->in_buffer[0]) & 0x1f;
> +	for (i = 0; i <= length; i++)
> +		snprintf(codes + i * 3, 4, "%02x ", remote->in_buffer[i]);
> +
> +	/* 0x80 at the end of a regular packet or in a separate packet
> +	   indicates key release */
> +
> +	if (i < TIVOIR_RECV_SIZE && remote->in_buffer[i] == 0x80)
> +		snprintf(codes + i * 3, 4, "%02x ", remote->in_buffer[i]);
> +
> +	dev_printk(KERN_DEBUG, &remote->udev->dev, "%s: %s\n", __func__, codes);
> +}
> +
> +static inline u16 code_address(u32 code)
> +{
> +	/* Higher 16 bits of the code is the remote address */
> +	return code >> 16;
> +}
> +
> +static inline u8 code_command(u32 code)
> +{
> +	/* Lower 8 bits of the code is the command */
> +	return code & 0xff;
> +}
> +
> +static void tivoir_report_key(struct usb_tivoir *remote)
> +{
> +	struct input_dev *input = remote->input;
> +	struct key_entry *key;
> +
> +
> +	dev_dbg(&remote->udev->dev, "%s: address = 0x%04x, command = 0x%02x\n",
> +		__func__, remote->code >> 16, remote->code & 0xff);
> +
> +	if (code_address(remote->code) == TIVO_REMOTE_ADDR) {
> +		key = sparse_keymap_entry_from_scancode(input,
> +						code_command(remote->code));
> +		if (!key) {	/* invalid code, do nothing */
> +			remote->code = 0;
> +			return;
> +		}
> +		sparse_keymap_report_entry(input, key, 1, !remote->repeat);

Should not this be

		sparse_keymap_report_entry(input, key, remote->repeat, false);

?

In fact remote->repeat  is more like "button down", not necessarily
repeat, right? I also do not see the readon for keeping it in the device
structure, you can simply pass it in tivoir_report_key(), can't you?

Thanks.

-- 
Dmitry
