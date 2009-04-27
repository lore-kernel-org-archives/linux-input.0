From: chang yao chung <yaochung@cic.org.tw>
Subject: problem of writing a virtual ps2 mouse driver
Date: Mon, 27 Apr 2009 15:18:07 +0800
Message-ID: <9A03B08F-52D1-4A83-B060-D0DE111E0064@cic.org.tw>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=WINDOWS-1252;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ns1.cic.org.tw ([140.126.26.1]:44346 "EHLO ns1.cic.edu.tw"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751260AbZD0HSJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Apr 2009 03:18:09 -0400
Received: from pc-victor.cic.edu.tw (pc-victor.cic.edu.tw [140.126.26.115])
	by ns1.cic.edu.tw (8.12.11/8.12.9) with ESMTP id n3R7I86C028572
	for <linux-input@vger.kernel.org>; Mon, 27 Apr 2009 15:18:08 +0800 (CST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi all

I want to write a virtual PS/2 mouse driver to hook to the input core, =
=20
after I load the driver
The psmouse input device driver probes my virtual device as a =93Generi=
c =20
PS/2 mouse=94 in /dev/input/mouse1
And sent a F4 (mouse enable command) to my pseudo device.

I use a user space program to send the following mouse movement packet =
=20
and launch
gpm =96m /dev/input/mouse1 =96t ps2

but when I run the user space program , there is no mouse movement =20
event occurred,
is there anything wrong with my code using serio_interrupt () ?


#include <fcntl.h>

int main()
{
     int fd;
     int x, y;
     char buffer[10];

     fd =3D open ("/sys/devices/platform/dummy/coordinates", O_RDWR);
     if (fd < 0) {
         perror ("open file");
         exit (0);
     }

     while (1) {
         x =3D random () % 20;
         y =3D random () % 20;

         sprintf (buffer, "%d", x, y);
         write (fd, buffer, strlen(buffer));
         fsync (fd);
         sleep (1);
     }

}



/*
  * dummy mouse serio driver for linux
  */

#include <linux/module.h>
#include <linux/init.h>
#include <linux/serio.h>
#include <linux/errno.h>
#include <linux/interrupt.h>
#include <linux/ioport.h>
#include <linux/delay.h>
#include <linux/device.h>
#include <linux/slab.h>
#include <linux/workqueue.h>
#include <linux/spinlock.h>
#include <linux/err.h>
#include <asm/io.h>
#include <asm/irq.h>
#include <asm/system.h>
#include <linux/platform_device.h>

MODULE_AUTHOR("Wisecamera Corp.");
MODULE_DESCRIPTION("dummy ps2 mouse driver");
MODULE_LICENSE("GPL");

static struct serio *dummy_port;
static struct platform_device *dummy_device;
int port_num;

static ssize_t
write_vms (struct device *dev, struct device_attribute *attr, const =20
char *buffer, size_t count)
{
         int x, y;
         sscanf (buffer, "%x", &x);
         serio_interrupt (dev, 0x8, 0 , NULL);
         serio_interrupt (dev, x, NULL);
         serio_interrupt (dev, y, 0, NULL);
         serio_interrupt (dev, 0, 0, NULL);
         return count;
}

/* Attach the sysgs write method */
DEVICE_ATTR (coordinates, 0644, NULL, write_vms);

static struct attribute *vms_attrs [] =3D {
         &dev_attr_coordinates.attr,
         NULL
};

static struct attribute_group vms_attr_group =3D {
         .attrs =3D vms_attrs,
};

static int dummy_open (struct serio *dev)
{
         printk ("dummy open\n");
         serio_interrupt (dev, 0xaa, 0, NULL);
         serio_interrupt (dev, 0x00, 0, NULL);

         return 0;
}

static int dummy_write (struct serio *dev, unsigned char val)
{
         printk ("dummy write %x\n", val);

         switch (val) {
                 case 0xf2:
                         serio_interrupt (dev, 0xfa, 0, NULL);
                         serio_interrupt (dev, 0x00, 0, NULL);
                         break;
                 default:
                         serio_interrupt (dev, 0xfa, 0, NULL);

         }
         return 0;
}


static void dummy_close (struct serio *dev)
{
         printk ("dummy close\n");
         return;
}

static struct serio * __init dummy_allocate_port (void *port_data, =20
char *name, char *phys)
{
         struct serio *serio;

         serio =3D kmalloc(sizeof(struct serio), GFP_KERNEL);
         if (serio)
         {
                 memset(serio, 0, sizeof(struct serio));
                 serio->id.type          =3D SERIO_8042;
                 serio->write             =3D dummy_write;
                 serio->open             =3D dummy_open;
                 serio->close            =3D dummy_close;
                 snprintf(serio->name, sizeof(serio->name), name);
                 snprintf(serio->phys, sizeof(serio->phys), phys);
                 serio->port_data      =3D NULL;
                 serio->dev.parent    =3D &dummy_device->dev;
         }

         return serio;
}

static void __exit dummy_exit (void)
{
         sysfs_remove_group (&dummy_device->dev.kobj, &vms_attr_group);
         serio_unregister_port(dummy_port);
         platform_device_unregister(dummy_device);
}

static int __init dummy_init (void)
{
         char phys[20];
         char name[20];

         dummy_device =3D platform_device_register_simple("dummy", -1, =
=20
NULL, 0);

         if (IS_ERR(dummy_device))
                 return PTR_ERR(dummy_device);

         sysfs_create_group (&dummy_device->dev.kobj, &vms_attr_group);

         sprintf(name, "dummy PS2 mouse port");
         sprintf(phys, "dummy/serio%d", 0);

         if ((dummy_port =3D dummy_allocate_port(NULL, name, phys)) =3D=
=3D =20
NULL)
         {
                 dummy_exit();
                 return -1;
         }

         /* register port */
         serio_register_port(dummy_port);

         return 0;
}

module_init(dummy_init);
module_exit(dummy_exit);

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
