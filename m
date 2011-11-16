From: Cedric Sodhi <manday@gmx.net>
Subject: Re: HID: Dead ./debug/hid/xxx/events
Date: Wed, 16 Nov 2011 21:48:39 +0100
Message-ID: <20111116204759.GA2153@slate>
References: <20111116095030.GC3335@slate>
 <CAN+gG=F2aFTkhUVp4Sf8p-PdAj5ft1eotuWbnP=WaYAugA8tVw@mail.gmail.com>
 <20111116102514.GA3831@slate>
 <CAGzDe_bdyvOnMJb12gQN9wPSn_dk-g_HxgkEP-x_3DRtB+gP1g@mail.gmail.com>
 <20111116145518.GA7080@slate>
 <20111116154049.GA8444@slate>
 <CAGzDe_ahR9pVkZa8BQkfCq2zeVCojkX=t6WBcQYkrv3z91fb+Q@mail.gmail.com>
 <4EC3EC63.4020700@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qcHopEYAB45HaUaB"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:52336 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752021Ab1KPUtF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Nov 2011 15:49:05 -0500
Content-Disposition: inline
In-Reply-To: <4EC3EC63.4020700@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Chris Bagwell <chris@cnpbagwell.com>, linux-input@vger.kernel.org, linuxwacom-devel@lists.sourceforge.net


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Dear Benjamin,

I applied your patch tp 3.2-jikos (uname shows 3.1, though). The
diff to jikos' original is now [attached].

Chris says the output of evtest still signifies problems with
multitouch:

> > http://ompldr.org/iYmIzYw
>
> Cedric, can you send these logs to Benjamin for ideas?  The HID events
> look good but the evtest log for 2 fingers is not.  The two touches
> are fighting each other.  That "-1" value is interrupted as each
> finger is being lifted in between each new X/Y report.
> 
> Also, can you send me and Benjamin the source code diff of what your
> testing against kernel tree?
> 
> The behavior in your evtest log looks like what would happen if your
> setting the MT_QUIRK_NOT_SEEN_MEANS_UP.  Since your HW only sends 1
> fingers worth of data per packet, you do not want that quirk.
> 
> I'll still hold off on xf86-input-wacom issues until the events coming
> are sane.  Your current events will cause xf86-input-wacom to do all
> kinds of weird stuff thats not worth effort to weed threw.
> 
> Chris

These logs in that tarfile were created while still manually adding the
ID via your sysfs interface. You find yet another evtest log for
two-finger touch attached.

Cedric

--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="evtest_twofinger.log"

Input driver version is 1.0.1
Input device ID: bus 0x3 vendor 0xeef product 0xa001 version 0x210
Input device name: "eGalax_eMPIA Technology Inc. PCAP MultiTouch Controller"
Supported events:
  Event type 0 (Sync)
  Event type 1 (Key)
    Event code 330 (Touch)
  Event type 3 (Absolute)
    Event code 0 (X)
      Value  23408
      Min        0
      Max    32767
      Fuzz       7
    Event code 1 (Y)
      Value  19664
      Min        0
      Max    32767
      Fuzz       7
    Event code 47 (Slot)
      Value      0
      Min        0
      Max        9
    Event code 53 (Position X)
      Value      0
      Min        0
      Max    32767
      Fuzz       7
    Event code 54 (Position Y)
      Value      0
      Min        0
      Max    32767
      Fuzz       7
    Event code 57 (Tracking ID)
      Value      0
      Min        0
      Max    65535
Testing ... (interrupt to exit)
Event: time 1321475730.593802, type 3 (Absolute), code 57 (Tracking ID), value 7
Event: time 1321475730.593804, type 3 (Absolute), code 53 (Position X), value 19920
Event: time 1321475730.593804, type 3 (Absolute), code 54 (Position Y), value 18048
Event: time 1321475730.593815, type 1 (Key), code 330 (Touch), value 1
Event: time 1321475730.593817, type 3 (Absolute), code 0 (X), value 19920
Event: time 1321475730.593818, type 3 (Absolute), code 1 (Y), value 18048
Event: time 1321475730.593818, -------------- Report Sync ------------
Event: time 1321475730.641804, type 3 (Absolute), code 47 (Slot), value 1
Event: time 1321475730.641805, type 3 (Absolute), code 57 (Tracking ID), value 8
Event: time 1321475730.641806, type 3 (Absolute), code 53 (Position X), value 20544
Event: time 1321475730.641807, type 3 (Absolute), code 54 (Position Y), value 9504
Event: time 1321475730.641819, -------------- Report Sync ------------
Event: time 1321475730.816799, type 3 (Absolute), code 47 (Slot), value 0
Event: time 1321475730.816799, type 3 (Absolute), code 53 (Position X), value 19888
Event: time 1321475730.816800, type 3 (Absolute), code 54 (Position Y), value 18032
Event: time 1321475730.816815, type 3 (Absolute), code 0 (X), value 19888
Event: time 1321475730.816815, type 3 (Absolute), code 1 (Y), value 18032
Event: time 1321475730.816816, -------------- Report Sync ------------
Event: time 1321475730.823797, type 3 (Absolute), code 53 (Position X), value 19872
Event: time 1321475730.823798, type 3 (Absolute), code 54 (Position Y), value 18016
Event: time 1321475730.823813, type 3 (Absolute), code 0 (X), value 19872
Event: time 1321475730.823813, type 3 (Absolute), code 1 (Y), value 18016
Event: time 1321475730.823814, -------------- Report Sync ------------
Event: time 1321475730.830799, type 3 (Absolute), code 53 (Position X), value 19856
Event: time 1321475730.830815, type 3 (Absolute), code 0 (X), value 19856
Event: time 1321475730.830816, -------------- Report Sync ------------
Event: time 1321475730.837798, type 3 (Absolute), code 53 (Position X), value 19840
Event: time 1321475730.837814, type 3 (Absolute), code 0 (X), value 19840
Event: time 1321475730.837815, -------------- Report Sync ------------
Event: time 1321475730.851796, type 3 (Absolute), code 53 (Position X), value 19808
Event: time 1321475730.851797, type 3 (Absolute), code 54 (Position Y), value 18000
Event: time 1321475730.851812, type 3 (Absolute), code 0 (X), value 19808
Event: time 1321475730.851812, type 3 (Absolute), code 1 (Y), value 18000
Event: time 1321475730.851813, -------------- Report Sync ------------
Event: time 1321475730.858792, type 3 (Absolute), code 53 (Position X), value 19792
Event: time 1321475730.858792, type 3 (Absolute), code 54 (Position Y), value 17984
Event: time 1321475730.858807, type 3 (Absolute), code 0 (X), value 19792
Event: time 1321475730.858808, type 3 (Absolute), code 1 (Y), value 17984
Event: time 1321475730.858809, -------------- Report Sync ------------
Event: time 1321475730.866782, type 3 (Absolute), code 53 (Position X), value 19776
Event: time 1321475730.866798, type 3 (Absolute), code 0 (X), value 19776
Event: time 1321475730.866799, -------------- Report Sync ------------
Event: time 1321475730.873779, type 3 (Absolute), code 53 (Position X), value 19760
Event: time 1321475730.873795, type 3 (Absolute), code 0 (X), value 19760
Event: time 1321475730.873796, -------------- Report Sync ------------
Event: time 1321475730.908793, type 3 (Absolute), code 53 (Position X), value 19744
Event: time 1321475730.908794, type 3 (Absolute), code 54 (Position Y), value 17968
Event: time 1321475730.908809, type 3 (Absolute), code 0 (X), value 19744
Event: time 1321475730.908810, type 3 (Absolute), code 1 (Y), value 17968
Event: time 1321475730.908811, -------------- Report Sync ------------
Event: time 1321475730.915792, type 3 (Absolute), code 53 (Position X), value 19728
Event: time 1321475730.915793, type 3 (Absolute), code 54 (Position Y), value 17952
Event: time 1321475730.915808, type 3 (Absolute), code 0 (X), value 19728
Event: time 1321475730.915808, type 3 (Absolute), code 1 (Y), value 17952
Event: time 1321475730.915809, -------------- Report Sync ------------
Event: time 1321475730.922798, type 3 (Absolute), code 53 (Position X), value 19712
Event: time 1321475730.922799, type 3 (Absolute), code 54 (Position Y), value 17936
Event: time 1321475730.922814, type 3 (Absolute), code 0 (X), value 19712
Event: time 1321475730.922814, type 3 (Absolute), code 1 (Y), value 17936
Event: time 1321475730.922815, -------------- Report Sync ------------
Event: time 1321475730.929798, type 3 (Absolute), code 53 (Position X), value 19696
Event: time 1321475730.929814, type 3 (Absolute), code 0 (X), value 19696
Event: time 1321475730.929815, -------------- Report Sync ------------
Event: time 1321475730.951802, type 3 (Absolute), code 47 (Slot), value 1
Event: time 1321475730.951802, type 3 (Absolute), code 53 (Position X), value 20528
Event: time 1321475730.951803, type 3 (Absolute), code 54 (Position Y), value 9472
Event: time 1321475730.951815, -------------- Report Sync ------------
Event: time 1321475730.958847, type 3 (Absolute), code 54 (Position Y), value 9456
Event: time 1321475730.958873, -------------- Report Sync ------------
Event: time 1321475730.965844, type 3 (Absolute), code 54 (Position Y), value 9440
Event: time 1321475730.965869, -------------- Report Sync ------------
Event: time 1321475730.972801, type 3 (Absolute), code 54 (Position Y), value 9424
Event: time 1321475730.972814, -------------- Report Sync ------------
Event: time 1321475731.565796, type 3 (Absolute), code 53 (Position X), value 20512
Event: time 1321475731.565797, type 3 (Absolute), code 54 (Position Y), value 9408
Event: time 1321475731.565810, -------------- Report Sync ------------
Event: time 1321475731.572802, type 3 (Absolute), code 54 (Position Y), value 9392
Event: time 1321475731.572815, -------------- Report Sync ------------
Event: time 1321475731.579802, type 3 (Absolute), code 54 (Position Y), value 9360
Event: time 1321475731.579815, -------------- Report Sync ------------
Event: time 1321475731.586810, type 3 (Absolute), code 54 (Position Y), value 9344
Event: time 1321475731.586823, -------------- Report Sync ------------
Event: time 1321475732.141800, type 3 (Absolute), code 47 (Slot), value 0
Event: time 1321475732.141800, type 3 (Absolute), code 54 (Position Y), value 17904
Event: time 1321475732.141816, type 3 (Absolute), code 1 (Y), value 17904
Event: time 1321475732.141816, -------------- Report Sync ------------
Event: time 1321475732.156793, type 3 (Absolute), code 53 (Position X), value 19728
Event: time 1321475732.156809, type 3 (Absolute), code 0 (X), value 19728
Event: time 1321475732.156810, -------------- Report Sync ------------
Event: time 1321475732.163798, type 3 (Absolute), code 53 (Position X), value 19744
Event: time 1321475732.163814, type 3 (Absolute), code 0 (X), value 19744
Event: time 1321475732.163815, -------------- Report Sync ------------
Event: time 1321475732.164802, type 3 (Absolute), code 47 (Slot), value 1
Event: time 1321475732.164803, type 3 (Absolute), code 53 (Position X), value 20528
Event: time 1321475732.164816, -------------- Report Sync ------------
Event: time 1321475732.170779, type 3 (Absolute), code 47 (Slot), value 0
Event: time 1321475732.170779, type 3 (Absolute), code 53 (Position X), value 19776
Event: time 1321475732.170794, type 3 (Absolute), code 0 (X), value 19776
Event: time 1321475732.170796, -------------- Report Sync ------------
Event: time 1321475732.171795, type 3 (Absolute), code 47 (Slot), value 1
Event: time 1321475732.171796, type 3 (Absolute), code 53 (Position X), value 20560
Event: time 1321475732.171809, -------------- Report Sync ------------
Event: time 1321475732.177799, type 3 (Absolute), code 47 (Slot), value 0
Event: time 1321475732.177799, type 3 (Absolute), code 53 (Position X), value 19808
Event: time 1321475732.177815, type 3 (Absolute), code 0 (X), value 19808
Event: time 1321475732.177816, -------------- Report Sync ------------
Event: time 1321475732.178802, type 3 (Absolute), code 47 (Slot), value 1
Event: time 1321475732.178802, type 3 (Absolute), code 53 (Position X), value 20592
Event: time 1321475732.178815, -------------- Report Sync ------------
Event: time 1321475732.184800, type 3 (Absolute), code 47 (Slot), value 0
Event: time 1321475732.184801, type 3 (Absolute), code 53 (Position X), value 19840
Event: time 1321475732.184816, type 3 (Absolute), code 0 (X), value 19840
Event: time 1321475732.184817, -------------- Report Sync ------------
Event: time 1321475732.185830, type 3 (Absolute), code 47 (Slot), value 1
Event: time 1321475732.185831, type 3 (Absolute), code 53 (Position X), value 20608
Event: time 1321475732.185857, -------------- Report Sync ------------
Event: time 1321475732.191847, type 3 (Absolute), code 47 (Slot), value 0
Event: time 1321475732.191848, type 3 (Absolute), code 53 (Position X), value 19856
Event: time 1321475732.191879, type 3 (Absolute), code 0 (X), value 19856
Event: time 1321475732.191882, -------------- Report Sync ------------
Event: time 1321475732.192801, type 3 (Absolute), code 47 (Slot), value 1
Event: time 1321475732.192802, type 3 (Absolute), code 53 (Position X), value 20640
Event: time 1321475732.192828, -------------- Report Sync ------------
Event: time 1321475732.198813, type 3 (Absolute), code 47 (Slot), value 0
Event: time 1321475732.198813, type 3 (Absolute), code 53 (Position X), value 19888
Event: time 1321475732.198828, type 3 (Absolute), code 0 (X), value 19888
Event: time 1321475732.198830, -------------- Report Sync ------------
Event: time 1321475732.199795, type 3 (Absolute), code 47 (Slot), value 1
Event: time 1321475732.199796, type 3 (Absolute), code 53 (Position X), value 20656
Event: time 1321475732.199809, -------------- Report Sync ------------
Event: time 1321475732.205853, type 3 (Absolute), code 47 (Slot), value 0
Event: time 1321475732.205854, type 3 (Absolute), code 53 (Position X), value 19904
Event: time 1321475732.205885, type 3 (Absolute), code 0 (X), value 19904
Event: time 1321475732.205888, -------------- Report Sync ------------
Event: time 1321475732.206837, type 3 (Absolute), code 47 (Slot), value 1
Event: time 1321475732.206838, type 3 (Absolute), code 53 (Position X), value 20672
Event: time 1321475732.206864, -------------- Report Sync ------------
Event: time 1321475732.212781, type 3 (Absolute), code 47 (Slot), value 0
Event: time 1321475732.212782, type 3 (Absolute), code 53 (Position X), value 19920
Event: time 1321475732.212797, type 3 (Absolute), code 0 (X), value 19920
Event: time 1321475732.212798, -------------- Report Sync ------------
Event: time 1321475732.213782, type 3 (Absolute), code 47 (Slot), value 1
Event: time 1321475732.213782, type 3 (Absolute), code 53 (Position X), value 20688
Event: time 1321475732.213796, -------------- Report Sync ------------
Event: time 1321475732.219799, type 3 (Absolute), code 47 (Slot), value 0
Event: time 1321475732.219799, type 3 (Absolute), code 53 (Position X), value 19936
Event: time 1321475732.219815, type 3 (Absolute), code 0 (X), value 19936
Event: time 1321475732.219816, -------------- Report Sync ------------
Event: time 1321475732.220838, type 3 (Absolute), code 47 (Slot), value 1
Event: time 1321475732.220839, type 3 (Absolute), code 53 (Position X), value 20704
Event: time 1321475732.220865, -------------- Report Sync ------------
Event: time 1321475732.233800, type 3 (Absolute), code 47 (Slot), value 0
Event: time 1321475732.233800, type 3 (Absolute), code 53 (Position X), value 19984
Event: time 1321475732.233801, type 3 (Absolute), code 54 (Position Y), value 17936
Event: time 1321475732.233816, type 3 (Absolute), code 0 (X), value 19984
Event: time 1321475732.233816, type 3 (Absolute), code 1 (Y), value 17936
Event: time 1321475732.233817, -------------- Report Sync ------------
Event: time 1321475732.240799, type 3 (Absolute), code 53 (Position X), value 20016
Event: time 1321475732.240800, type 3 (Absolute), code 54 (Position Y), value 17952
Event: time 1321475732.240815, type 3 (Absolute), code 0 (X), value 20016
Event: time 1321475732.240816, type 3 (Absolute), code 1 (Y), value 17952
Event: time 1321475732.240817, -------------- Report Sync ------------
Event: time 1321475732.247793, type 3 (Absolute), code 53 (Position X), value 20032
Event: time 1321475732.247809, type 3 (Absolute), code 0 (X), value 20032
Event: time 1321475732.247810, -------------- Report Sync ------------
Event: time 1321475732.254799, type 3 (Absolute), code 53 (Position X), value 20048
Event: time 1321475732.254814, type 3 (Absolute), code 0 (X), value 20048
Event: time 1321475732.254815, -------------- Report Sync ------------
Event: time 1321475732.255797, type 3 (Absolute), code 47 (Slot), value 1
Event: time 1321475732.255797, type 3 (Absolute), code 53 (Position X), value 20720
Event: time 1321475732.255798, type 3 (Absolute), code 54 (Position Y), value 9360
Event: time 1321475732.255811, -------------- Report Sync ------------
Event: time 1321475732.261798, type 3 (Absolute), code 47 (Slot), value 0
Event: time 1321475732.261798, type 3 (Absolute), code 53 (Position X), value 20064
Event: time 1321475732.261814, type 3 (Absolute), code 0 (X), value 20064
Event: time 1321475732.261815, -------------- Report Sync ------------
Event: time 1321475732.262802, type 3 (Absolute), code 47 (Slot), value 1
Event: time 1321475732.262802, type 3 (Absolute), code 53 (Position X), value 20784
Event: time 1321475732.262803, type 3 (Absolute), code 54 (Position Y), value 9424
Event: time 1321475732.262815, -------------- Report Sync ------------
Event: time 1321475732.269801, type 3 (Absolute), code 53 (Position X), value 20816
Event: time 1321475732.269802, type 3 (Absolute), code 54 (Position Y), value 9440
Event: time 1321475732.269815, -------------- Report Sync ------------
Event: time 1321475732.277783, type 3 (Absolute), code 53 (Position X), value 20832
Event: time 1321475732.277784, type 3 (Absolute), code 54 (Position Y), value 9456
Event: time 1321475732.277797, -------------- Report Sync ------------
Event: time 1321475732.285839, type 3 (Absolute), code 53 (Position X), value 20864
Event: time 1321475732.285840, type 3 (Absolute), code 54 (Position Y), value 9472
Event: time 1321475732.285852, -------------- Report Sync ------------
Event: time 1321475732.290780, type 3 (Absolute), code 47 (Slot), value 0
Event: time 1321475732.290780, type 3 (Absolute), code 53 (Position X), value 20128
Event: time 1321475732.290781, type 3 (Absolute), code 54 (Position Y), value 17968
Event: time 1321475732.290796, type 3 (Absolute), code 0 (X), value 20128
Event: time 1321475732.290796, type 3 (Absolute), code 1 (Y), value 17968
Event: time 1321475732.290797, -------------- Report Sync ------------
Event: time 1321475732.297799, type 3 (Absolute), code 53 (Position X), value 20160
Event: time 1321475732.297814, type 3 (Absolute), code 0 (X), value 20160
Event: time 1321475732.297815, -------------- Report Sync ------------
Event: time 1321475732.298802, type 3 (Absolute), code 47 (Slot), value 1
Event: time 1321475732.298803, type 3 (Absolute), code 53 (Position X), value 20944
Event: time 1321475732.298803, type 3 (Absolute), code 54 (Position Y), value 9536
Event: time 1321475732.298816, -------------- Report Sync ------------
Event: time 1321475732.304804, type 3 (Absolute), code 47 (Slot), value 0
Event: time 1321475732.304804, type 3 (Absolute), code 53 (Position X), value 20192
Event: time 1321475732.304805, type 3 (Absolute), code 54 (Position Y), value 17984
Event: time 1321475732.304820, type 3 (Absolute), code 0 (X), value 20192
Event: time 1321475732.304820, type 3 (Absolute), code 1 (Y), value 17984
Event: time 1321475732.304821, -------------- Report Sync ------------
Event: time 1321475732.305802, type 3 (Absolute), code 47 (Slot), value 1
Event: time 1321475732.305802, type 3 (Absolute), code 53 (Position X), value 20960
Event: time 1321475732.305803, type 3 (Absolute), code 54 (Position Y), value 9552
Event: time 1321475732.305815, -------------- Report Sync ------------
Event: time 1321475732.311799, type 3 (Absolute), code 47 (Slot), value 0
Event: time 1321475732.311799, type 3 (Absolute), code 53 (Position X), value 20208
Event: time 1321475732.311814, type 3 (Absolute), code 0 (X), value 20208
Event: time 1321475732.311816, -------------- Report Sync ------------
Event: time 1321475732.312853, type 3 (Absolute), code 47 (Slot), value 1
Event: time 1321475732.312854, type 3 (Absolute), code 53 (Position X), value 20976
Event: time 1321475732.312856, type 3 (Absolute), code 54 (Position Y), value 9568
Event: time 1321475732.312881, -------------- Report Sync ------------
Event: time 1321475732.318818, type 3 (Absolute), code 47 (Slot), value 0
Event: time 1321475732.318818, type 3 (Absolute), code 53 (Position X), value 20224
Event: time 1321475732.318834, type 3 (Absolute), code 0 (X), value 20224
Event: time 1321475732.318835, -------------- Report Sync ------------
Event: time 1321475732.319802, type 3 (Absolute), code 47 (Slot), value 1
Event: time 1321475732.319802, type 3 (Absolute), code 53 (Position X), value 20992
Event: time 1321475732.319816, -------------- Report Sync ------------
Event: time 1321475732.423792, type 3 (Absolute), code 47 (Slot), value 0
Event: time 1321475732.423793, type 3 (Absolute), code 53 (Position X), value 20256
Event: time 1321475732.423808, type 3 (Absolute), code 0 (X), value 20256
Event: time 1321475732.423810, -------------- Report Sync ------------
Event: time 1321475732.424853, type 3 (Absolute), code 47 (Slot), value 1
Event: time 1321475732.424854, type 3 (Absolute), code 53 (Position X), value 21024
Event: time 1321475732.424856, type 3 (Absolute), code 54 (Position Y), value 9584
Event: time 1321475732.424881, -------------- Report Sync ------------
Event: time 1321475732.431813, type 3 (Absolute), code 47 (Slot), value 0
Event: time 1321475732.431813, type 3 (Absolute), code 53 (Position X), value 20272
Event: time 1321475732.431828, type 3 (Absolute), code 0 (X), value 20272
Event: time 1321475732.431830, -------------- Report Sync ------------
Event: time 1321475732.433834, type 3 (Absolute), code 47 (Slot), value 1
Event: time 1321475732.433834, type 3 (Absolute), code 53 (Position X), value 21040
Event: time 1321475732.433847, -------------- Report Sync ------------
Event: time 1321475732.438799, type 3 (Absolute), code 47 (Slot), value 0
Event: time 1321475732.438799, type 3 (Absolute), code 53 (Position X), value 20288
Event: time 1321475732.438815, type 3 (Absolute), code 0 (X), value 20288
Event: time 1321475732.438816, -------------- Report Sync ------------
Event: time 1321475732.440797, type 3 (Absolute), code 47 (Slot), value 1
Event: time 1321475732.440798, type 3 (Absolute), code 53 (Position X), value 21056
Event: time 1321475732.440811, -------------- Report Sync ------------
Event: time 1321475732.446802, type 3 (Absolute), code 53 (Position X), value 21072
Event: time 1321475732.446815, -------------- Report Sync ------------
Event: time 1321475732.452804, type 3 (Absolute), code 47 (Slot), value 0
Event: time 1321475732.452804, type 3 (Absolute), code 53 (Position X), value 20304
Event: time 1321475732.452820, type 3 (Absolute), code 0 (X), value 20304
Event: time 1321475732.452821, -------------- Report Sync --------
--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="diff_jikos_new.patch"

--- hid-multitouch.c-orig	2011-11-16 21:42:52.000000000 +0100
+++ /usr/src/linux/drivers/hid/hid-multitouch.c	2011-11-16 20:55:01.000000000 +0100
@@ -60,9 +60,19 @@
 	bool seen_in_this_frame;/* has this slot been updated */
 };
 
+struct mt_class {
+	__s32 name;	/* MT_CLS */
+	__s32 quirks;
+	__s32 sn_move;	/* Signal/noise ratio for move events */
+	__s32 sn_width;	/* Signal/noise ratio for width events */
+	__s32 sn_height;	/* Signal/noise ratio for height events */
+	__s32 sn_pressure;	/* Signal/noise ratio for pressure events */
+	__u8 maxcontacts;
+};
+
 struct mt_device {
 	struct mt_slot curdata;	/* placeholder of incoming data */
-	struct mt_class *mtclass;	/* our mt device class */
+	struct mt_class mtclass;	/* our mt device class */
 	unsigned last_field_index;	/* last field index of the report */
 	unsigned last_slot_field;	/* the last field of a slot */
 	int last_mt_collection;	/* last known mt-related collection */
@@ -74,16 +84,6 @@
 	struct mt_slot *slots;
 };
 
-struct mt_class {
-	__s32 name;	/* MT_CLS */
-	__s32 quirks;
-	__s32 sn_move;	/* Signal/noise ratio for move events */
-	__s32 sn_width;	/* Signal/noise ratio for width events */
-	__s32 sn_height;	/* Signal/noise ratio for height events */
-	__s32 sn_pressure;	/* Signal/noise ratio for pressure events */
-	__u8 maxcontacts;
-};
-
 /* classes of device behavior */
 #define MT_CLS_DEFAULT				0x0001
 
@@ -98,6 +98,7 @@
 #define MT_CLS_3M				0x0101
 #define MT_CLS_CYPRESS				0x0102
 #define MT_CLS_EGALAX				0x0103
+#define MT_CLS_EGALAX_SERIAL			0x0104
 
 #define MT_DEFAULT_MAXCONTACT	10
 
@@ -177,10 +178,97 @@
 		.sn_move = 4096,
 		.sn_pressure = 32,
 	},
+	{ .name = MT_CLS_EGALAX_SERIAL,
+		.quirks = MT_QUIRK_SLOT_IS_CONTACTID |
+			MT_QUIRK_ALWAYS_VALID,
+		.sn_move = 4096,
+		.sn_pressure = 32
+	},
 
 	{ }
 };
 
+static ssize_t mt_show_quirks(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct mt_device *td = hid_get_drvdata(hdev);
+
+	return sprintf(buf, "%u\n", td->mtclass.quirks);
+}
+
+static ssize_t mt_set_quirks(struct device *dev,
+			  struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct mt_device *td = hid_get_drvdata(hdev);
+
+	unsigned long val;
+
+	if (strict_strtoul(buf, 0, &val))
+		return -EINVAL;
+
+	td->mtclass.quirks = val;
+
+	return count;
+}
+
+static DEVICE_ATTR(quirks, S_IWUSR | S_IRUGO, mt_show_quirks, mt_set_quirks);
+
+static ssize_t mt_show_class(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct mt_device *td = hid_get_drvdata(hdev);
+
+	return sprintf(buf, "0x%x\n", td->mtclass.name);
+}
+
+static ssize_t mt_set_class(struct device *dev,
+			  struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct mt_device *td = hid_get_drvdata(hdev);
+	struct mt_class *mtclass = NULL; /* MT_CLS_DEFAULT */
+	int i;
+
+	unsigned long val;
+
+	if (strict_strtoul(buf, 0, &val))
+		return -EINVAL;
+
+
+	for (i = 0; mt_classes[i].name ; i++) {
+		if (val == mt_classes[i].name) {
+			mtclass = &(mt_classes[i]);
+			break;
+		}
+	}
+
+	if (!mtclass)
+		return -EINVAL;
+
+	td->mtclass = *mtclass;
+
+	return count;
+}
+
+static DEVICE_ATTR(class, S_IWUSR | S_IRUGO, mt_show_class, mt_set_class);
+
+static struct attribute *sysfs_attrs[] = {
+	&dev_attr_quirks.attr,
+	&dev_attr_class.attr,
+	NULL
+};
+
+static struct attribute_group mt_attribute_group = {
+	.attrs = sysfs_attrs
+};
+
 static void mt_feature_mapping(struct hid_device *hdev,
 		struct hid_field *field, struct hid_usage *usage)
 {
@@ -192,9 +280,9 @@
 		break;
 	case HID_DG_CONTACTMAX:
 		td->maxcontacts = field->value[0];
-		if (td->mtclass->maxcontacts)
+		if (td->mtclass.maxcontacts)
 			/* check if the maxcontacts is given by the class */
-			td->maxcontacts = td->mtclass->maxcontacts;
+			td->maxcontacts = td->mtclass.maxcontacts;
 
 		break;
 	}
@@ -214,7 +302,7 @@
 		unsigned long **bit, int *max)
 {
 	struct mt_device *td = hid_get_drvdata(hdev);
-	struct mt_class *cls = td->mtclass;
+	struct mt_class *cls = &td->mtclass;
 	__s32 quirks = cls->quirks;
 
 	/* Only map fields from TouchScreen or TouchPad collections.
@@ -363,7 +451,7 @@
 
 static int mt_compute_slot(struct mt_device *td)
 {
-	__s32 quirks = td->mtclass->quirks;
+	__s32 quirks = td->mtclass.quirks;
 
 	if (quirks & MT_QUIRK_SLOT_IS_CONTACTID)
 		return td->curdata.contactid;
@@ -407,7 +495,7 @@
 
 	for (i = 0; i < td->maxcontacts; ++i) {
 		struct mt_slot *s = &(td->slots[i]);
-		if ((td->mtclass->quirks & MT_QUIRK_NOT_SEEN_MEANS_UP) &&
+		if ((td->mtclass.quirks & MT_QUIRK_NOT_SEEN_MEANS_UP) &&
 			!s->seen_in_this_frame) {
 			s->touch_state = false;
 		}
@@ -444,7 +532,7 @@
 				struct hid_usage *usage, __s32 value)
 {
 	struct mt_device *td = hid_get_drvdata(hid);
-	__s32 quirks = td->mtclass->quirks;
+	__s32 quirks = td->mtclass.quirks;
 
 	if (hid->claimed & HID_CLAIMED_INPUT && td->slots) {
 		switch (usage->hid) {
@@ -552,7 +640,7 @@
 		dev_err(&hdev->dev, "cannot allocate multitouch data\n");
 		return -ENOMEM;
 	}
-	td->mtclass = mtclass;
+	td->mtclass = *mtclass;
 	td->inputmode = -1;
 	td->last_mt_collection = -1;
 	hid_set_drvdata(hdev, td);
@@ -574,6 +662,8 @@
 		goto fail;
 	}
 
+	ret = sysfs_create_group(&hdev->dev.kobj, &mt_attribute_group);
+
 	mt_set_input_mode(hdev);
 
 	return 0;
@@ -594,6 +684,7 @@
 static void mt_remove(struct hid_device *hdev)
 {
 	struct mt_device *td = hid_get_drvdata(hdev);
+	sysfs_remove_group(&hdev->dev.kobj, &mt_attribute_group);
 	hid_hw_stop(hdev);
 	kfree(td->slots);
 	kfree(td);
@@ -662,6 +753,9 @@
 	{  .driver_data = MT_CLS_EGALAX,
 		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
 			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH4) },
+	{  .driver_data = MT_CLS_EGALAX_SERIAL,
+		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
+			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH5) },
 
 	/* Elo TouchSystems IntelliTouch Plus panel */
 	{ .driver_data = MT_CLS_DUAL_NSMU_CONTACTID,

--qcHopEYAB45HaUaB--
