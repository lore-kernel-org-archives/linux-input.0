From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [Bug 203297] Synaptics touchpad TM-3127 functionality broken by
 PCI runtime power management patch on 4.20.2
Date: Mon, 29 Apr 2019 11:36:16 +0300
Message-ID: <e96a7220-974f-1df6-70ee-695ee815057f@linux.intel.com>
References: <20190422130814.GJ173520@google.com>
 <3a1139ef-10ed-6923-73c5-30fbf0c065c3@linux.intel.com>
 <CAO-hwJKvXO6L7m0g1D6wycFP=Wu_qLDyLXTtmm0TkpxT5Z8ygw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------004E56005F75F0C34870FB19"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAO-hwJKvXO6L7m0g1D6wycFP=Wu_qLDyLXTtmm0TkpxT5Z8ygw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Keijo Vaara <ferdasyn@rocketmail.com>, Jean Delvare <jdelvare@suse.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

This is a multi-part message in MIME format.
--------------004E56005F75F0C34870FB19
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/19 10:45 AM, Benjamin Tissoires wrote:
>> I would like to ask help from input subsystem experts what kind of SMBus
>> power state dependency Synaptics RMI4 SMBus devices have since it cease
>> to work if SMBus controllers idles between transfers and how this is
>> best to fix?
> 
> Hmm, I am not sure there is such an existing architecture you could
> use in a simple patch.
> 
> rmi-driver.c does indeed create an input device we could use to toggle
> on/off the PM state, but those callbacks are not wired to the
> transport driver (rmi_smbus.c), so it would required a little bit of
> extra work. And then, there are other RMI4 functions (firmware
> upgrade) that would not be happy if PM is in suspend while there is no
> open input node.
> 
I see.

I got another thought about this. I noticed these input drivers need 
SMBus Host Notify, maybe that explain the PM dependency? If that's the 
only dependency then we could prevent the controller suspend if there is 
a client needing host notify mechanism. IMHO that's less hack than the 
patch to rmi_smbus.c.

Keijo: care to test does this idea would fix the issue (without the 
previous patch)? I also attached the diff.

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 38af18645133..d54eafad7727 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -327,6 +327,8 @@ static int i2c_device_probe(struct device *dev)

  		if (client->flags & I2C_CLIENT_HOST_NOTIFY) {
  			dev_dbg(dev, "Using Host Notify IRQ\n");
+			/* Adapter should not suspend for Host Notify */
+			pm_runtime_get_sync(&client->adapter->dev);
  			irq = i2c_smbus_host_notify_to_irq(client);
  		} else if (dev->of_node) {
  			irq = of_irq_get_byname(dev->of_node, "irq");
@@ -431,6 +433,8 @@ static int i2c_device_remove(struct device *dev)
  	device_init_wakeup(&client->dev, false);

  	client->irq = client->init_irq;
+	if (client->flags & I2C_CLIENT_HOST_NOTIFY)
+		pm_runtime_put(&client->adapter->dev);

  	return status;
  }

> So I think this "hack" (with Mika's comments addressed) should go in
> until someone starts propagating the PM states correctly.
> 
I guess you mean the Rafael's pm_runtime_get_sync() comment?

-- 
Jarkko

--------------004E56005F75F0C34870FB19
Content-Type: text/x-patch;
 name="i2c-core-host-notify-pm.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="i2c-core-host-notify-pm.diff"

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 38af18645133..d54eafad7727 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -327,6 +327,8 @@ static int i2c_device_probe(struct device *dev)
 
 		if (client->flags & I2C_CLIENT_HOST_NOTIFY) {
 			dev_dbg(dev, "Using Host Notify IRQ\n");
+			/* Adapter should not suspend for Host Notify */
+			pm_runtime_get_sync(&client->adapter->dev);
 			irq = i2c_smbus_host_notify_to_irq(client);
 		} else if (dev->of_node) {
 			irq = of_irq_get_byname(dev->of_node, "irq");
@@ -431,6 +433,8 @@ static int i2c_device_remove(struct device *dev)
 	device_init_wakeup(&client->dev, false);
 
 	client->irq = client->init_irq;
+	if (client->flags & I2C_CLIENT_HOST_NOTIFY)
+		pm_runtime_put(&client->adapter->dev);
 
 	return status;
 }

--------------004E56005F75F0C34870FB19--
