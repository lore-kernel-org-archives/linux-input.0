From: sergk sergk2mail <sergk.admin@gmail.com>
Subject: Re: Chipone icn85xx support in x86 linux kernel
Date: Thu, 10 Mar 2016 20:28:23 +0000
Message-ID: <CA+V1Lzo4-EBWQcpg9T-BBcF5xqa31_JNOZj-ev56PWe=vuvqZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:33496 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754256AbcCJU2Z (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Mar 2016 15:28:25 -0500
Received: by mail-qg0-f54.google.com with SMTP id t4so80948811qge.0
        for <linux-input@vger.kernel.org>; Thu, 10 Mar 2016 12:28:24 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gregor Riepl <onitake@gmail.com>
Cc: linux-input@vger.kernel.org

Hi ALL.
Gathered all answers to the received questions in the code.
What I did: Using my experience of gsl1680 (userspace) on Chuwi Vi8
and reviewing code
https://github.com/bbelos/rk3188-kernel/blob/master/drivers/input/touchscreen/ICN8503/icn85xx.c
mentioned in the 1st my message (icn85xx.c) - I have created simple
module i2c client without ACPI that is using define constants for
manually setuping i2cbus (i2c-devX), i2cport and gpio pin then it
trying to wake up icn8528 chip and after trying to read main registers
according mentioned above specs for the chip.

0x000a - IcVersion, should be according Android data (i2cget -f 4 0x48
0x000a b) = 0x85 and is major chip version
0x000c - firmware version, according  Android (i2cget 4 0x48 0x000c b)
it is 0x38


Main goal of this module - just to wakeup chip and read some data from
it to ensure that it is working as expected.
For Gregor: in the code there is hw_init - this is my way (actually
attempt) to wake up the chip, also in the code there is the same but
in kernel space I've sent to you (userspace version) of using gpio.
For simplicity and discussing (read at once)  I have created "all in
one file" without includes and code splitting.

QUESTIONS:

 1) It is strange, but it looks that via Vanilla custom x8_64 Linux
4.4.2 ArchLinux   Baytrail on Chuwi Vi10 the Touchscreen Control Chip
probably resides not on 0x48  and it is resides on i2c-3 0x30. This
confused me completely, AFAIK chip could switch buses but not its
address.
Will be happy if anyone helps with this - whether it is possible for
chip to be i2c-4, 0x48 on Android and switched in Linux to i2c-3 0x30?

Also my discovering:
1.1)  On Chuwi Vi8 for gsl1680 it was only such Android: i2c-4, 0x40
and in Linux: i2c-3, 0x40 - only bus! But not address switching!

1.2) Taking into account decoded ACPI DSDT for Chipone icn8528
(CHPN0001) we see that  I2cSerialBus (0x0030, ControllerInitiated,
0x00061A80,
                            AddressingMode7Bit, "\\_SB.I2C4",
                            0x00, ResourceConsumer, ,
                            )

this makes sence of provided information into item 1.

2) I have not got positive results with my code - and still under
guessing whether I am not successful in waking up the chip or
something other wrong. :( I could not even read correct Chip version
in checking whether hw initialized correct.


3) Results of testing my code with different variations of i2cbus,
port  will be provided in next letter.

4) For Dmitry Torokhov : GPL or not included in main line of the
kernel according mentioned by you conditions for Chipone - I do not
care at the moment - my main goal is very simple - make myself happy
and at least get working touch on my Chuwi Vi10 rev 11 under ArchLinux
and help others owners of Baytrail tablets with TS on chipone icn85xx
to add OS Linux on their tablets.
The most important is very simple thing - to have driver for TS. May
be Chipone even approve farther adding it to the mainline (if it will
be created).
It is sad but Linux in contrast to Android has a lack of drivers for
touchscreen and many other hw of the tablets and this is to my mind is
very strange and reminding early times of 2.xx kernel. ;-) I am trying
to join and change this situation!

Regards,
                 Serge Kolotylo.




---------------- Testing Code:  ------------------------


#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/types.h>
#include <linux/acpi.h>
#include <acpi/acpi_bus.h>
#include <acpi/acpi_drivers.h>
#include <linux/gpio.h>
#include <linux/delay.h>
#include <linux/i2c.h>

#define TS_I2C_BUS 4
#define TS_I2C_ADDR 0x30
#define CTP_RST_PORT 393
#define DRIVER_VERSION "0.0.1"
#define CTP_NAME "chipone-ts"
#define ICN85XX_PROG_IIC_ADDR (0x30)


#define POINT_NUM                   5

#define ICN85XX_WITHOUT_FLASH           0x11
#define ICN85XX_WITH_FLASH              0x22

#define IIC_RETRY_NUM 3


typedef struct _POINT_INFO
{
    unsigned char  u8ID;
    unsigned short u16PosX;     // coordinate X, plus 4 LSBs for
precision extension
    unsigned short u16PosY;     // coordinate Y, plus 4 LSBs for
precision extension
    unsigned char  u8Pressure;
    unsigned char  u8EventId;
}POINT_INFO;


struct icn85xx_ts_data {
    struct i2c_client        *client;
    struct input_dev         *input_dev;
    struct work_struct       pen_event_work;
    struct workqueue_struct  *ts_workqueue;
    struct hrtimer           timer;
    spinlock_t               irq_lock;
    struct semaphore         sem;
    int         ictype;
    int         code_loaded_flag;
    POINT_INFO  point_info[POINT_NUM+1];
    int         point_num;
    int         irq;
    int         irq_is_disable;
    int         use_irq;
    int         work_mode;
    int         screen_max_x;
    int         screen_max_y;
    int         revert_x_flag;
    int         revert_y_flag;
    int         exchange_x_y_flag;
};

static struct i2c_client *this_client;

/***********************************************************************************************
Name    :   icn85xx_i2c_rxdata
Input   :   addr
            *rxdata
            length
Output  :   ret
function    : read data from icn85xx, normal mode
***********************************************************************************************/
int icn85xx_i2c_rxdata(unsigned short addr, char *rxdata, int length){
    int ret = -1;
    int retries = 0;

    unsigned char tmp_buf[2];
    struct i2c_msg msgs[] = {
        {
            .addr   = this_client->addr,
            .flags  = 0,
            .len    = 2,
            .buf    = tmp_buf,
        },
        {
            .addr   = this_client->addr,
            .flags  = I2C_M_RD,
            .len    = length,
            .buf    = rxdata,
        },
    };

    tmp_buf[0] = (unsigned char)(addr>>8);
    tmp_buf[1] = (unsigned char)(addr);
    while(retries < IIC_RETRY_NUM){
        ret = i2c_transfer(this_client->adapter, msgs, 2);
        if(ret == 2)break;
        retries++;
    }

    if (retries >= IIC_RETRY_NUM)
    printk("from %s: i2c read error: %d\n", __func__, ret);

    return ret;

}

/***********************************************************************************************
Name    :   icn85xx_read_reg
Input   :   addr
            pdata
Output  :
function    :   read register of icn85xx, normal mode
***********************************************************************************************/
int icn85xx_read_reg(unsigned short addr, char *pdata)
{
    int ret = -1;
    ret = icn85xx_i2c_rxdata(addr, pdata, 1);
    printk("From %s -  addr: 0x%x: 0x%x\n", __func__,addr, *pdata);
    return ret;
}



/***********************************************************************************************
Name    :   icn85xx_iic_test
Input   :   void
Output  :
function    : 0 success,
***********************************************************************************************/
static int icn85xx_iic_test(void){
    struct icn85xx_ts_data *icn85xx_ts = i2c_get_clientdata(this_client);
    int  ret = -1;
    char value = 0;
    int  retry = 0;
    int  flashid;
    icn85xx_ts->ictype = 0;
//    icn85xx_ts->ictype = ICN85XX_WITHOUT_FLASH;
//    return 1;
    printk("\nbegin %s",__func__);
    printk("\n BEGIN test another way of reading CurrFW ver");
    char mtmp[2];
    ret = icn85xx_i2c_rxdata(0x000c, mtmp, 2);
    short CurVersion;
    CurVersion = (mtmp[0]<<8) | mtmp[1];
    printk("\n CurrFW ver=%hu",CurVersion);

    printk("\n END test another way of reading CurrFW ver");

    while(retry++ < 3)
    {
        ret = icn85xx_read_reg(0xa, &value);
        if( (ret > 0) && (value == 0x85) ){
                icn85xx_ts->ictype = ICN85XX_WITH_FLASH;
            return ret;

        }
        ///////////////////////
        printk("\nBegin read fw ver from iictest");
        ret = icn85xx_read_reg(0xc, &value);
        printk("\nEnd read fw ver from iictest");

        printk("\nBegin read IC subver  from iictest");
        ret = icn85xx_read_reg(0xb, &value);
        printk("\nEnd read IC subver from iictest");

        ///////////////////////
        printk("iic test error! %d in %s\n", retry,__func__);
        msleep(3);
    }

    printk("\nend %s",__func__);
    return ret;
}




static int icn85xx_ts_probe(struct i2c_client *client, const struct
i2c_device_id *id){
    printk("\nhello from i2cprobe,%s",__func__);
    struct icn85xx_ts_data *icn85xx_ts;
    short fwVersion = 0;
    short curVersion = 0;
    int err = 0;
    int retry;

    printk("\n====%s begin=====.  \n", __func__);
    if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
    {
        printk("I2C check functionality failed from %s.\n",__func__);
        return -ENODEV;
    }

    //memdata
    icn85xx_ts = kzalloc(sizeof(*icn85xx_ts), GFP_KERNEL);
    if (!icn85xx_ts)
    {
        printk("Alloc icn85xx_ts memory failed. %s\n",__func__);
        return -ENOMEM;
    }
    memset(icn85xx_ts, 0, sizeof(*icn85xx_ts));
    this_client = client;
    this_client->addr = client->addr;
    i2c_set_clientdata(client, icn85xx_ts);

    icn85xx_ts->work_mode = 0;
    spin_lock_init(&icn85xx_ts->irq_lock);
//    icn85xx_ts->irq_lock = SPIN_LOCK_UNLOCKED;
    err = icn85xx_iic_test();
    if (err <= 0){
        printk("func %s: icn85xx_iic_test  failed.\n",__func__);
        return -1;
    }
    else
        printk("iic communication ok: 0x%x\n", icn85xx_ts->ictype);


    printk("\nBye from i2cprobe,%s",__func__);
return 0;
}


static int  icn85xx_ts_remove(struct i2c_client *client){
return 0;
}



static const struct i2c_device_id icn85xx_ts_id[] = {
    { CTP_NAME, 0 },
    {}
};

MODULE_DEVICE_TABLE(i2c, icn85xx_ts_id);

static struct i2c_driver icn85xx_ts_driver = {
    .class      = I2C_CLASS_HWMON,
    .probe      = icn85xx_ts_probe,
    .remove     = icn85xx_ts_remove,
    .id_table   = icn85xx_ts_id,
    .driver = {
        .name   = CTP_NAME,
        .owner  = THIS_MODULE,
    },
};

static struct i2c_board_info ts_info = {
    .type    = CTP_NAME,
    .addr    =  TS_I2C_ADDR,
};



static int icn85xx_hw_init(void){
    int err = 0;
    err = gpio_request(CTP_RST_PORT, CTP_NAME);
    if ( err ) {
    printk("\nError CTP_RST_PORTgpio in %s ",__func__);
    err = -EINVAL;
    return err;
    }
    err = gpio_direction_output(CTP_RST_PORT, 1);
    if ( err ) {
    printk("\nError CTP_RST_PORTgpiodirection in %s ",__func__);
    err = -EINVAL;
    return err;
    }
    msleep(20);
    gpio_set_value_cansleep(CTP_RST_PORT, 0);
    msleep(100);
    gpio_set_value_cansleep(CTP_RST_PORT, 1);
    msleep(300);
return err;
}

static int __init ts_init(void){
    printk("\nINIT icn MODULE,func %s",__func__);
    printk("\n get pwr gpio in func %s",__func__);
    icn85xx_hw_init();

    struct i2c_adapter *adap = i2c_get_adapter(TS_I2C_BUS);
    printk(KERN_ERR "==icn85xx ts_init %d at i2cbus:
%d!!!!!!!!\n",__LINE__,TS_I2C_BUS);
    i2c_new_device(adap, &ts_info);
    //i2c client reg
    int ret = -1;
    ret = i2c_add_driver(&icn85xx_ts_driver);


return 0;
}



static void __exit ts_exit(void){
    printk("\nEXIT icn MODULE,func:  %s",__func__);
    gpio_free(CTP_RST_PORT);
    i2c_del_driver(&icn85xx_ts_driver);

}


module_init(ts_init);
module_exit(ts_exit);
MODULE_DESCRIPTION("MyICN touchscreen controller driver");
MODULE_AUTHOR("Serge Kolotylo sergk.admin@gmail.com>");
MODULE_VERSION(DRIVER_VERSION);
MODULE_LICENSE("GPL");







On Wed, Mar 2, 2016 at 11:06 PM, sergk sergk2mail <sergk.admin@gmail.com> wrote:
> Would like to add that specs are located
> https://gitlab.com/antruziliak/icn8528.git
> The main question - how to wake up chip.
> Looks that 2 gpios are used INT/WAKE + RST.
> Regards,
>                Serge Kolotylo.
>
> On Tue, Mar 1, 2016 at 10:07 AM, Gregor Riepl <onitake@gmail.com> wrote:
>>> 2) Could be icn8318 by Hans de Goede be adopted for icn85xx?
>>
>> chipone_icn8318.c lacks ACPI support. It may not be difficult to add though.
>>
>> The question is if both chips are sufficiently compatible.
>>
>>> how it is possible to use atmel_mxt_ts module for chipone? or what is the trick?
>>
>> That sounds very odd. Perhaps they share the same control interface?
>> Or perhaps Chipone just cloned the Atmel chips...
>>
>> I'm pretty certain that a specific firmware is required for your chip, though.
>>
