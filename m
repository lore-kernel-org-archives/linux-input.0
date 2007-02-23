From: "Milind Dere" <milind_dere@persistent.co.in>
Subject: RE: [PATCH] PXA27x keyboard support
Date: Fri, 23 Feb 2007 17:51:28 +0530
Message-ID: <000001c75745$2f3b3dc0$af08f40a@persistent.co.in>
References: <20061120155518.GA6910@enneenne.com><20061120160516.GC6910@enneenne.com><200611240109.22900.dtor@insightbb.com> <20070222224701.GB6179@enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070222224701.GB6179@enneenne.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: 'Rodolfo Giometti' <giometti@enneenne.com>, 'Dmitry Torokhov' <dtor@insightbb.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, 'Nicolas Pitre' <nico@cam.org>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: linux-input@vger.kernel.org

Hi All!
I just made the AT91RM9200-EK board and successfully place the Uboot and
Linux2.4 
But now I want to go for Linux 2.6 version and also I successfully compiled
the Linux 2.6 version and
Now I am trying to download into the board but I amgetting following error
you can see at the last two lines 
Anyone can help me out to solve this problem.
I am just attaching whole procees after Reset the board It starts
Now...............

Low Level Init performed                        


boot 1.0 (Nov 25 2003 - 23:08:05)                                 

Uncompressing image...                      


Low Level Init performed                        


boot 1.0 (Nov 25 2003 - 23:08:05)                                 

Uncompressing image...                    



U-Boot 1.1.1 (Oct  2 2004 - 19:04:01)                                     

U-Boot code: 21F00000 -> 21F16DF0  BSS: -> 21F1B4AC

RAM Configuration:                  
Bank #0: 20000000 32 MB                       
Atmel: AT49BV6416 (64Mbit)                          
Flash:  8 MB            
DataFlash:AT45DB642                   
Nb pages:   8192                
Page Size:   1056                 
Size= 8650752 bytes                   
Logical address: 0xC0000000                           
Area 0: C0000000 to C0007FFF (RO)                                 
Area 1: C0008000 to C001FFFF (RO)                                 
Area 2: C0020000 to C0027FFF                            
Area 3: C0028000 to C083FFFF                            
In:    serial             
Out:   serial             
Err:   serial             
Uboot> setenv ramdisk tftp 0x00000000 ramdisk

Uboot> saveenv              
Saving Environment to Flash...                              
Un-Protected 1 sectors                      
Erasing Flash...Erasing sector  7 ... ok.

Erased 1 sectors                
Writing to Flash... done                        
Protected 1 sectors                   
Uboot> run ramdisk                  
TFTP from server 10.245.8.175; our IP address is 10.245.8.176

Filename 'ramdisk'.                   
Load address: 0x0                 
Loading: #################################################################

         #################################################################

         #################################################################

         ########               
done    
Bytes transferred = 1112544 (10f9e0 hex)

Uboot> run kernel                 
TFTP from server 10.245.8.175; our IP address is 10.245.8.176

Filename 'zImage'.                  
Load address: 0x21000000                        
Loading: #################################################################

         #################################################################

         ############################                                     
done    
Bytes transferred = 806672 (c4f10 hex)                                      
Uboot> bootm 21000000                     
## Booting image at 21000000 ...                                
Bad Magic Number                
Uboot> go 21000000                  
## Starting application at                          
Uncompressing Linux......................................................
done,

booting the kernel.                   
Linux version 2.6.10 (root@localhost.localdomain) (gcc version 3.4.4) #1 Mon
Feb

 19 19:52:24 EST 2007                     
CPU: ARM920Tid(wb) [41129200] revision 0 (ARMv4T)

CPU: D VIVT write-back cache                            
CPU: I cache: 16384 bytes, associativity 64, 32 byte lines, 8 sets

CPU: D cache: 16384 bytes, associativity 64, 32 byte lines, 8 sets

Machine: ATMEL AT91RM9200                         
Warning: bad configuration page, trying to continue

Memory policy: ECC disabled, Data cache writeback

Built 1 zonelists                 
Kernel command line: mem=32M console=ttyS0,115200 initrd=0x20410000,3145728
root

=/dev/ram0 rw             
PID hash table entries: 256 (order: 8, 4096 bytes)

Console: colour dummy device 80x30                                  
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)

Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)

Memory: 32MB = 32MB total                         
Memory: 27600KB available (1324K code, 290K data, 80K init)

Mount-cache hash table entries: 512 (order: 0, 4096 bytes)

CPU: Testing write buffer coherency: ok

checking if image is initramfs...it isn't (bad gzip magic numbers); looks
like a

n initrd        
Freeing initrd memory: 3072K                            
NET: Registered protocol family 16                                  
usbcore: registered new driver hub                                  
NetWinder Floating Point Emulator V0.97 (double precision)

devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)

devfs: boot_options: 0x1                        
AT91 Watchdog Timer enabled (5 seconds)

AT91 SPI driver loaded                      
ttyS0 at MMIO 0xfefff200 (irq = 1) is a AT91_SERIAL

ttyS1 at MMIO 0xfefc4000 (irq = 7)                                   
ttyS1 at MMIO 0xfefc4000 (irq = 7)                                   
io scheduler anticipatory registered
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
eth%d: Link now 100-HalfDuplex
eth%d: AT91 ethernet at 0xfefbc000 int=24 100-HalfDuplex (00:50:ba:89:69:24)
eth%d: Davicom 9196 PHY (Copper)
elevator: using anticipatory as default io scheduler
physmap flash device: 200000 at 10000000
phys_mapped_flash: Found 1 x16 devices at 0x0 in 16-bit bank
 Amd/Fujitsu Extended Query Table at 0x0041
phys_mapped_flash: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
at91_dataflash: Atmel AT45DB642 detected [spi0] (8650752 bytes)
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
Found AT91 i2c
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
NET: Registered protocol family 1
NET: Registered protocol family 17
RAMDISK: Couldn't find valid RAM disk image starting at 0.
Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(1,0)


Regards,
Milind Dere.


















-----Original Message-----
From: linux-arm-kernel-bounces@lists.arm.linux.org.uk
[mailto:linux-arm-kernel-bounces@lists.arm.linux.org.uk] On Behalf Of
Rodolfo Giometti
Sent: Friday, February 23, 2007 4:17 AM
To: Dmitry Torokhov
Cc: linux-input@atrey.karlin.mff.cuni.cz; Nicolas Pitre;
linux-arm-kernel@lists.arm.linux.org.uk
Subject: Re: [PATCH] PXA27x keyboard support

On Fri, Nov 24, 2006 at 01:09:22AM -0500, Dmitry Torokhov wrote:

> I was about to apply the patch below from Nicolas Pitre when I saw 
> your post. I like your idea of defining keyboard data at machine level 
> and have driver adapt to the hardware, however Nicolas driver seems to 
> have more features. If I could ask you to work out how both your and 
> Nicolas drivers can be merged together taht woudl be great.

Hello, here my last patch for the PXA27x keyboard support updated to
linux-2.6.21-rc1.

As already written I tried to add as mush possible from the Nicolas'
patch but since I haven't a mainstone I can't fully test the keyboard
hardware.

I know that this is not the best but I think it could be a good starting
point for further improvements. :)

Machines should call the driver with the following code:

static struct pxa27x_keyboard_platform_data wwpc1100_kbd = {
        .nr_rows = 4,
        .nr_cols = 4,
        .keycodes = {
                {
                        /* row 0 */
                        KEY_ESC,
                        KEY_ENTER,
                        KEY_F1,
                        -1,
                }, {    /* row 1 */
                        KEY_F2,
                        KEY_F3,
                        KEY_F4,
                        -1,
                }, {    /* row 2 */
                        KEY_UP,
                        KEY_LEFT,
                        KEY_RIGHT,
                        -1,
                }, {    /* row 3 */
                        KEY_DOWN,
                        -1,
                        -1,
                        -1,
                },
        },
        .gpio_modes = {
                 GPIO100_KP_MKIN0,
                 GPIO101_KP_MKIN1,
                 GPIO102_KP_MKIN2,
                 GPIO97_KP_MKIN3,
                 GPIO103_KP_MKOUT0,
                 GPIO104_KP_MKOUT1,
                 GPIO105_KP_MKOUT2,
                 GPIO106_KP_MKOUT3,
         },
};

static struct platform_device wwpc1100_keyboard = {
        .name   = "pxa27x-keyboard",
        .id     = -1,
        .dev    =  {
                .platform_data  = &wwpc1100_kbd,
        },
};

static struct platform_device *platform_devices[] __initdata = {
        &wwpc1100_audio_device,
        &wwpc1100_keyboard,
        &wwpc1100_lcd_bl_device,
        &wwpc1100_keyb_bl_device,
};


Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127
