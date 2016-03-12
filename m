From: sergk sergk2mail <sergk.admin@gmail.com>
Subject: Re: Chipone icn85xx support in x86 linux kernel
Date: Sat, 12 Mar 2016 22:56:00 +0000
Message-ID: <CA+V1LzrQJguh4Yqi56x1Jv+WJtO+A5B_7N6Q6kPw+_zcU6H8Ng@mail.gmail.com>
References: <CA+V1Lzo4-EBWQcpg9T-BBcF5xqa31_JNOZj-ev56PWe=vuvqZQ@mail.gmail.com>
	<56E1EE3C.6010007@gmail.com>
	<CA+V1LzoHQq71riUOciB2PTLm4-Xk5DO1DA49f2uF9SOk5x_rKA@mail.gmail.com>
	<56E41184.8020006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:34139 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824AbcCLW4C (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 12 Mar 2016 17:56:02 -0500
Received: by mail-qg0-f42.google.com with SMTP id w104so126710305qge.1
        for <linux-input@vger.kernel.org>; Sat, 12 Mar 2016 14:56:01 -0800 (PST)
In-Reply-To: <56E41184.8020006@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gregor Riepl <onitake@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Gregor,
"In general, you should go with the values in the DSDT.
They may be wrong if the manufacturer messed up (it happens), but they are
your best bet. Remember, even the Windows driver needs to get the values
somewhere."

Thanks that you are here!
Suppose also that some one interested in Chipone icn8528 joint too!
Let me start from lyric goal - I could not believe that having working
touch in Android and Windows + some kind of specs + working drivers
and firmware it is not possible to make Chipone icn8528 working in
Linux.
Please someone comment whether I am mistaken in this or not?

Current :( bad news:



Bad news 1
- on Chuwi Vi10 standard method from kernel doc does NOT work :(

I2C serial bus support
~~~~~~~~~~~~~~~~~~~~~~
The slaves behind I2C bus controller only need to add the ACPI IDs like
with the platform and SPI drivers. The I2C core automatically enumerates
any slave devices behind the controller device once the adapter is
registered.

Below is an example of how to add ACPI support to the existing mpu3050
input driver:

#ifdef CONFIG_ACPI
static const struct acpi_device_id mpu3050_acpi_match[] = {
{ "MPU3050", 0 },
{ },
};
MODULE_DEVICE_TABLE(acpi, mpu3050_acpi_match);
#endif

static struct i2c_driver mpu3050_i2c_driver = {
.driver = {
.name = "mpu3050",
.owner = THIS_MODULE,
.pm = &mpu3050_pm,
.of_match_table = mpu3050_of_match,
.acpi_match_table = ACPI_PTR(mpu3050_acpi_match),
},
.probe = mpu3050_probe,
.remove = mpu3050_remove,
.id_table = mpu3050_ids,
};

BAD NEWS 2:

Actually I am not sure if I have waked up chip, BUT at the same I am
stabile receive something on i2c-3 0x30.
This looks like in DSDT ACPI and by analogy with Chuwi vi8 again is a
shift on Baytrail -1 on i2cbus.
The problem is - why I am receiving each time different values for
reading the same addresses on i2c bus?
I mean if I read 0xa address (should be 0x85 - the major version of
the chip) - I receive each time new values but not 0x85! see my posts
with test results.

HOW IT COULD BE  POSSIBLE SO?


Under Windows driver has in its properties values from DSDT like
\\SB.I2c4 and etc.
:( unfrotrunately could not find working utility for Windows to scan
i2cbus and i2cdevices.

Also have read that modern devices could switch their addressed on i2cbus!

Also from android - the only TS module is loaded and present is
atmel_mxt_ts - nm g shows

nm -g atmel_mxt_ts.ko
         U __dynamic_dev_dbg
         U __gpio_set_value
         U __init_waitqueue_head
         U __kmalloc
00000000 D __mod_acpi_device_table
00000180 R __mod_i2c_device_table
         U __mutex_init
00000000 D __this_module
         U _dev_info
         U acpi_get_gpio_by_index
00000000 T cleanup_module
         U complete
         U dev_err
         U dev_get_drvdata
         U dev_set_drvdata
         U dev_warn
         U device_create_file
         U device_remove_file
         U disable_irq
         U enable_irq
         U free_irq
         U gpio_direction_output
         U gpio_export
         U gpio_free
         U gpio_request
         U gpio_set_value_cansleep
         U i2c_del_driver
         U i2c_master_send
         U i2c_register_driver
         U i2c_transfer
00000000 T init_module
         U input_alloc_absinfo
         U input_allocate_device
         U input_event
         U input_free_device
         U input_mt_init_slots
         U input_mt_report_pointer_emulation
         U input_mt_report_slot_state
         U input_register_device
         U input_set_abs_params
         U input_set_capability
         U input_unregister_device
         U kfree
         U kmalloc_caches
         U kmem_cache_alloc_trace
         U krealloc
         U mcount
         U memcpy
         U msecs_to_jiffies
         U msleep
         U mutex_lock
         U mutex_unlock
         U print_hex_dump
         U register_early_suspend
         U register_early_suspend_device
         U regulator_disable
         U regulator_enable
         U regulator_get
         U regulator_put
         U release_firmware
         U request_firmware
         U request_threaded_irq
         U scnprintf
         U snprintf
         U sprintf
         U sscanf
         U strlen
         U strncmp
00000040 D supported_panels
         U sysfs_create_bin_file
         U sysfs_create_group
         U sysfs_notify
         U sysfs_remove_bin_file
         U sysfs_remove_group
         U unregister_early_suspend_device
         U usleep_range
         U wait_for_completion_interruptible_timeout

Regards,
                  Serge Kolotylo.
