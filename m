From: Brent Adam <BrentAdam@smarttech.com>
Subject: RE: [PATCH v2] USB: HID: Fix fields from pen report ID being
 interpreted for multitouch.
Date: Fri, 19 Jun 2015 16:55:46 +0000
Message-ID: <BN1PR06MB200D347A9E36DAEBBE33923B0A40@BN1PR06MB200.namprd06.prod.outlook.com>
References: <1434732815-5172-1-git-send-email-brentadam@smarttech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bl2on0138.outbound.protection.outlook.com ([65.55.169.138]:60960
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752335AbbFSRKH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Jun 2015 13:10:07 -0400
In-Reply-To: <1434732815-5172-1-git-send-email-brentadam@smarttech.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Brent Adam <brentadamdev@gmail.com>, "jkosina@suse.cz" <jkosina@suse.cz>, "benjamin.tissoires@gmail.com" <benjamin.tissoires@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Patch v2 with changes as per Benjamin Tissoires.  Added a comment and fix assumption that the HID_DG_STYLUS collection comes before HID_DG_CONTACTCOUNT by checking (td->mt_report_id != -1).

Reminder.  Here is the parsed descriptor.  It is both multi-finger (HID_DG_FINGER 0x22)  and multi-stylus (HID_DG_STYLUS 0x20).

Usage Page    (Generic Desktop) 
Usage (Mouse)    
    Collection (Application)    
    ReportID................    (1)  
    Usage (Pointer)    
        Collection (Physical)    
            Usage Page    (Button) 
            Usage Minimum...........    (1)  
            Usage Maximum...........    (3)  
            Logical Minimum.........    (0)  
            Logical Maximum.........    (1)  
            Report Count............    (3)  
            Report Size.............    (1)  
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Report Count............    (5)  
            Input...................   (Constant, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Usage Page    (Generic Desktop) 
            Logical Minimum.........    (0)  
            Logical Maximum.........    (2047)  
            Unit Exponent...........    (15)  
            Unit....................    (0)  
            Report Size.............    (16)  
            Report Count............    (1)  
            Physical Minimum........    (0)  
            Physical Maximum........    (142)  
            Usage (X)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Physical Maximum........    (80)  
            Usage (Y)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Physical Maximum........    (0)  
        End Collection     
    End Collection     
Usage Page    (Digitizer) 
Usage 6 (0x6)    
Logical Minimum.........    (0)  
Logical Maximum.........    (255)  
    Collection (Application)    
    ReportID................    (2)  
    Report Size.............    (8)  
    Report Count............    (63)  
    Usage 0 (0x0)    
    Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Buffered bytes) 
    Report Count............    (63)  
    Usage 0 (0x0)    
    Output..................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Nonvolatile, Buffered bytes) 
    End Collection     
Usage Page    (Digitizer) 
Usage 4 (0x4)    
    Collection (Application)    
    ReportID................    (3)  
    Usage Page    (Digitizer) 
    Usage 34 (0x22)    
        Collection (Physical)    
            Logical Minimum.........    (0)  
            Logical Maximum.........    (1)  
            Report Size.............    (1)  
            Report Count............    (3)  
            Usage 66 (0x42)    
            Usage 50 (0x32)    
            Usage 71 (0x47)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Report Count............    (5)  
            Input...................   (Constant, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Logical Maximum.........    (255)  
            Report Size.............    (8)  
            Report Count............    (1)  
            Usage 81 (0x51)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Report Size.............    (16)  
            Logical Maximum.........    (36000)  
            Unit Exponent...........    (0)  
            Unit....................    (0)  
            Physical Minimum........    (0)  
            Physical Maximum........    (360)  
            Usage 63 (0x3f)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Unit....................    (0)  
            Logical Maximum.........    (4095)  
            Physical Maximum........    (142)  
            Usage 72 (0x48)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Physical Maximum........    (80)  
            Usage 73 (0x49)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Usage Page    (Generic Desktop) 
            Physical Maximum........    (142)  
            Usage (X)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Physical Maximum........    (80)  
            Usage (Y)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Physical Maximum........    (0)  
        End Collection     
    Usage Page    (Digitizer) 
    Usage 34 (0x22)    
        Collection (Physical)    
            Logical Minimum.........    (0)  
            Logical Maximum.........    (1)  
            Report Size.............    (1)  
            Report Count............    (3)  
            Usage 66 (0x42)    
            Usage 50 (0x32)    
            Usage 71 (0x47)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Report Count............    (5)  
            Input...................   (Constant, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Logical Maximum.........    (255)  
            Report Size.............    (8)  
            Report Count............    (1)  
            Usage 81 (0x51)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Report Size.............    (16)  
            Logical Maximum.........    (36000)  
            Unit Exponent...........    (0)  
            Unit....................    (0)  
            Physical Minimum........    (0)  
            Physical Maximum........    (360)  
            Usage 63 (0x3f)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Unit....................    (0)  
            Logical Maximum.........    (4095)  
            Physical Maximum........    (142)  
            Usage 72 (0x48)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Physical Maximum........    (80)  
            Usage 73 (0x49)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Usage Page    (Generic Desktop) 
            Physical Maximum........    (142)  
            Usage (X)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Physical Maximum........    (80)  
            Usage (Y)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Physical Maximum........    (0)  
        End Collection     
    Usage Page    (Digitizer) 
    Usage 34 (0x22)    
        Collection (Physical)    
            Logical Minimum.........    (0)  
            Logical Maximum.........    (1)  
            Report Size.............    (1)  
            Report Count............    (3)  
            Usage 66 (0x42)    
            Usage 50 (0x32)    
            Usage 71 (0x47)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Report Count............    (5)  
            Input...................   (Constant, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Logical Maximum.........    (255)  
            Report Size.............    (8)  
            Report Count............    (1)  
            Usage 81 (0x51)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Report Size.............    (16)  
            Logical Maximum.........    (36000)  
            Unit Exponent...........    (0)  
            Unit....................    (0)  
            Physical Minimum........    (0)  
            Physical Maximum........    (360)  
            Usage 63 (0x3f)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Unit....................    (0)  
            Logical Maximum.........    (4095)  
            Physical Maximum........    (142)  
            Usage 72 (0x48)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Physical Maximum........    (80)  
            Usage 73 (0x49)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Usage Page    (Generic Desktop) 
            Physical Maximum........    (142)  
            Usage (X)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Physical Maximum........    (80)  
            Usage (Y)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Physical Maximum........    (0)  
        End Collection     
    Usage Page    (Digitizer) 
    Usage 34 (0x22)    
        Collection (Physical)    
            Logical Minimum.........    (0)  
            Logical Maximum.........    (1)  
            Report Size.............    (1)  
            Report Count............    (3)  
            Usage 66 (0x42)    
            Usage 50 (0x32)    
            Usage 71 (0x47)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Report Count............    (5)  
            Input...................   (Constant, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Logical Maximum.........    (255)  
            Report Size.............    (8)  
            Report Count............    (1)  
            Usage 81 (0x51)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Report Size.............    (16)  
            Logical Maximum.........    (36000)  
            Unit Exponent...........    (0)  
            Unit....................    (0)  
            Physical Minimum........    (0)  
            Physical Maximum........    (360)  
            Usage 63 (0x3f)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Unit....................    (0)  
            Logical Maximum.........    (4095)  
            Physical Maximum........    (142)  
            Usage 72 (0x48)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Physical Maximum........    (80)  
            Usage 73 (0x49)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Usage Page    (Generic Desktop) 
            Physical Maximum........    (142)  
            Usage (X)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Physical Maximum........    (80)  
            Usage (Y)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Physical Maximum........    (0)  
        End Collection     
    Usage Page    (Digitizer) 
    Report Size.............    (8)  
    Report Count............    (1)  
    Logical Minimum.........    (0)  
    Logical Maximum.........    (10)  
    Usage 84 (0x54)    
    Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
    Usage 85 (0x55)    
    Feature.................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Nonvolatile, Bitfield) 
    End Collection     
Usage Page    (Digitizer) 
Usage 14 (0xe)    
    Collection (Application)    
    ReportID................    (4)  
    Usage 35 (0x23)    
        Collection (Logical)    
            Logical Minimum.........    (0)  
            Logical Maximum.........    (2)  
            Report Size.............    (8)  
            Report Count............    (2)  
            Usage 82 (0x52)    
            Usage 83 (0x53)    
            Feature.................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Nonvolatile, Bitfield) 
        End Collection     
    End Collection     
Usage Page    (Digitizer) 
Usage 4 (0x4)    
    Collection (Application)    
    ReportID................    (5)  
    Usage Page    (Digitizer) 
    Usage 32 (0x20)    
    Logical Maximum.........    (1)  
    Report Size.............    (1)  
    Report Count............    (5)  
        Collection (Physical)    
            Logical Minimum.........    (0)  
            Usage 66 (0x42)    
            Usage 50 (0x32)    
            Usage 68 (0x44)    
            Usage 60 (0x3c)    
            Usage 69 (0x45)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Report Count............    (3)  
            Input...................   (Constant, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Logical Maximum.........    (255)  
            Report Size.............    (8)  
            Report Count............    (1)  
            Usage 81 (0x51)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Usage 56 (0x38)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Report Size.............    (16)  
            Logical Maximum.........    (36000)  
            Unit Exponent...........    (0)  
            Unit....................    (0)  
            Physical Minimum........    (0)  
            Physical Maximum........    (360)  
            Usage 63 (0x3f)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Unit....................    (0)  
            Logical Maximum.........    (4095)  
            Physical Maximum........    (142)  
            Usage 72 (0x48)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Physical Maximum........    (80)  
            Usage 73 (0x49)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Usage Page    (Generic Desktop) 
            Physical Maximum........    (142)  
            Usage (X)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Physical Maximum........    (80)  
            Usage (Y)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Physical Maximum........    (0)  
        End Collection     
    Usage Page    (Digitizer) 
    Usage 32 (0x20)    
    Logical Maximum.........    (1)  
    Report Size.............    (1)  
    Report Count............    (5)  
        Collection (Physical)    
            Logical Minimum.........    (0)  
            Usage 66 (0x42)    
            Usage 50 (0x32)    
            Usage 68 (0x44)    
            Usage 60 (0x3c)    
            Usage 69 (0x45)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Report Count............    (3)  
            Input...................   (Constant, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Logical Maximum.........    (255)  
            Report Size.............    (8)  
            Report Count............    (1)  
            Usage 81 (0x51)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Usage 56 (0x38)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Report Size.............    (16)  
            Logical Maximum.........    (36000)  
            Unit Exponent...........    (0)  
            Unit....................    (0)  
            Physical Minimum........    (0)  
            Physical Maximum........    (360)  
            Usage 63 (0x3f)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Unit....................    (0)  
            Logical Maximum.........    (4095)  
            Physical Maximum........    (142)  
            Usage 72 (0x48)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Physical Maximum........    (80)  
            Usage 73 (0x49)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Usage Page    (Generic Desktop) 
            Physical Maximum........    (142)  
            Usage (X)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Physical Maximum........    (80)  
            Usage (Y)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Physical Maximum........    (0)  
        End Collection     
    Usage Page    (Digitizer) 
    Usage 32 (0x20)    
    Logical Maximum.........    (1)  
    Report Size.............    (1)  
    Report Count............    (5)  
        Collection (Physical)    
            Logical Minimum.........    (0)  
            Usage 66 (0x42)    
            Usage 50 (0x32)    
            Usage 68 (0x44)    
            Usage 60 (0x3c)    
            Usage 69 (0x45)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Report Count............    (3)  
            Input...................   (Constant, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Logical Maximum.........    (255)  
            Report Size.............    (8)  
            Report Count............    (1)  
            Usage 81 (0x51)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Usage 56 (0x38)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Report Size.............    (16)  
            Logical Maximum.........    (36000)  
            Unit Exponent...........    (0)  
            Unit....................    (0)  
            Physical Minimum........    (0)  
            Physical Maximum........    (360)  
            Usage 63 (0x3f)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Unit....................    (0)  
            Logical Maximum.........    (4095)  
            Physical Maximum........    (142)  
            Usage 72 (0x48)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Physical Maximum........    (80)  
            Usage 73 (0x49)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Usage Page    (Generic Desktop) 
            Physical Maximum........    (142)  
            Usage (X)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Physical Maximum........    (80)  
            Usage (Y)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Physical Maximum........    (0)  
        End Collection     
    Usage Page    (Digitizer) 
    Usage 32 (0x20)    
    Logical Maximum.........    (1)  
    Report Size.............    (1)  
    Report Count............    (5)  
        Collection (Physical)    
            Logical Minimum.........    (0)  
            Usage 66 (0x42)    
            Usage 50 (0x32)    
            Usage 68 (0x44)    
            Usage 60 (0x3c)    
            Usage 69 (0x45)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Report Count............    (3)  
            Input...................   (Constant, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Logical Maximum.........    (255)  
            Report Size.............    (8)  
            Report Count............    (1)  
            Usage 81 (0x51)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Usage 56 (0x38)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Report Size.............    (16)  
            Logical Maximum.........    (36000)  
            Unit Exponent...........    (0)  
            Unit....................    (0)  
            Physical Minimum........    (0)  
            Physical Maximum........    (360)  
            Usage 63 (0x3f)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Unit....................    (0)  
            Logical Maximum.........    (4095)  
            Physical Maximum........    (142)  
            Usage 72 (0x48)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Physical Maximum........    (80)  
            Usage 73 (0x49)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Usage Page    (Generic Desktop) 
            Physical Maximum........    (142)  
            Usage (X)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Physical Maximum........    (80)  
            Usage (Y)    
            Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
            Physical Maximum........    (0)  
        End Collection     
    Usage Page    (Digitizer) 
    Report Size.............    (8)  
    Report Count............    (1)  
    Logical Minimum.........    (0)  
    Logical Maximum.........    (10)  
    Usage 84 (0x54)    
    Input...................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Bitfield) 
    Usage 85 (0x55)    
    Feature.................   (Data, Variable, Absolute, No Wrap, Linear, Preferred State, No Null Position, Nonvolatile, Bitfield) 
    End Collection     

Here is hid-recorder output:

brenta@brenta-HP-Compaq-6005-Pro-SFF-PC:~$ sudo hid-recorder
Available devices:
/dev/hidraw0:	Microsoft  Microsoft Basic Optical Mouse v2.0
/dev/hidraw1:	Microsoft Wired Keyboard 400
/dev/hidraw2:	SMART Technologies SMART IFP
/dev/hidraw3:	SMART Technologies SMART IFP
/dev/hidraw4:	BurrBrown from Texas Instruments USB AUDIO  CODEC
Select the device event number [0-4]: 2
D: 0
R: 971 05 01 09 02 a1 01 85 01 09 01 a1 00 05 09 19 01 29 03 15 00 25 01 95 03 75 01 81 02 95 05 81 03 05 01 15 00 26 ff 07 55 0f 65 00 75 10 95 01 35 00 46 8e 00 09 30 81 02 46 50 00 09 31 81 02 45 00 c0 c0 05 0d 09 06 15 00 26 ff 00 a1 01 85 02 75 08 95 3f 09 00 82 02 03 95 3f 09 00 92 02 03 c0 05 0d 09 04 a1 01 85 03 05 0d 09 22 a1 00 15 00 25 01 75 01 95 03 09 42 09 32 09 47 81 02 95 05 81 03 26 ff 00 75 08 95 01 09 51 81 02 75 10 27 a0 8c 00 00 55 00 65 00 35 00 46 68 01 09 3f 81 02 65 00 26 ff 0f 46 8e 00 09 48 81 02 46 50 00 09 49 81 02 05 01 46 8e 00 09 30 81 02 46 50 00 09 31 81 02 45 00 c0 05 0d 09 22 a1 00 15 00 25 01 75 01 95 03 09 42 09 32 09 47 81 02 95 05 81 03 26 ff 00 75 08 95 01 09 51 81 02 75 10 27 a0 8c 00 00 55 00 65 00 35 00 46 68 01 09 3f 81 02 65 00 26 ff 0f 46 8e 0
 0 09 48 81 02 46 50 00 09 49 81 02 05 01 46 8e 00 09 30 81 02 46 50 00 09 31 81 02 45 00 c0 05 0d 09 22 a1 00 15 00 25 01 75 01 95 03 09 42 09 32 09 47 81 02 95 05 81 03 26 ff 00 75 08 95 01 09 51 81 02 75 10 27 a0 8c 00 00 55 00 65 00 35 00 46 68 01 09 3f 81 02 65 00 26 ff 0f 46 8e 00 09 48 81 02 46 50 00 09 49 81 02 05 01 46 8e 00 09 30 81 02 46 50 00 09 31 81 02 45 00 c0 05 0d 09 22 a1 00 15 00 25 01 75 01 95 03 09 42 09 32 09 47 81 02 95 05 81 03 26 ff 00 75 08 95 01 09 51 81 02 75 10 27 a0 8c 00 00 55 00 65 00 35 00 46 68 01 09 3f 81 02 65 00 26 ff 0f 46 8e 00 09 48 81 02 46 50 00 09 49 81 02 05 01 46 8e 00 09 30 81 02 46 50 00 09 31 81 02 45 00 c0 05 0d 75 08 95 01 15 00 25 0a 09 54 81 02 09 55 b1 02 c0 05 0d 09 0e a1 01 85 04 09 23 a1 02 15 00 25 02 75 08 95 02 09 52 09 53 b1 02 c
 0 c0 05 0d 09 04 a1 01 85 05 05 0d 09 20 25 01 75 01 95 05 a1 00 15 00 09 42 09 32 09 44 09 3c 09 45 81 02 95 03 81 03 26 ff 00 75 08 95 01 09 51 81 02 09 38 81 02 75 10 27 a0 8c 00 00 55 00 65 00 35 00 46 68 01 09 3f 81 02 65 00 26 ff 0f 46 8e 00 09 48 81 02 46 50 00 09 49 81 02 05 01 46 8e 00 09 30 81 02 46 50 00 09 31 81 02 45 00 c0 05 0d 09 20 25 01 75 01 95 05 a1 00 15 00 09 42 09 32 09 44 09 3c 09 45 81 02 95 03 81 03 26 ff 00 75 08 95 01 09 51 81 02 09 38 81 02 75 10 27 a0 8c 00 00 55 00 65 00 35 00 46 68 01 09 3f 81 02 65 00 26 ff 0f 46 8e 00 09 48 81 02 46 50 00 09 49 81 02 05 01 46 8e 00 09 30 81 02 46 50 00 09 31 81 02 45 00 c0 05 0d 09 20 25 01 75 01 95 05 a1 00 15 00 09 42 09 32 09 44 09 3c 09 45 81 02 95 03 81 03 26 ff 00 75 08 95 01 09 51 81 02 09 38 81 02 75 10 27 a0 8c 0
 0 00 55 00 65 00 35 00 46 68 01 09 3f 81 02 65 00 26 ff 0f 46 8e 00 09 48 81 02 46 50 00 09 49 81 02 05 01 46 8e 00 09 30 81 02 46 50 00 09 31 81 02 45 00 c0 05 0d 09 20 25 01 75 01 95 05 a1 00 15 00 09 42 09 32 09 44 09 3c 09 45 81 02 95 03 81 03 26 ff 00 75 08 95 01 09 51 81 02 09 38 81 02 75 10 27 a0 8c 00 00 55 00 65 00 35 00 46 68 01 09 3f 81 02 65 00 26 ff 0f 46 8e 00 09 48 81 02 46 50 00 09 49 81 02 05 01 46 8e 00 09 30 81 02 46 50 00 09 31 81 02 45 00 c0 05 0d 75 08 95 01 15 00 25 0a 09 54 81 02 09 55 b1 02 c0
N: SMART Technologies SMART IFP
P: usb-0000:00:12.2-3.1.2/input0
I: 3 0b8c 0092
D: 0
E: 0.000000 64 02 d2 00 92 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 0.000902 64 02 a5 d4 92 00 f9 38 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 0.499851 64 02 d2 00 92 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 0.500837 64 02 a5 d4 92 00 f9 38 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 0.999783 64 02 d2 00 92 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 1.000767 64 02 a5 d4 92 00 f9 38 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 1.499715 64 02 d2 00 92 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 1.500701 64 02 a5 d4 92 00 f9 38 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 2.000649 64 02 d2 00 92 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 2.001635 64 02 a5 d4 92 00 f9 38 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 2.500581 64 02 d2 00 92 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 2.501566 64 02 a5 d4 92 00 f9 38 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 3.000513 64 02 d2 00 92 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 3.001498 64 02 a5 d4 92 00 f9 38 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 3.500445 64 02 d2 00 92 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 3.501431 64 02 a5 d4 92 00 f9 38 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 4.000377 64 02 d2 00 92 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 4.001363 64 02 a5 d4 92 00 f9 38 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 4.500314 64 02 d2 00 92 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 4.501297 64 02 a5 d4 92 00 f9 38 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 4.989281 50 03 07 fb 00 00 55 00 73 00 df 0c c1 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 4.998276 50 03 07 fb 00 00 56 00 7c 00 e6 0c bf 04 07 fc 00 00 60 00 78 00 0d 0d c8 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.011195 64 02 d2 00 92 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 5.012189 64 02 a5 d4 92 00 f9 38 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 5.031210 50 03 07 fb 00 00 59 00 79 00 e9 0c be 04 07 fc 00 00 61 00 7a 00 17 0d c4 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.032158 64 02 0f 16 c1 92 00 13 02 74 6f 75 63 68 64 65 74 65 63 74 65 64 3d 79 65 73 0d 67 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 5.039252 50 03 07 fb 00 00 58 00 7b 00 fe 0c b4 04 07 fc 00 00 60 00 79 00 2a 0d b7 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.048257 50 03 07 fb 00 00 56 00 78 00 04 0d b0 04 07 fc 00 00 61 00 7a 00 30 0d b2 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.056676 50 03 07 fb 00 00 57 00 76 00 0b 0d ad 04 07 fc 00 00 62 00 7b 00 36 0d ae 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.064160 50 03 07 fb 00 00 57 00 7c 00 11 0d aa 04 07 fc 00 00 61 00 7a 00 3c 0d aa 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.073180 50 03 07 fb 00 00 57 00 7d 00 19 0d a8 04 07 fc 00 00 61 00 7c 00 43 0d a6 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.081178 50 03 07 fb 00 00 57 00 77 00 21 0d a4 04 07 fc 00 00 62 00 7b 00 4a 0d a3 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.089250 50 03 07 fb 00 00 57 00 78 00 29 0d a2 04 07 fc 00 00 62 00 7a 00 52 0d a0 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.098198 50 03 07 fb 00 00 58 00 7a 00 31 0d 9f 04 07 fc 00 00 63 00 7d 00 5b 0d 9c 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.106196 50 03 07 fb 00 00 56 00 78 00 3a 0d 9b 04 07 fc 00 00 63 00 b3 00 64 0d 99 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.114160 50 03 07 fb 00 00 56 00 75 00 43 0d 98 04 07 fc 00 00 61 00 b0 00 6d 0d 96 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.123193 50 03 07 fb 00 00 57 00 7b 00 4c 0d 95 04 07 fc 00 00 63 00 af 00 76 0d 93 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.131193 50 03 07 fb 00 00 57 00 7b 00 57 0d 90 04 07 fc 00 00 61 00 ad 00 80 0d 90 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.139127 50 03 07 fb 00 00 57 00 76 00 61 0d 8e 04 07 fc 00 00 61 00 ab 00 8a 0d 8c 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.148149 50 03 07 fb 00 00 58 00 7d 00 6b 0d 8a 04 07 fc 00 00 62 00 a8 00 94 0d 88 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.156171 50 03 07 fb 00 00 56 00 77 00 76 0d 86 04 07 fc 00 00 62 00 a6 00 9e 0d 84 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.164165 50 03 07 fb 00 00 56 00 79 00 82 0d 84 04 07 fc 00 00 62 00 a6 00 a8 0d 81 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.173202 50 03 07 fb 00 00 57 00 7a 00 8c 0d 7f 04 07 fc 00 00 61 00 a4 00 b3 0d 7d 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.181232 50 03 07 fb 00 00 53 00 74 00 98 0d 79 04 07 fc 00 00 63 00 a3 00 bc 0d 79 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.189171 50 03 07 fb 00 00 57 00 76 00 a1 0d 78 04 07 fc 00 00 63 00 a2 00 c6 0d 76 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.198171 50 03 07 fb 00 00 57 00 79 00 ab 0d 74 04 07 fc 00 00 64 00 a3 00 d0 0d 72 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.206172 50 03 07 fb 00 00 57 00 79 00 b6 0d 70 04 07 fc 00 00 62 00 a1 00 d9 0d 6f 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.214183 50 03 07 fb 00 00 57 00 78 00 be 0d 6e 04 07 fc 00 00 62 00 a0 00 e2 0d 6d 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.223143 50 03 07 fb 00 00 57 00 77 00 c7 0d 6d 04 07 fc 00 00 63 00 9b 00 ec 0d 6a 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.231157 50 03 07 fb 00 00 56 00 79 00 d1 0d 68 04 07 fc 00 00 64 00 99 00 f5 0d 67 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.239177 50 03 07 fb 00 00 56 00 79 00 d9 0d 66 04 07 fc 00 00 65 00 99 00 fd 0d 66 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.248178 50 03 07 fb 00 00 57 00 77 00 e1 0d 65 04 07 fc 00 00 63 00 99 00 04 0e 66 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.256175 50 03 07 fb 00 00 56 00 79 00 e9 0d 63 04 07 fc 00 00 69 00 94 00 0c 0e 64 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.264147 50 03 07 fb 00 00 56 00 7d 00 f0 0d 60 04 07 fc 00 00 6b 00 8f 00 14 0e 62 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.273174 50 03 07 fb 00 00 56 00 7a 00 f6 0d 5e 04 07 fc 00 00 6a 00 90 00 19 0e 60 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.281171 50 03 07 fb 00 00 56 00 79 00 fb 0d 5c 04 07 fc 00 00 66 00 94 00 1d 0e 5f 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.289221 50 03 07 fb 00 00 56 00 7b 00 fe 0d 5b 04 07 fc 00 00 64 00 96 00 20 0e 5e 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.298210 50 03 07 fb 00 00 58 00 7b 00 02 0e 5a 04 07 fc 00 00 65 00 96 00 23 0e 5d 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.306128 50 03 07 fb 00 00 59 00 7a 00 04 0e 59 04 07 fc 00 00 65 00 96 00 26 0e 5b 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.314092 50 03 07 fb 00 00 57 00 7b 00 07 0e 57 04 07 fc 00 00 65 00 97 00 28 0e 5a 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.323218 50 03 07 fb 00 00 59 00 7c 00 08 0e 57 04 07 fc 00 00 65 00 9a 00 29 0e 5a 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.331217 50 03 07 fb 00 00 57 00 7d 00 09 0e 57 04 07 fc 00 00 65 00 9a 00 2a 0e 59 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.339221 50 03 07 fb 00 00 57 00 7d 00 0a 0e 56 04 07 fc 00 00 64 00 9c 00 2a 0e 5a 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.348151 50 03 07 fb 00 00 56 00 7c 00 0b 0e 56 04 07 fc 00 00 64 00 9d 00 2b 0e 59 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.356108 50 03 07 fb 00 00 56 00 7b 00 0d 0e 54 04 07 fc 00 00 64 00 9d 00 2c 0e 5a 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.364139 50 03 07 fb 00 00 55 00 79 00 0e 0e 56 04 07 fc 00 00 63 00 a0 00 2d 0e 5d 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.373176 50 03 07 fb 00 00 52 00 6f 00 0c 0e 5b 04 07 fc 00 00 5f 00 98 00 2c 0e 63 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.381175 50 03 07 fb 00 00 48 00 63 00 09 0e 61 04 07 fc 00 00 57 00 86 00 29 0e 69 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.389438 50 03 07 fb 00 00 0b 00 0c 00 f8 0d 6c 04 07 fc 00 00 2b 00 4d 00 22 0e 76 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.397137 50 03 00 fb 00 00 00 00 00 00 f8 0d 6c 04 00 fc 00 00 00 00 00 00 22 0e 76 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 5.511168 64 02 d2 00 92 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 5.512100 64 02 a5 d4 92 00 f9 38 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 5.531146 64 02 0f 16 c1 92 00 13 02 74 6f 75 63 68 64 65 74 65 63 74 65 64 3d 79 65 73 0d 67 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 6.000110 64 02 d2 00 92 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 6.001094 64 02 a5 d4 92 00 f9 38 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 6.499996 64 02 d2 00 92 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 6.500990 64 02 a5 d4 92 00 f9 38 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 6.999972 64 02 d2 00 92 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 7.000959 64 02 a5 d4 92 00 f9 38 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 7.500907 64 02 d2 00 92 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 7.501893 64 02 a5 d4 92 00 f9 38 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 8.000837 64 02 d2 00 92 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 8.001838 64 02 a5 d4 92 00 f9 38 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 8.500773 64 02 d2 00 92 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 8.501759 64 02 a5 d4 92 00 f9 38 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 9.000706 64 02 d2 00 92 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 9.001691 64 02 a5 d4 92 00 f9 38 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 9.500596 64 02 d2 00 92 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 9.501588 64 02 a5 d4 92 00 f9 38 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 10.000572 64 02 d2 00 92 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 10.001559 64 02 a5 d4 92 00 f9 38 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 10.511459 64 02 d2 00 92 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 10.512451 64 02 a5 d4 92 00 f9 38 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 10.530442 64 02 0f 16 c1 92 00 13 02 74 6f 75 63 68 64 65 74 65 63 74 65 64 3d 79 65 73 0d 67 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 10.781500 54 05 03 fd 03 00 00 1f 00 1f 00 aa 0c 16 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 10.789468 54 05 03 fd 03 00 00 1f 00 1f 00 aa 0c 16 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 10.798401 54 05 03 fd 03 00 00 1f 00 1f 00 aa 0c 16 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 10.806458 54 05 03 fd 03 00 00 1f 00 1f 00 aa 0c 16 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 10.814417 54 05 03 fd 03 00 00 1f 00 1f 00 aa 0c 16 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 10.823462 54 05 03 fd 03 00 00 1f 00 1f 00 aa 0c 16 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 10.831297 54 05 03 fd 03 00 00 1f 00 1f 00 b8 0c 17 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 10.839426 54 05 03 fd 03 00 00 1f 00 1f 00 bb 0c 19 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 10.848424 54 05 03 fd 03 00 00 1f 00 1f 00 bf 0c 18 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 10.856392 54 05 03 fd 03 00 00 1f 00 1f 00 c3 0c 18 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 10.864420 54 05 03 fd 03 00 00 1f 00 1f 00 c7 0c 17 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 10.873420 54 05 03 fd 03 00 00 1f 00 1f 00 cb 0c 17 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 10.881420 54 05 03 fd 03 00 00 1f 00 1f 00 d0 0c 14 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 10.889407 54 05 03 fd 03 00 00 1f 00 1f 00 d4 0c 13 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 10.898399 54 05 03 fd 03 00 00 1f 00 1f 00 d9 0c 11 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 10.906398 54 05 03 fd 03 00 00 1f 00 1f 00 de 0c 0d 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 10.914413 54 05 03 fd 03 00 00 1f 00 1f 00 de 0c 0d 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 10.923410 54 05 03 fd 03 00 00 1f 00 1f 00 e0 0c 07 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 10.931335 54 05 03 fd 03 00 00 1f 00 1f 00 e6 0c f9 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 10.939389 54 05 03 fd 03 00 00 1f 00 1f 00 e8 0c f0 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 10.948404 54 05 03 fd 03 00 00 1f 00 1f 00 ea 0c e8 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 10.956424 54 05 03 fd 03 00 00 1f 00 1f 00 eb 0c de 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 10.964545 54 05 03 fd 03 00 00 1f 00 1f 00 eb 0c d6 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 10.973381 54 05 03 fd 03 00 00 1f 00 1f 00 eb 0c cc 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 10.981392 54 05 03 fd 03 00 00 1f 00 1f 00 eb 0c c4 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 10.989403 54 05 03 fd 03 00 00 1f 00 1f 00 e8 0c bb 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 10.998406 54 05 03 fd 03 00 00 1f 00 1f 00 e6 0c b4 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.011359 64 02 d2 00 92 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 11.012395 64 02 a5 d4 92 00 f9 38 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 11.025394 64 02 0f 16 c1 92 00 13 02 74 6f 75 63 68 64 65 74 65 63 74 65 64 3d 79 65 73 0d 67 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 11.031398 54 05 03 fd 03 00 00 1f 00 1f 00 e2 0c ac 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.039394 54 05 03 fd 03 00 00 1f 00 1f 00 cc 0c 97 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.048364 54 05 03 fd 03 00 00 1f 00 1f 00 c4 0c 92 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.056392 54 05 03 fd 03 00 00 1f 00 1f 00 bd 0c 8f 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.064377 54 05 03 fd 03 00 00 1f 00 1f 00 b4 0c 8d 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.073377 54 05 03 fd 03 00 00 1f 00 1f 00 ad 0c 8b 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.081347 54 05 03 fd 03 00 00 1f 00 1f 00 a4 0c 8b 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.089374 54 05 03 fd 03 00 00 1f 00 1f 00 9b 0c 8d 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.098389 54 05 03 fd 03 00 00 1f 00 1f 00 91 0c 90 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.106405 54 05 03 fd 03 00 00 1f 00 1f 00 88 0c 93 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.114406 54 05 03 fd 03 00 00 1f 00 1f 00 88 0c 93 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.123466 54 05 03 fd 03 00 00 1f 00 1f 00 7e 0c 97 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.131387 54 05 03 fd 03 00 00 1f 00 1f 00 6e 0c a4 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.139383 54 05 03 fd 03 00 00 1f 00 1f 00 66 0c ad 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.148384 54 05 03 fd 03 00 00 1f 00 1f 00 5e 0c b7 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.156486 54 05 03 fd 03 00 00 1f 00 1f 00 57 0c c2 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.164383 54 05 03 fd 03 00 00 1f 00 1f 00 51 0c d0 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.173377 54 05 03 fd 03 00 00 1f 00 1f 00 4d 0c dd 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.181431 54 05 03 fd 03 00 00 1f 00 1f 00 49 0c e9 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.189426 54 05 03 fd 03 00 00 1f 00 1f 00 45 0c f6 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.198409 54 05 03 fd 03 00 00 1f 00 1f 00 43 0c 02 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.206363 54 05 03 fd 03 00 00 1f 00 1f 00 43 0c 0d 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.214386 54 05 03 fd 03 00 00 1f 00 1f 00 43 0c 1b 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.223425 54 05 03 fd 03 00 00 1f 00 1f 00 44 0c 28 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.231420 54 05 03 fd 03 00 00 1f 00 1f 00 46 0c 33 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.239352 54 05 03 fd 03 00 00 1f 00 1f 00 49 0c 42 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.248384 54 05 03 fd 03 00 00 1f 00 1f 00 49 0c 42 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.256361 54 05 03 fd 03 00 00 1f 00 1f 00 4f 0c 51 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.264384 54 05 03 fd 03 00 00 1f 00 1f 00 4f 0c 51 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.273360 54 05 03 fd 03 00 00 1f 00 1f 00 5d 0c 68 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.281356 54 05 03 fd 03 00 00 1f 00 1f 00 6b 0c 78 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.289367 54 05 03 fd 03 00 00 1f 00 1f 00 72 0c 7b 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.298364 54 05 03 fd 03 00 00 1f 00 1f 00 78 0c 7d 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.306363 54 05 03 fd 03 00 00 1f 00 1f 00 7f 0c 7c 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.314348 54 05 03 fd 03 00 00 1f 00 1f 00 85 0c 79 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.323324 54 05 03 fd 03 00 00 1f 00 1f 00 8b 0c 75 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.331360 54 05 03 fd 03 00 00 1f 00 1f 00 8b 0c 75 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.339356 54 05 03 fd 03 00 00 1f 00 1f 00 8f 0c 6d 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.348358 54 05 03 fd 03 00 00 1f 00 1f 00 8f 0c 6d 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.356382 54 05 03 fd 03 00 00 1f 00 1f 00 98 0c 57 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.364409 54 05 03 fd 03 00 00 1f 00 1f 00 9d 0c 3f 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.373323 54 05 03 fd 03 00 00 1f 00 1f 00 9d 0c 3f 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.381352 54 05 03 fd 03 00 00 1f 00 1f 00 9f 0c 31 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.389352 54 05 03 fd 03 00 00 1f 00 1f 00 a1 0c 16 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.398311 54 05 03 fd 03 00 00 1f 00 1f 00 a0 0c 0a 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.406333 54 05 03 fd 03 00 00 1f 00 1f 00 a0 0c fe 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.414347 54 05 03 fd 03 00 00 1f 00 1f 00 a0 0c fe 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.423343 54 05 03 fd 03 00 00 1f 00 1f 00 9e 0c f2 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.431338 54 05 03 fd 03 00 00 1f 00 1f 00 9a 0c e1 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.439347 54 05 03 fd 03 00 00 1f 00 1f 00 96 0c d9 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.448344 54 05 03 fd 03 00 00 1f 00 1f 00 92 0c d3 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.456342 54 05 03 fd 03 00 00 1f 00 1f 00 8d 0c cd 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.464340 54 05 03 fd 03 00 00 1f 00 1f 00 88 0c c8 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.473416 54 05 03 fd 03 00 00 1f 00 1f 00 82 0c c4 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.481340 54 05 03 fd 03 00 00 1f 00 1f 00 7a 0c c1 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.489386 54 05 03 fd 03 00 00 1f 00 1f 00 73 0c be 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.498395 54 05 03 fd 03 00 00 1f 00 1f 00 6a 0c bc 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.511304 64 02 d2 00 92 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 11.512280 64 02 a5 d4 92 00 f9 38 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 11.531332 54 05 03 fd 03 00 00 1f 00 1f 00 62 0c bc 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.533326 64 02 0f 16 c1 92 00 13 02 74 6f 75 63 68 64 65 74 65 63 74 65 64 3d 79 65 73 0d 67 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 11.539329 54 05 03 fd 03 00 00 1f 00 1f 00 3f 0c c6 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.548305 54 05 03 fd 03 00 00 1f 00 1f 00 37 0c cb 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.556330 54 05 03 fd 03 00 00 1f 00 1f 00 2f 0c d2 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.564378 54 05 03 fd 03 00 00 1f 00 1f 00 28 0c d8 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.573373 54 05 03 fd 03 00 00 1f 00 1f 00 21 0c e0 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.581367 54 05 03 fd 03 00 00 1f 00 1f 00 1a 0c e8 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.590251 54 05 03 fd 03 00 00 1f 00 1f 00 15 0c f2 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.598322 54 05 03 fd 03 00 00 1f 00 1f 00 11 0c fc 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.606321 54 05 03 fd 03 00 00 1f 00 1f 00 0c 0c 08 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.614371 54 05 03 fd 03 00 00 1f 00 1f 00 0a 0c 14 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.623345 54 05 03 fd 03 00 00 1f 00 1f 00 09 0c 1f 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.631320 54 05 03 fd 03 00 00 1f 00 1f 00 07 0c 2b 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.639315 54 05 03 fd 03 00 00 1f 00 1f 00 07 0c 34 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.648315 54 05 03 fd 03 00 00 1f 00 1f 00 08 0c 3e 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.656304 54 05 03 fd 03 00 00 1f 00 1f 00 09 0c 44 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.664489 54 05 03 fd 03 00 00 1f 00 1f 00 0b 0c 49 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.673290 54 05 03 fd 03 00 00 1f 00 1f 00 0e 0c 4d 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.681289 54 05 03 fd 03 00 00 1f 00 1f 00 12 0c 51 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.689287 54 05 03 fd 03 00 00 1f 00 1f 00 16 0c 54 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.698236 54 05 03 fd 03 00 00 1f 00 1f 00 1c 0c 56 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.706309 54 05 03 fd 03 00 00 1f 00 1f 00 22 0c 56 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.714359 54 05 03 fd 03 00 00 1f 00 1f 00 29 0c 55 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.723356 54 05 03 fd 03 00 00 1f 00 1f 00 31 0c 53 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.731348 54 05 03 fd 03 00 00 1f 00 1f 00 38 0c 4f 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.739339 54 05 03 fd 03 00 00 1f 00 1f 00 38 0c 4f 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.748291 54 05 03 fd 03 00 00 1f 00 1f 00 38 0c 4f 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.756331 54 05 03 fd 03 00 00 1f 00 1f 00 38 0c 4f 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 11.764352 54 05 00 fd 03 00 00 00 00 00 00 38 0c 4f 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 12.011301 64 02 d2 00 92 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 12.012287 64 02 a5 d4 92 00 f9 38 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 12.026292 64 02 0f 16 c1 92 00 13 02 74 6f 75 63 68 64 65 74 65 63 74 65 64 3d 79 65 73 0d 67 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 12.501236 64 02 d2 00 92 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 12.502225 64 02 a5 d4 92 00 f9 38 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 12.540258 50 03 07 fe 00 00 63 00 72 00 e1 0b 6f 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 12.548202 50 03 07 fe 00 00 64 00 73 00 e1 0b 6f 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 12.556194 50 03 07 fe 00 00 63 00 76 00 e1 0b 6f 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 12.565163 50 03 07 fe 00 00 64 00 76 00 e1 0b 6f 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 12.573155 50 03 07 fe 00 00 64 00 78 00 e0 0b 78 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 12.581173 50 03 07 fe 00 00 63 00 77 00 e0 0b 79 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 12.590175 50 03 07 fe 00 00 64 00 75 00 e0 0b 79 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 12.598172 50 03 07 fe 00 00 67 00 73 00 e2 0b 78 04 07 ff 00 00 48 00 79 00 89 0b 83 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.606172 50 03 07 fe 00 00 68 00 72 00 e3 0b 78 04 07 ff 00 00 46 00 85 00 92 0b 89 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.615168 50 03 07 fe 00 00 6b 00 74 00 e6 0b 77 04 07 ff 00 00 45 00 91 00 97 0b 89 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.623181 50 03 07 fe 00 00 6a 00 75 00 ec 0b 77 04 07 ff 00 00 48 00 8f 00 9d 0b 88 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.631202 50 03 07 fe 00 00 6a 00 78 00 f2 0b 79 04 07 ff 00 00 4b 00 91 00 a3 0b 88 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.640229 50 03 07 fe 00 00 69 00 73 00 f9 0b 7a 04 07 ff 00 00 4e 00 8a 00 a8 0b 88 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.648224 50 03 07 fe 00 00 6a 00 6f 00 ff 0b 7a 04 07 ff 00 00 4f 00 82 00 ad 0b 88 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.656159 50 03 07 fe 00 00 69 00 6d 00 05 0c 7a 04 07 ff 00 00 50 00 7d 00 b3 0b 88 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.665168 50 03 07 fe 00 00 63 00 73 00 0a 0c 78 04 07 ff 00 00 52 00 77 00 b7 0b 87 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.673173 50 03 07 fe 00 00 60 00 73 00 0f 0c 77 04 07 ff 00 00 50 00 75 00 bc 0b 86 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.681177 50 03 07 fe 00 00 60 00 74 00 14 0c 76 04 07 ff 00 00 53 00 70 00 c1 0b 84 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.690153 50 03 07 fe 00 00 5d 00 76 00 18 0c 74 04 07 ff 00 00 56 00 6c 00 c5 0b 83 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.698165 50 03 07 fe 00 00 61 00 72 00 1c 0c 72 04 07 ff 00 00 59 00 6d 00 c9 0b 82 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.706163 50 03 07 fe 00 00 5f 00 79 00 21 0c 70 04 07 ff 00 00 5d 00 6b 00 ce 0b 81 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.715175 50 03 07 fe 00 00 61 00 78 00 25 0c 6e 04 07 ff 00 00 5e 00 6c 00 d3 0b 7f 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.723162 50 03 07 fe 00 00 5e 00 75 00 2a 0c 6b 04 07 ff 00 00 61 00 6d 00 d8 0b 7e 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.731127 50 03 07 fe 00 00 5e 00 76 00 2e 0c 69 04 07 ff 00 00 60 00 69 00 dd 0b 7c 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.740147 50 03 07 fe 00 00 60 00 77 00 34 0c 67 04 07 ff 00 00 5c 00 6d 00 e3 0b 7a 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.748167 50 03 07 fe 00 00 5f 00 7a 00 39 0c 63 04 07 ff 00 00 5f 00 6c 00 e8 0b 76 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.756182 50 03 07 fe 00 00 5f 00 78 00 3f 0c 5f 04 07 ff 00 00 60 00 6e 00 ef 0b 72 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.765166 50 03 07 fe 00 00 5f 00 79 00 45 0c 5a 04 07 ff 00 00 5d 00 6e 00 f4 0b 6d 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.773139 50 03 07 fe 00 00 5e 00 7a 00 4b 0c 54 04 07 ff 00 00 5f 00 6f 00 fb 0b 67 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.781160 50 03 07 fe 00 00 61 00 78 00 52 0c 4f 04 07 ff 00 00 5d 00 72 00 02 0c 61 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.790145 50 03 07 fe 00 00 62 00 7c 00 59 0c 49 04 07 ff 00 00 59 00 75 00 09 0c 5c 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.798140 50 03 07 fe 00 00 62 00 7c 00 60 0c 44 04 07 ff 00 00 5c 00 76 00 10 0c 54 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.806179 50 03 07 fe 00 00 61 00 7c 00 69 0c 3b 04 07 ff 00 00 56 00 7c 00 19 0c 4e 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.815183 50 03 07 fe 00 00 60 00 7d 00 71 0c 35 04 07 ff 00 00 5c 00 80 00 21 0c 47 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.823099 50 03 07 fe 00 00 5c 00 82 00 7a 0c 2d 04 07 ff 00 00 57 00 86 00 2a 0c 41 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.831144 50 03 07 fe 00 00 5d 00 84 00 82 0c 25 04 07 ff 00 00 5d 00 8a 00 33 0c 39 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.840136 50 03 07 fe 00 00 5d 00 84 00 8a 0c 1b 04 07 ff 00 00 56 00 8b 00 3c 0c 30 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.848142 50 03 07 fe 00 00 57 00 8d 00 92 0c 10 04 07 ff 00 00 5b 00 92 00 44 0c 27 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.856116 50 03 07 fe 00 00 5d 00 8e 00 99 0c 09 04 07 ff 00 00 5a 00 93 00 4b 0c 1e 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.865115 50 03 07 fe 00 00 5a 00 90 00 a0 0c ff 03 07 ff 00 00 5b 00 94 00 52 0c 14 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.873151 50 03 07 fe 00 00 5c 00 91 00 a6 0c f7 03 07 ff 00 00 5e 00 94 00 59 0c 0a 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.881151 50 03 07 fe 00 00 5b 00 8f 00 ac 0c ed 03 07 ff 00 00 5c 00 91 00 5f 0c 02 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.890150 50 03 07 fe 00 00 5d 00 91 00 b1 0c e7 03 07 ff 00 00 5f 00 93 00 65 0c f9 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.898123 50 03 07 fe 00 00 5a 00 90 00 b6 0c de 03 07 ff 00 00 5c 00 91 00 6a 0c f2 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.906128 50 03 07 fe 00 00 60 00 8b 00 b9 0c d8 03 07 ff 00 00 60 00 8f 00 6e 0c e8 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.915195 50 03 07 fe 00 00 62 00 87 00 bc 0c d3 03 07 ff 00 00 5e 00 8d 00 71 0c e1 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.923200 50 03 07 fe 00 00 62 00 89 00 be 0c cd 03 07 ff 00 00 61 00 8d 00 74 0c da 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.931195 50 03 07 fe 00 00 60 00 88 00 bf 0c ca 03 07 ff 00 00 60 00 8c 00 74 0c d5 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.940102 50 03 07 fe 00 00 62 00 85 00 bf 0c c7 03 07 ff 00 00 62 00 8a 00 74 0c d2 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.948229 50 03 07 fe 00 00 62 00 84 00 bf 0c c6 03 07 ff 00 00 5e 00 8b 00 74 0c d0 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.956138 50 03 07 fe 00 00 64 00 83 00 be 0c c4 03 07 ff 00 00 60 00 8c 00 73 0c cf 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.965192 50 03 07 fe 00 00 65 00 82 00 bc 0c c3 03 07 ff 00 00 60 00 8c 00 72 0c cd 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.973190 50 03 07 fe 00 00 67 00 82 00 b9 0c c3 03 07 ff 00 00 60 00 8d 00 6e 0c cb 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.981140 50 03 07 fe 00 00 67 00 83 00 b5 0c c2 03 07 ff 00 00 60 00 89 00 6a 0c ca 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.990108 50 03 07 fe 00 00 69 00 84 00 b0 0c c2 03 07 ff 00 00 60 00 8a 00 64 0c c9 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 12.998101 50 03 07 fe 00 00 6b 00 86 00 ab 0c c4 03 07 ff 00 00 62 00 8b 00 5e 0c c8 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.012118 64 02 d2 00 92 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 13.013111 64 02 a5 d4 92 00 f9 38 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 13.031224 50 03 07 fe 00 00 6d 00 86 00 a5 0c c6 03 07 ff 00 00 61 00 86 00 57 0c c8 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.032057 64 02 0f 16 c1 92 00 13 02 74 6f 75 63 68 64 65 74 65 63 74 65 64 3d 79 65 73 0d 67 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 13.040112 50 03 07 fe 00 00 6d 00 85 00 88 0c d6 03 07 ff 00 00 63 00 83 00 37 0c d2 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.048109 50 03 07 fe 00 00 6e 00 85 00 7f 0c dd 03 07 ff 00 00 65 00 80 00 2d 0c d7 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.056144 50 03 07 fe 00 00 6f 00 83 00 76 0c e4 03 07 ff 00 00 65 00 82 00 23 0c dd 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.065410 50 03 07 fe 00 00 6f 00 86 00 6d 0c ed 03 07 ff 00 00 65 00 83 00 18 0c e2 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.073099 50 03 07 fe 00 00 71 00 83 00 63 0c f7 03 07 ff 00 00 65 00 85 00 0c 0c e8 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.081095 50 03 07 fe 00 00 6d 00 83 00 59 0c ff 03 07 ff 00 00 65 00 80 00 01 0c ef 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.090118 50 03 07 fe 00 00 70 00 84 00 50 0c 09 04 07 ff 00 00 64 00 84 00 f6 0b f8 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.098115 50 03 07 fe 00 00 71 00 83 00 46 0c 14 04 07 ff 00 00 64 00 83 00 eb 0b 01 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.106111 50 03 07 fe 00 00 71 00 87 00 3c 0c 1e 04 07 ff 00 00 64 00 83 00 e0 0b 0b 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.115047 50 03 07 fe 00 00 70 00 85 00 32 0c 28 04 07 ff 00 00 65 00 82 00 d5 0b 15 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.123102 50 03 07 fe 00 00 71 00 81 00 29 0c 33 04 07 ff 00 00 65 00 82 00 ca 0b 1f 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.131171 50 03 07 fe 00 00 71 00 80 00 20 0c 3f 04 07 ff 00 00 64 00 82 00 c0 0b 2b 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.140168 50 03 07 fe 00 00 6c 00 81 00 16 0c 4a 04 07 ff 00 00 64 00 7d 00 b6 0b 37 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.148102 50 03 07 fe 00 00 6e 00 81 00 0d 0c 56 04 07 ff 00 00 63 00 7e 00 ac 0b 44 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.156110 50 03 07 fe 00 00 6c 00 7e 00 04 0c 62 04 07 ff 00 00 66 00 7b 00 a3 0b 51 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.165171 50 03 07 fe 00 00 6c 00 7f 00 fd 0b 6f 04 07 ff 00 00 64 00 7e 00 9a 0b 5d 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.173111 50 03 07 fe 00 00 70 00 7e 00 f6 0b 7a 04 07 ff 00 00 64 00 81 00 92 0b 69 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.181110 50 03 07 fe 00 00 6d 00 7f 00 f0 0b 86 04 07 ff 00 00 64 00 7e 00 8c 0b 76 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.190111 50 03 07 fe 00 00 6f 00 82 00 ec 0b 93 04 07 ff 00 00 64 00 80 00 87 0b 82 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.198064 50 03 07 fe 00 00 70 00 81 00 e8 0b 9e 04 07 ff 00 00 5f 00 84 00 82 0b 8f 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.206176 50 03 07 fe 00 00 70 00 84 00 e5 0b aa 04 07 ff 00 00 60 00 85 00 7e 0b 9b 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.215106 50 03 07 fe 00 00 74 00 82 00 e4 0b b5 04 07 ff 00 00 5f 00 89 00 7c 0b a7 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.223085 50 03 07 fe 00 00 72 00 82 00 e3 0b bd 04 07 ff 00 00 60 00 8d 00 7c 0b b3 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.231103 50 03 07 fe 00 00 6f 00 83 00 e3 0b c6 04 07 ff 00 00 61 00 8b 00 7c 0b bd 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.240073 50 03 07 fe 00 00 70 00 85 00 e4 0b cd 04 07 ff 00 00 61 00 8b 00 7e 0b c7 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.248059 50 03 07 fe 00 00 6e 00 85 00 e8 0b d2 04 07 ff 00 00 61 00 92 00 81 0b d1 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.256081 50 03 07 fe 00 00 6c 00 87 00 ec 0b da 04 07 ff 00 00 62 00 99 00 86 0b db 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.265098 50 03 07 fe 00 00 6b 00 8d 00 f2 0b e1 04 07 ff 00 00 5d 00 9f 00 8b 0b e3 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.273114 50 03 07 fe 00 00 6a 00 93 00 f9 0b e7 04 07 ff 00 00 61 00 a5 00 92 0b eb 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.281388 50 03 07 fe 00 00 68 00 9d 00 01 0c eb 04 07 ff 00 00 5e 00 ad 00 99 0b f0 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.290065 50 03 07 fe 00 00 65 00 a0 00 0a 0c ed 04 07 ff 00 00 60 00 af 00 a2 0b f4 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.298103 50 03 07 fe 00 00 66 00 aa 00 13 0c ef 04 07 ff 00 00 5e 00 b8 00 aa 0b f6 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.307088 50 03 07 fe 00 00 67 00 ae 00 1c 0c ee 04 07 ff 00 00 60 00 c0 00 b2 0b f6 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.315108 50 03 07 fe 00 00 65 00 b4 00 25 0c ec 04 07 ff 00 00 5f 00 c2 00 bb 0b f4 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.323108 50 03 07 fe 00 00 64 00 b6 00 2e 0c e8 04 07 ff 00 00 64 00 c2 00 c4 0b f1 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.332063 50 03 07 fe 00 00 65 00 b9 00 36 0c e2 04 07 ff 00 00 60 00 c8 00 cd 0b eb 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.340062 50 03 07 fe 00 00 65 00 c1 00 40 0c da 04 07 ff 00 00 64 00 ca 00 d7 0b e3 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.348106 50 03 07 fe 00 00 62 00 c7 00 4a 0c ce 04 07 ff 00 00 5f 00 d2 00 df 0b d9 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.357076 50 03 07 fe 00 00 62 00 cf 00 54 0c c3 04 07 ff 00 00 5f 00 d7 00 e9 0b cc 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.365101 50 03 07 fe 00 00 63 00 d0 00 5d 0c b6 04 07 ff 00 00 60 00 d7 00 f2 0b bd 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.373127 50 03 07 fe 00 00 63 00 d3 00 66 0c a8 04 07 ff 00 00 61 00 d9 00 fb 0b ad 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.382125 50 03 07 fe 00 00 64 00 d9 00 6e 0c 97 04 07 ff 00 00 5f 00 de 00 02 0c 99 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.390079 50 03 07 fe 00 00 62 00 96 00 77 0c 86 04 07 ff 00 00 5d 00 e3 00 09 0c 88 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.398058 50 03 07 fe 00 00 61 00 93 00 7e 0c 74 04 07 ff 00 00 59 00 e8 00 0e 0c 73 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.407078 50 03 07 fe 00 00 61 00 94 00 84 0c 62 04 07 ff 00 00 60 00 e6 00 17 0c 61 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.415132 50 03 07 fe 00 00 61 00 95 00 89 0c 4f 04 07 ff 00 00 5e 00 e4 00 1c 0c 4c 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.423075 50 03 07 fe 00 00 5e 00 92 00 8d 0c 3b 04 07 ff 00 00 5d 00 e3 00 21 0c 39 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.432038 50 03 07 fe 00 00 5d 00 90 00 90 0c 28 04 07 ff 00 00 5c 00 e9 00 22 0c 24 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.440062 50 03 07 fe 00 00 5d 00 91 00 91 0c 14 04 07 ff 00 00 5c 00 e7 00 26 0c 10 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.448124 50 03 07 fe 00 00 5d 00 93 00 92 0c 02 04 07 ff 00 00 5d 00 e3 00 29 0c fb 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.457124 50 03 07 fe 00 00 5c 00 df 00 94 0c f0 03 07 ff 00 00 5c 00 e3 00 2a 0c e7 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.465118 50 03 07 fe 00 00 5c 00 dc 00 94 0c dd 03 07 ff 00 00 5c 00 e0 00 2b 0c d5 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.473044 50 03 07 fe 00 00 5b 00 d8 00 93 0c ce 03 07 ff 00 00 5b 00 e1 00 2b 0c c5 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.482028 50 03 07 fe 00 00 5a 00 dc 00 93 0c bd 03 07 ff 00 00 59 00 e5 00 2a 0c b6 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.490035 50 03 07 fe 00 00 5d 00 d7 00 90 0c b1 03 07 ff 00 00 59 00 e1 00 2a 0c aa 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.498088 50 03 07 fe 00 00 5c 00 d7 00 8f 0c a5 03 07 ff 00 00 58 00 e4 00 29 0c a1 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.512091 64 02 d2 00 92 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 13.513078 64 02 a5 d4 92 00 f9 38 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 13.526070 64 02 0f 16 c1 92 00 13 02 74 6f 75 63 68 64 65 74 65 63 74 65 64 3d 79 65 73 0d 67 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 13.532109 50 03 07 fe 00 00 5b 00 d7 00 8e 0c 9c 03 07 ff 00 00 5a 00 e0 00 28 0c 96 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.540111 50 03 07 fe 00 00 55 00 d9 00 84 0c 7b 03 07 ff 00 00 57 00 e2 00 20 0c 80 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.548114 50 03 07 fe 00 00 55 00 d5 00 80 0c 77 03 07 ff 00 00 57 00 dd 00 1d 0c 7c 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.557042 50 03 07 fe 00 00 55 00 cf 00 7a 0c 76 03 07 ff 00 00 56 00 de 00 15 0c 76 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.565016 50 03 07 fe 00 00 52 00 be 00 73 0c 79 03 07 ff 00 00 56 00 cc 00 10 0c 70 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.573045 50 03 07 fe 00 00 52 00 be 00 73 0c 79 03 07 ff 00 00 53 00 be 00 09 0c 70 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.582032 50 03 07 fe 00 00 52 00 be 00 73 0c 79 03 07 ff 00 00 52 00 a2 00 00 0c 74 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.590062 50 03 07 fe 00 00 52 00 be 00 73 0c 79 03 07 ff 00 00 52 00 a2 00 00 0c 74 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.598100 50 03 00 fe 00 00 00 00 00 00 73 0c 79 03 07 ff 00 00 52 00 a2 00 00 0c 74 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
E: 13.606027 50 03 00 ff 00 00 00 00 00 00 00 0c 74 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
E: 14.011989 64 02 d2 00 92 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 14.012979 64 02 a5 d4 92 00 f9 38 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 14.025240 64 02 0f 16 c1 92 00 13 02 74 6f 75 63 68 64 65 74 65 63 74 65 64 3d 79 65 73 0d 67 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 14.500966 64 02 d2 00 92 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 14.501953 64 02 a5 d4 92 00 f9 38 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 15.000900 64 02 d2 00 92 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 15.001886 64 02 a5 d4 92 00 f9 38 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 15.500833 64 02 d2 00 92 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 15.501819 64 02 a5 d4 92 00 f9 38 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 16.011763 64 02 d2 00 92 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 16.012749 64 02 a5 d4 92 00 f9 38 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 16.024716 64 02 0f 16 c1 92 00 13 02 74 6f 75 63 68 64 65 74 65 63 74 65 64 3d 79 65 73 0d 67 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 16.500671 64 02 d2 00 92 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 16.501659 64 02 a5 d4 92 00 f9 38 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 17.000600 64 02 d2 00 92 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 17.001591 64 02 a5 d4 92 00 f9 38 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 17.501554 64 02 d2 00 92 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 17.502538 64 02 a5 d4 92 00 f9 38 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 18.001468 64 02 d2 00 92 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 18.002471 64 02 a5 d4 92 00 f9 38 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 18.501384 64 02 d2 00 92 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 18.502376 64 02 a5 d4 92 00 f9 38 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

-Brent

On Fri, Jun 19, 2015 at 10:54 AM, Brent Adam <brentadamdev@gmail.com> wrote:
> From: Brent Adam [mailto:brentadamdev@gmail.com]
> Sent: June-19-15 10:54 AM
> To: jkosina@suse.cz; benjamin.tissoires@gmail.com
> Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; Brent Adam
> Subject: [PATCH v2] USB: HID: Fix fields from pen report ID being interpreted
> for multitouch.
> 
> Fields like HID_DG_CONTACTCOUNT are outside of the physical collection,
> but within the application collection and report ID.  Make sure to catch those
> fields that are not part of the mt_report_id and return 0 so they can be
> processed with the pen.  Otherwise, the wrong HID_DG_CONTACTCOUNT
> will be applied to cc_index and result in dereferencing a null pointer in
> mt_touch_report.
> 
> Signed-off-by: Brent Adam <brentadam@smarttech.com>
> ---
>  drivers/hid/hid-multitouch.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c index
> 6a9b05b..7c81125 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -778,9 +778,16 @@ static int mt_input_mapping(struct hid_device
> *hdev, struct hid_input *hi,
>  	/*
>  	 * some egalax touchscreens have "application ==
> HID_DG_TOUCHSCREEN"
>  	 * for the stylus.
> +	 * The check for mt_report_id ensures we don't process
> +	 * HID_DG_CONTACTCOUNT from the pen report as it is outside the
> physical
> +	 * collection, but within the report ID.
>  	 */
>  	if (field->physical == HID_DG_STYLUS)
>  		return 0;
> +	else if ((field->physical == 0) &&
> +		 (field->report->id != td->mt_report_id) &&
> +		 (td->mt_report_id != -1))
> +		return 0;
> 
>  	if (field->application == HID_DG_TOUCHSCREEN ||
>  	    field->application == HID_DG_TOUCHPAD)
> --
> 2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-input" in
