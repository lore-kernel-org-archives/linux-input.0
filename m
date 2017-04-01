From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 17/33] docs: input/input-programming: convert it to ReST format
Date: Sat,  1 Apr 2017 15:16:00 -0300
Message-ID: <011680ea06ad0b73922b17a6c453d5891bfd5386.1491069870.git.mchehab@s-opensource.com>
References: <cover.1491069870.git.mchehab@s-opensource.com>
 <1756e375bc7fbc9daae3ca1267cb96972d7962a2.1491069870.git.mchehab@s-opensource.com>
 <d22052c26786b30ed6d38f5ddd977be232bca61c.1491069870.git.mchehab@s-opensource.com>
 <f05b5191b0c6d52d5672d5b4dd4f3367580eec03.1491069870.git.mchehab@s-opensource.com>
 <40f1698c0fe55c303f70eac042540c1ce3b76385.1491069870.git.mchehab@s-opensource.com>
 <564bab77d213c4995418de5debc9149f01b44c67.1491069870.git.mchehab@s-opensource.com>
 <e954f11fce1eb50321c88c96cbdb24d87e857108.1491069870.git.mchehab@s-opensource.com>
 <57e5da3e598139b8ab24ff1dda1afaa612bd3e9b.1491069870.git.mchehab@s-opensource.com>
 <55ed0f35fc4dc65436ef2cf4abcf5e458b70add7.1491069870.git.mchehab@s-opensource.com>
 <c1c2d69dddb0f6281452ee3a4db7023c5adbe9a0.1491069870.git.mchehab@s-opensource.com>
 <d3aeee7338003eb50db47a510e4f523d800bcf8c.1491069870.git.mchehab@s-opensource.com>
 <828662d0c5d9fa24a8ccc21f573bf2039a3cb95c.1491069870.git.mchehab@s-opensource.com>
 <ccecd15f5c80b96476fd41c046b19efc9cba28d5.1491069870.git.mchehab@s-opensource.com>
 <0b3e07c981ca9c1e5ac466704bbc96a4bb91b136.1491069870.git.mchehab@s-opensource.com>
 <6af7af2b604dc23c6a1000ec7619f4428622fc7a.1491069870.git.mchehab@s-opensource.com>
 <d02fc4145bff1d73e28317d1bfadeab9394a59cf.1491069870.git.mchehab@s-opensource.com>
 <da8f3bb404822abd36a480d83b7538577010097f.1491069870.git.mchehab@s-opensource.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <da8f3bb404822abd36a480d83b7538577010097f.1491069870.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1491069870.git.mchehab@s-opensource.com>
References: <cover.1491069870.git.mchehab@s-opensource.com>
Sender: linux-doc-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
List-Id: linux-input@vger.kernel.org

This file require minimum adjustments to be a valid ReST file.
Do it, in order to be able to parse it with Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 Documentation/input/input-programming.txt | 253 +++++++++++++++---------------
 1 file changed, 128 insertions(+), 125 deletions(-)

diff --git a/Documentation/input/input-programming.txt b/Documentation/input/input-programming.txt
index 7f8b9d97bc47..4d3b22222e93 100644
--- a/Documentation/input/input-programming.txt
+++ b/Documentation/input/input-programming.txt
@@ -1,77 +1,78 @@
+~~~~~~~~~~~~~~~~~~~~~~~~~
 Programming input drivers
 ~~~~~~~~~~~~~~~~~~~~~~~~~
 
-1. Creating an input device driver
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Creating an input device driver
+===============================
 
-1.0 The simplest example
-~~~~~~~~~~~~~~~~~~~~~~~~
+The simplest example
+~~~~~~~~~~~~~~~~~~~~
 
 Here comes a very simple example of an input device driver. The device has
 just one button and the button is accessible at i/o port BUTTON_PORT. When
-pressed or released a BUTTON_IRQ happens. The driver could look like:
-
-#include <linux/input.h>
-#include <linux/module.h>
-#include <linux/init.h>
-
-#include <asm/irq.h>
-#include <asm/io.h>
-
-static struct input_dev *button_dev;
-
-static irqreturn_t button_interrupt(int irq, void *dummy)
-{
-	input_report_key(button_dev, BTN_0, inb(BUTTON_PORT) & 1);
-	input_sync(button_dev);
-	return IRQ_HANDLED;
-}
-
-static int __init button_init(void)
-{
-	int error;
-
-	if (request_irq(BUTTON_IRQ, button_interrupt, 0, "button", NULL)) {
-                printk(KERN_ERR "button.c: Can't allocate irq %d\n", button_irq);
-                return -EBUSY;
-        }
-
-	button_dev = input_allocate_device();
-	if (!button_dev) {
-		printk(KERN_ERR "button.c: Not enough memory\n");
-		error = -ENOMEM;
-		goto err_free_irq;
-	}
-
-	button_dev->evbit[0] = BIT_MASK(EV_KEY);
-	button_dev->keybit[BIT_WORD(BTN_0)] = BIT_MASK(BTN_0);
-
-	error = input_register_device(button_dev);
-	if (error) {
-		printk(KERN_ERR "button.c: Failed to register device\n");
-		goto err_free_dev;
-	}
-
-	return 0;
-
- err_free_dev:
-	input_free_device(button_dev);
- err_free_irq:
-	free_irq(BUTTON_IRQ, button_interrupt);
-	return error;
-}
-
-static void __exit button_exit(void)
-{
-        input_unregister_device(button_dev);
-	free_irq(BUTTON_IRQ, button_interrupt);
-}
-
-module_init(button_init);
-module_exit(button_exit);
-
-1.1 What the example does
-~~~~~~~~~~~~~~~~~~~~~~~~~
+pressed or released a BUTTON_IRQ happens. The driver could look like::
+
+    #include <linux/input.h>
+    #include <linux/module.h>
+    #include <linux/init.h>
+
+    #include <asm/irq.h>
+    #include <asm/io.h>
+
+    static struct input_dev *button_dev;
+
+    static irqreturn_t button_interrupt(int irq, void *dummy)
+    {
+	    input_report_key(button_dev, BTN_0, inb(BUTTON_PORT) & 1);
+	    input_sync(button_dev);
+	    return IRQ_HANDLED;
+    }
+
+    static int __init button_init(void)
+    {
+	    int error;
+
+	    if (request_irq(BUTTON_IRQ, button_interrupt, 0, "button", NULL)) {
+		    printk(KERN_ERR "button.c: Can't allocate irq %d\n", button_irq);
+		    return -EBUSY;
+	    }
+
+	    button_dev = input_allocate_device();
+	    if (!button_dev) {
+		    printk(KERN_ERR "button.c: Not enough memory\n");
+		    error = -ENOMEM;
+		    goto err_free_irq;
+	    }
+
+	    button_dev->evbit[0] = BIT_MASK(EV_KEY);
+	    button_dev->keybit[BIT_WORD(BTN_0)] = BIT_MASK(BTN_0);
+
+	    error = input_register_device(button_dev);
+	    if (error) {
+		    printk(KERN_ERR "button.c: Failed to register device\n");
+		    goto err_free_dev;
+	    }
+
+	    return 0;
+
+    err_free_dev:
+	    input_free_device(button_dev);
+    err_free_irq:
+	    free_irq(BUTTON_IRQ, button_interrupt);
+	    return error;
+    }
+
+    static void __exit button_exit(void)
+    {
+	    input_unregister_device(button_dev);
+	    free_irq(BUTTON_IRQ, button_interrupt);
+    }
+
+    module_init(button_init);
+    module_exit(button_exit);
+
+What the example does
+~~~~~~~~~~~~~~~~~~~~~
 
 First it has to include the <linux/input.h> file, which interfaces to the
 input subsystem. This provides all the definitions needed.
@@ -85,7 +86,7 @@ and sets up input bitfields. This way the device driver tells the other
 parts of the input systems what it is - what events can be generated or
 accepted by this input device. Our example device can only generate EV_KEY
 type events, and from those only BTN_0 event code. Thus we only set these
-two bits. We could have used
+two bits. We could have used::
 
 	set_bit(EV_KEY, button_dev.evbit);
 	set_bit(BTN_0, button_dev.keybit);
@@ -93,7 +94,7 @@ two bits. We could have used
 as well, but with more than single bits the first approach tends to be
 shorter.
 
-Then the example driver registers the input device structure by calling
+Then the example driver registers the input device structure by calling::
 
 	input_register_device(&button_dev);
 
@@ -102,12 +103,12 @@ calls device handler modules _connect functions to tell them a new input
 device has appeared. input_register_device() may sleep and therefore must
 not be called from an interrupt or with a spinlock held.
 
-While in use, the only used function of the driver is
+While in use, the only used function of the driver is::
 
 	button_interrupt()
 
 which upon every interrupt from the button checks its state and reports it
-via the
+via the::
 
 	input_report_key()
 
@@ -116,7 +117,7 @@ routine isn't reporting two same value events (press, press for example) to
 the input system, because the input_report_* functions check that
 themselves.
 
-Then there is the
+Then there is the::
 
 	input_sync()
 
@@ -125,38 +126,38 @@ This doesn't seem important in the one button case, but is quite important
 for for example mouse movement, where you don't want the X and Y values
 to be interpreted separately, because that'd result in a different movement.
 
-1.2 dev->open() and dev->close()
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+dev->open() and dev->close()
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 In case the driver has to repeatedly poll the device, because it doesn't
 have an interrupt coming from it and the polling is too expensive to be done
 all the time, or if the device uses a valuable resource (eg. interrupt), it
 can use the open and close callback to know when it can stop polling or
 release the interrupt and when it must resume polling or grab the interrupt
-again. To do that, we would add this to our example driver:
+again. To do that, we would add this to our example driver::
 
-static int button_open(struct input_dev *dev)
-{
-	if (request_irq(BUTTON_IRQ, button_interrupt, 0, "button", NULL)) {
-                printk(KERN_ERR "button.c: Can't allocate irq %d\n", button_irq);
-                return -EBUSY;
-        }
+    static int button_open(struct input_dev *dev)
+    {
+	    if (request_irq(BUTTON_IRQ, button_interrupt, 0, "button", NULL)) {
+		    printk(KERN_ERR "button.c: Can't allocate irq %d\n", button_irq);
+		    return -EBUSY;
+	    }
 
-        return 0;
-}
+	    return 0;
+    }
 
-static void button_close(struct input_dev *dev)
-{
-        free_irq(IRQ_AMIGA_VERTB, button_interrupt);
-}
+    static void button_close(struct input_dev *dev)
+    {
+	    free_irq(IRQ_AMIGA_VERTB, button_interrupt);
+    }
 
-static int __init button_init(void)
-{
-	...
-	button_dev->open = button_open;
-	button_dev->close = button_close;
-	...
-}
+    static int __init button_init(void)
+    {
+	    ...
+	    button_dev->open = button_open;
+	    button_dev->close = button_close;
+	    ...
+    }
 
 Note that input core keeps track of number of users for the device and
 makes sure that dev->open() is called only when the first user connects
@@ -166,11 +167,11 @@ disconnects. Calls to both callbacks are serialized.
 The open() callback should return a 0 in case of success or any nonzero value
 in case of failure. The close() callback (which is void) must always succeed.
 
-1.3 Basic event types
-~~~~~~~~~~~~~~~~~~~~~
+Basic event types
+~~~~~~~~~~~~~~~~~
 
 The most simple event type is EV_KEY, which is used for keys and buttons.
-It's reported to the input system via:
+It's reported to the input system via::
 
 	input_report_key(struct input_dev *dev, int code, int value)
 
@@ -188,7 +189,7 @@ events are namely for joysticks and digitizers - devices that do work in an
 absolute coordinate systems.
 
 Having the device report EV_REL buttons is as simple as with EV_KEY, simply
-set the corresponding bits and call the
+set the corresponding bits and call the::
 
 	input_report_rel(struct input_dev *dev, int code, int value)
 
@@ -197,14 +198,14 @@ function. Events are generated only for nonzero value.
 However EV_ABS requires a little special care. Before calling
 input_register_device, you have to fill additional fields in the input_dev
 struct for each absolute axis your device has. If our button device had also
-the ABS_X axis:
+the ABS_X axis::
 
 	button_dev.absmin[ABS_X] = 0;
 	button_dev.absmax[ABS_X] = 255;
 	button_dev.absfuzz[ABS_X] = 4;
 	button_dev.absflat[ABS_X] = 8;
 
-Or, you can just say:
+Or, you can just say::
 
 	input_set_abs_params(button_dev, ABS_X, 0, 255, 4, 8);
 
@@ -218,18 +219,18 @@ If you don't need absfuzz and absflat, you can set them to zero, which mean
 that the thing is precise and always returns to exactly the center position
 (if it has any).
 
-1.4 BITS_TO_LONGS(), BIT_WORD(), BIT_MASK()
-~~~~~~~~~~~~~~~~~~~~~~~~~~
+BITS_TO_LONGS(), BIT_WORD(), BIT_MASK()
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-These three macros from bitops.h help some bitfield computations:
+These three macros from bitops.h help some bitfield computations::
 
 	BITS_TO_LONGS(x) - returns the length of a bitfield array in longs for
 			   x bits
 	BIT_WORD(x)	 - returns the index in the array in longs for bit x
 	BIT_MASK(x)	 - returns the index in a long for bit x
 
-1.5 The id* and name fields
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+The id* and name fields
+~~~~~~~~~~~~~~~~~~~~~~~
 
 The dev->name should be set before registering the input device by the input
 device driver. It's a string like 'Generic button device' containing a
@@ -245,8 +246,8 @@ driver.
 
 The id and name fields can be passed to userland via the evdev interface.
 
-1.6 The keycode, keycodemax, keycodesize fields
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+The keycode, keycodemax, keycodesize fields
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 These three fields should be used by input devices that have dense keymaps.
 The keycode is an array used to map from scancodes to input system keycodes.
@@ -259,14 +260,15 @@ When a device has all 3 aforementioned fields filled in, the driver may
 rely on kernel's default implementation of setting and querying keycode
 mappings.
 
-1.7 dev->getkeycode() and dev->setkeycode()
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+dev->getkeycode() and dev->setkeycode()
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
 getkeycode() and setkeycode() callbacks allow drivers to override default
 keycode/keycodesize/keycodemax mapping mechanism provided by input core
 and implement sparse keycode maps.
 
-1.8 Key autorepeat
-~~~~~~~~~~~~~~~~~~
+Key autorepeat
+~~~~~~~~~~~~~~
 
 ... is simple. It is handled by the input.c module. Hardware autorepeat is
 not used, because it's not present in many devices and even where it is
@@ -274,29 +276,30 @@ present, it is broken sometimes (at keyboards: Toshiba notebooks). To enable
 autorepeat for your device, just set EV_REP in dev->evbit. All will be
 handled by the input system.
 
-1.9 Other event types, handling output events
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Other event types, handling output events
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The other event types up to now are:
 
-EV_LED - used for the keyboard LEDs.
-EV_SND - used for keyboard beeps.
+- EV_LED - used for the keyboard LEDs.
+- EV_SND - used for keyboard beeps.
 
 They are very similar to for example key events, but they go in the other
 direction - from the system to the input device driver. If your input device
 driver can handle these events, it has to set the respective bits in evbit,
-*and* also the callback routine:
+*and* also the callback routine::
 
-	button_dev->event = button_event;
+    button_dev->event = button_event;
 
-int button_event(struct input_dev *dev, unsigned int type, unsigned int code, int value);
-{
-	if (type == EV_SND && code == SND_BELL) {
-		outb(value, BUTTON_BELL);
-		return 0;
-	}
-	return -1;
-}
+    int button_event(struct input_dev *dev, unsigned int type,
+		     unsigned int code, int value)
+    {
+	    if (type == EV_SND && code == SND_BELL) {
+		    outb(value, BUTTON_BELL);
+		    return 0;
+	    }
+	    return -1;
+    }
 
 This callback routine can be called from an interrupt or a BH (although that
 isn't a rule), and thus must not sleep, and must not take too long to finish.
-- 
2.9.3


