From: Dmitry Torokhov <dtor@insightbb.com>
Subject: [PATCH] keyspan_remote - add support for loadable keymaps
Date: Tue, 18 Sep 2007 01:06:48 -0400
Message-ID: <200709180106.48824.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi,

If anyone has this hardware please give this patch a spin.

Thanks!

-- 
Dmitry


Input: keyspan_remote - add support for loadable keymaps

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/misc/keyspan_remote.c |  118 ++++++++++++++++++++----------------
 1 file changed, 67 insertions(+), 51 deletions(-)

Index: linux/drivers/input/misc/keyspan_remote.c
===================================================================
--- linux.orig/drivers/input/misc/keyspan_remote.c
+++ linux/drivers/input/misc/keyspan_remote.c
@@ -46,53 +46,12 @@ MODULE_PARM_DESC(debug, "Enable extra de
 
 #define RECV_SIZE	8	/* The UIA-11 type have a 8 byte limit. */
 
-/* table of devices that work with this driver */
-static struct usb_device_id keyspan_table[] = {
-	{ USB_DEVICE(USB_KEYSPAN_VENDOR_ID, USB_KEYSPAN_PRODUCT_UIA11) },
-	{ }					/* Terminating entry */
-};
-
-/* Structure to store all the real stuff that a remote sends to us. */
-struct keyspan_message {
-	u16	system;
-	u8	button;
-	u8	toggle;
-};
-
-/* Structure used for all the bit testing magic needed to be done. */
-struct bit_tester {
-	u32	tester;
-	int	len;
-	int	pos;
-	int	bits_left;
-	u8	buffer[32];
-};
-
-/* Structure to hold all of our driver specific stuff */
-struct usb_keyspan {
-	char				name[128];
-	char				phys[64];
-	struct usb_device*		udev;
-	struct input_dev		*input;
-	struct usb_interface*		interface;
-	struct usb_endpoint_descriptor* in_endpoint;
-	struct urb*			irq_urb;
-	int				open;
-	dma_addr_t			in_dma;
-	unsigned char*			in_buffer;
-
-	/* variables used to parse messages from remote. */
-	struct bit_tester		data;
-	int				stage;
-	int				toggle;
-};
-
 /*
  * Table that maps the 31 possible keycodes to input keys.
  * Currently there are 15 and 17 button models so RESERVED codes
  * are blank areas in the mapping.
  */
-static const int keyspan_key_table[] = {
+static const unsigned short keyspan_key_table[] = {
 	KEY_RESERVED,		/* 0 is just a place holder. */
 	KEY_RESERVED,
 	KEY_STOP,
@@ -127,6 +86,48 @@ static const int keyspan_key_table[] = {
 	KEY_MENU
 };
 
+/* table of devices that work with this driver */
+static struct usb_device_id keyspan_table[] = {
+	{ USB_DEVICE(USB_KEYSPAN_VENDOR_ID, USB_KEYSPAN_PRODUCT_UIA11) },
+	{ }					/* Terminating entry */
+};
+
+/* Structure to store all the real stuff that a remote sends to us. */
+struct keyspan_message {
+	u16	system;
+	u8	button;
+	u8	toggle;
+};
+
+/* Structure used for all the bit testing magic needed to be done. */
+struct bit_tester {
+	u32	tester;
+	int	len;
+	int	pos;
+	int	bits_left;
+	u8	buffer[32];
+};
+
+/* Structure to hold all of our driver specific stuff */
+struct usb_keyspan {
+	char				name[128];
+	char				phys[64];
+	unsigned short			keymap[ARRAY_SIZE(keyspan_key_table)];
+	struct usb_device		*udev;
+	struct input_dev		*input;
+	struct usb_interface		*interface;
+	struct usb_endpoint_descriptor	*in_endpoint;
+	struct urb*			irq_urb;
+	int				open;
+	dma_addr_t			in_dma;
+	unsigned char			*in_buffer;
+
+	/* variables used to parse messages from remote. */
+	struct bit_tester		data;
+	int				stage;
+	int				toggle;
+};
+
 static struct usb_driver keyspan_driver;
 
 /*
@@ -173,6 +174,15 @@ static int keyspan_load_tester(struct us
 	return 0;
 }
 
+static void keyspan_report_button(struct usb_keyspan *remote, int button, int press)
+{
+	struct input_dev *input = remote->input;
+
+	input_event(input, EV_MSC, MSC_SCAN, button);
+	input_report_key(input, remote->keymap[button], press);
+	input_sync(input);
+}
+
 /*
  * Routine that handles all the logic needed to parse out the message from the remote.
  */
@@ -311,9 +321,8 @@ static void keyspan_check_data(struct us
 			__FUNCTION__, message.system, message.button, message.toggle);
 
 		if (message.toggle != remote->toggle) {
-			input_report_key(remote->input, keyspan_key_table[message.button], 1);
-			input_report_key(remote->input, keyspan_key_table[message.button], 0);
-			input_sync(remote->input);
+			keyspan_report_button(remote, message.button, 1);
+			keyspan_report_button(remote, message.button, 0);
 			remote->toggle = message.toggle;
 		}
 
@@ -491,16 +500,21 @@ static int keyspan_probe(struct usb_inte
 
 	usb_make_path(udev, remote->phys, sizeof(remote->phys));
 	strlcat(remote->phys, "/input0", sizeof(remote->phys));
+	memcpy(remote->keymap, keyspan_key_table, sizeof(remote->keymap));
 
 	input_dev->name = remote->name;
 	input_dev->phys = remote->phys;
 	usb_to_input_id(udev, &input_dev->id);
 	input_dev->dev.parent = &interface->dev;
+	input_dev->keycode = remote->keymap;
+	input_dev->keycodesize = sizeof(unsigned short);
+	input_dev->keycodemax = ARRAY_SIZE(remote->keymap);
 
-	input_dev->evbit[0] = BIT(EV_KEY);		/* We will only report KEY events. */
+	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
+	__set_bit(EV_KEY, input_dev->evbit);
 	for (i = 0; i < ARRAY_SIZE(keyspan_key_table); i++)
-		if (keyspan_key_table[i] != KEY_RESERVED)
-			set_bit(keyspan_key_table[i], input_dev->keybit);
+		__set_bit(keyspan_key_table[i], input_dev->keybit);
+	__clear_bit(KEY_RESERVED, input_dev->keybit);
 
 	input_set_drvdata(input_dev, remote);
 
@@ -508,12 +522,14 @@ static int keyspan_probe(struct usb_inte
 	input_dev->close = keyspan_close;
 
 	/*
-	 * Initialize the URB to access the device. The urb gets sent to the device in keyspan_open()
+	 * Initialize the URB to access the device.
+	 * The urb gets sent to the device in keyspan_open()
 	 */
 	usb_fill_int_urb(remote->irq_urb,
-			 remote->udev, usb_rcvintpipe(remote->udev, remote->in_endpoint->bEndpointAddress),
+			 remote->udev,
+			 usb_rcvintpipe(remote->udev, endpoint->bEndpointAddress),
 			 remote->in_buffer, RECV_SIZE, keyspan_irq_recv, remote,
-			 remote->in_endpoint->bInterval);
+			 endpoint->bInterval);
 	remote->irq_urb->transfer_dma = remote->in_dma;
 	remote->irq_urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 
