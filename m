From: Cameron Gutman <aicommander@gmail.com>
Subject: Synaptics RMI4 touchpad regression in 4.11-rc1
Date: Sat, 11 Mar 2017 17:55:58 -0800
Message-ID: <375e67b5-2cb8-3491-1d71-d8650d6e9451@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: benjamin.tissoires@redhat.com, aduggan@synaptics.com, nick@shmanahar.org, cheiny@synaptics.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

Beginning in 4.11-rc1, it looks like RMI4 is binding to my XPS 13 9443's
Synaptics touchpad and dropping some errors into dmesg. Here are the
messages that seem RMI-related:

rmi4_f34 rmi4-00.fn34: rmi_f34v7_probe: Unrecognized bootloader version
rmi4_f34: probe of rmi4-00.fn34 failed with error -22
rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer: Synaptics, product: TM3038-001, fw id: 1832324
input: Synaptics TM3038-001 as /devices/pci0000:00/INT3433:00/i2c-7/i2c-DLL0665:01/0018:06CB:76AD.0001/input/input19
hid-rmi 0018:06CB:76AD.0001: input,hidraw0: I2C HID v1.00 Mouse [DLL0665:01 06CB:76AD] on i2c-DLL0665:01

Since "Unrecognized bootloader version" isn't a really helpful message, I
applied the attached patch to print the bootloader version which gave
me the following:

rmi4_f34 rmi4-00.fn34: rmi_f34v7_probe: Unrecognized bootloader version: 16

I don't really know what to make of that. It seem very different than the
values the existing code expects.


Compared to hid-multitouch, the RMI stack seems to have completely broken
palm rejection and introduced some random jumpiness during fine pointing
motions. I don't know if these issues are caused by the above errors or
are a separate issue.

The affected machine is an XPS 13 9443 running Fedora 25 with 4.11-rc1 
and libinput 1.6.3-3.fc25 (latest in F25).

Let me know any additional info you'd like.

Regards,
Cameron

----
diff --git a/drivers/input/rmi4/rmi_f34v7.c b/drivers/input/rmi4/rmi_f34v7.c
index 56c6c39..b458cb3 100644
--- a/drivers/input/rmi4/rmi_f34v7.c
+++ b/drivers/input/rmi4/rmi_f34v7.c
@@ -1369,8 +1369,8 @@ int rmi_f34v7_probe(struct f34_data *f34)
 	} else if (f34->bootloader_id[1] == 7) {
 		f34->bl_version = 7;
 	} else {
-		dev_err(&f34->fn->dev, "%s: Unrecognized bootloader version\n",
-				__func__);
+		dev_err(&f34->fn->dev, "%s: Unrecognized bootloader version: %u\n",
+				__func__, f34->bootloader_id[1]);
 		return -EINVAL;
 	}
